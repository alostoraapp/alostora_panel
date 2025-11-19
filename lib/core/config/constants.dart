class AppConstants {
  // static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'https://apiv2.alostora.org';

  // Auth
  static const String loginUrl = '/v1/users/auth/admin/login/';
  static const String verifyUrl = '/v1/users/auth/token/verify/';
  static const String logoutUrl = '/v1/users/auth/admin/logout/';
  static const String refreshTokenUrl = '/v1/users/auth/token/refresh/';

  // Matches
  static const String matchesListUrl = '/v1/matches/list/';

  // Settings - Competition Config
  static const String competitionConfigsUrl = '/v1/entities/admin/competition/configs/';
  static const String competitionConfigsReorderUrl = '/v1/entities/admin/competition/configs/reorder/';
}
