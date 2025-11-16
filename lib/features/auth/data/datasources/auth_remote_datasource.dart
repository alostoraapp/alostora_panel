
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/error_response_model.dart';
import '../../../../core/error/failure.dart';
import '../models/token_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponseModel> login(String email, String password);
  Future<void> verifyToken();
  Future<void> logout();
  Future<TokenResponseModel> refreshToken(String? refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  const AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<TokenResponseModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        AppConstants.loginUrl,
        data: {
          'email': email,
          'password': password,
        },
      );
      return TokenResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final errorResponse = ErrorResponseModel.fromJson(e.response!.data);
        throw AppException(errorResponse);
      }
      throw ServerFailure(message: e.message ?? 'Network error');
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<void> verifyToken() async {
    try {
      // Corrected to POST as per many token verification schemes
      await dio.post(AppConstants.verifyUrl);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post(AppConstants.logoutUrl);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<TokenResponseModel> refreshToken(String? refreshToken) async {
    try {
      // For mobile, send the refresh token in the body if it exists
      final data = kIsWeb ? null : {'refresh': refreshToken};

      final response = await dio.post(
        AppConstants.refreshTokenUrl,
        data: data,
      );
      return TokenResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        // Corrected typo here
        final errorResponse = ErrorResponseModel.fromJson(e.response!.data);
        throw AppException(errorResponse);
      }
      throw ServerFailure(message: e.message ?? 'Network error');
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
