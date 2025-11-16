import 'package:dio/dio.dart';
import 'token_storage_service.dart';

// This interceptor reads the access token from storage and adds it
// to the Authorization header for every outgoing request on mobile.
class AuthInterceptor extends Interceptor {
  final TokenStorageService _tokenStorageService;

  AuthInterceptor(this._tokenStorageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get the access token from storage
    final accessToken = await _tokenStorageService.getAccessToken();

    // If the token exists, add the Authorization header
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Continue with the request
    return handler.next(options);
  }
}
