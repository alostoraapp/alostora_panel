import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
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
    // --- The CORE of the fix is here ---
    // We check if the failed request is one of the auth endpoints.
    // A 401 on these endpoints is expected when logged out and should NOT trigger a refresh.
    final isAuthEndpoint = err.requestOptions.path == AppConstants.loginUrl ||
        err.requestOptions.path == AppConstants.refreshTokenUrl ||
        err.requestOptions.path == AppConstants.verifyUrl ||
        err.requestOptions.path == AppConstants.logoutUrl;

    if (err.response?.statusCode == 401 && !isAuthEndpoint) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        try {
          final result = await sl<AuthRepository>().refreshToken();
          _isRefreshing = false;

          result.fold(
            (failure) {
              // If refresh fails, the user is truly unauthenticated. Logout.
              sl<AuthBloc>().add(AuthLogoutRequested());
              return handler.reject(err);
            },
            (_) async {
              // Refresh was successful, retry the original request.
              return handler.resolve(await _retry(err.requestOptions));
            },
          );
        } catch (e) {
          _isRefreshing = false;
          sl<AuthBloc>().add(AuthLogoutRequested());
          return handler.reject(err);
        }
      } else {
        // If a refresh is already in progress, just pass the error along
        // as it will be handled by the original refresh flow.
        return handler.next(err);
      }
    } else {
      // If it's not a 401 or it's an auth endpoint, just pass the error.
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
