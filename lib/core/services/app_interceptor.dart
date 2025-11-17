import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/usecase/usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../injection_container.dart';
import '../config/constants.dart';
import '../presentation/cubit/language_cubit.dart';
import 'token_storage_service.dart';

class AppInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  AppInterceptor(this.dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final languageCode = sl<LanguageCubit>().state.languageCode;
    options.headers['Accept-Language'] = languageCode;

    if (!kIsWeb) {
      final accessToken = await sl<TokenStorageService>().getAccessToken();
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isAuthEndpoint = err.requestOptions.path == AppConstants.loginUrl ||
        err.requestOptions.path == AppConstants.refreshTokenUrl ||
        err.requestOptions.path == AppConstants.verifyUrl ||
        err.requestOptions.path == AppConstants.logoutUrl;

    if (err.response?.statusCode == 401 && !isAuthEndpoint) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        try {
          // Use the dedicated UseCase now
          final refreshTokenUseCase = sl<RefreshTokenUseCase>();
          final result = await refreshTokenUseCase(NoParams());
          _isRefreshing = false;

          result.fold(
            (failure) {
              sl<AuthBloc>().add(AuthLogoutRequested());
              return handler.reject(err);
            },
            (_) async {
              return handler.resolve(await _retry(err.requestOptions));
            },
          );
        } catch (e) {
          _isRefreshing = false;
          sl<AuthBloc>().add(AuthLogoutRequested());
          return handler.reject(err);
        }
      } else {
        return handler.next(err);
      }
    } else {
      return handler.next(err);
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    if (!kIsWeb) {
      final newAccessToken = await sl<TokenStorageService>().getAccessToken();
      options.headers!['Authorization'] = 'Bearer $newAccessToken';
    }

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
