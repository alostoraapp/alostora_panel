import 'package:dio/dio.dart';

import '../error/app_exception.dart';
import '../error/error_response_model.dart';
import '../error/failure.dart';

/// A centralized API client that wraps Dio and handles common error scenarios.
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  /// Updates the 'Accept-Language' header.
  void updateLanguage(String languageCode) {
    _dio.options.headers['Accept-Language'] = languageCode;
  }

  /// Executes a POST request and handles errors.
  Future<dynamic> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  /// Executes a GET request and handles errors.
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  /// Executes a PATCH request and handles errors.
  Future<dynamic> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.patch(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  /// Executes a DELETE request and handles errors.
  Future<dynamic> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  /// Centralized Dio exception handling.
  void _handleDioException(DioException e) {
    if (e.response != null && e.response!.data is Map<String, dynamic>) {
      final errorResponse = ErrorResponseModel.fromJson(e.response!.data);
      throw AppException(errorResponse);
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.unknown) {
      throw ServerFailure(message: 'Network connection error. Please check your internet.');
    }
    // Rethrow the original exception if it's a 401, 403, etc.
    // The interceptor will handle these specific cases.
    throw e;
  }
}
