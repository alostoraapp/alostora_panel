
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/token_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponseModel> login(String email, String password);
  Future<void> verifyToken();
  Future<void> logout();
  Future<TokenResponseModel> refreshToken(String? refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  const AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<TokenResponseModel> login(String email, String password) async {
    final responseData = await _apiClient.post(
      AppConstants.loginUrl,
      data: {'email': email, 'password': password},
    );
    return TokenResponseModel.fromJson(responseData);
  }

  @override
  Future<void> verifyToken() async {
    try {
      await _apiClient.post(AppConstants.verifyUrl);
    } on DioException {
      // This is an expected failure when not logged in. Rethrow to be handled by the repository.
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiClient.post(AppConstants.logoutUrl);
    } on DioException {
      // Logout is best-effort. We can ignore failures here as local tokens will be cleared anyway.
    }
  }

  @override
  Future<TokenResponseModel> refreshToken(String? refreshToken) async {
    final data = kIsWeb ? null : {'refresh': refreshToken};
    final responseData = await _apiClient.post(
      AppConstants.refreshTokenUrl,
      data: data,
    );
    return TokenResponseModel.fromJson(responseData);
  }
}
