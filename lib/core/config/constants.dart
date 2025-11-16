
// This file can be used for app-wide constants.

class AppConstants {
  // static const String baseUrl = 'http://localhost:8000/v1';
  static const String baseUrl = 'https://apiv2.alostora.org/v1';

  static const String loginUrl = '$baseUrl/users/auth/admin/login/';
  static const String verifyUrl = '$baseUrl/users/auth/token/verify/';
  static const String logoutUrl = '$baseUrl/users/auth/admin/logout/';
  static const String refreshTokenUrl = '$baseUrl/users/auth/token/refresh/';
}
