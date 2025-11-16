import 'error_response_model.dart';

class AppException implements Exception {
  final ErrorResponseModel errorResponse;

  AppException(this.errorResponse);

  @override
  String toString() => errorResponse.firstError;
}