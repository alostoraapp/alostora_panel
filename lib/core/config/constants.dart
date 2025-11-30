class AppConstants {
  // static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'https://apiv2.alostora.org';

  // Auth
  static const String loginUrl = '/v1/admin/users/login/';
  static const String verifyUrl = '/v1/admin/users/token/verify/';
  static const String logoutUrl = '/v1/admin/users/logout/';
  static const String refreshTokenUrl = '/v1/admin/users/token/refresh/';

  // Matches
  static const String matchesListUrl = '/v1/admin/matches/list/';
  static String getLineupUrl(String matchId) =>
      '/v1/admin/matches/$matchId/lineup/';
  static String getUpdateManOfTheMatchUrl(String matchId) =>
      '/v1/admin/matches/$matchId/lineup/motm/';
  static String getMatchIncidentsUrl(String matchId) =>
      '/v1/admin/matches/$matchId/incidents/';
  static String getIncidentMediaUrl(String matchId, String incidentId) =>
      '/v1/admin/matches/$matchId/incidents/$incidentId/media/';
  static String getApproveIncidentMediaUrl(String matchId, String incidentId) =>
      '/v1/admin/matches/$matchId/incidents/$incidentId/media/approve/';

  // Highlights
  static String getHighlightsUrl(String matchId) =>
      '/v1/admin/matches/$matchId/highlights/';
  static String getHighlightUrl(String matchId, String highlightId) =>
      '/v1/admin/matches/$matchId/highlights/$highlightId/';
  static String getApproveHighlightUrl(String matchId, String highlightId) =>
      '/v1/admin/matches/$matchId/highlights/$highlightId/approve/';

  // Settings - Competition Config
  static const String competitionConfigsUrl =
      '/v1/admin/entities/competition/configs/';
  static const String competitionConfigsReorderUrl =
      '/v1/admin/entities/competition/configs/reorder/';
  static const String competitionSearch =
      '/v1/admin/entities/competition/search/';
}
