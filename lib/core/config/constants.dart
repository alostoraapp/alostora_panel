class AppConstants {
  // static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'https://apiv2.alostora.org';

  // Auth
  static const String loginUrl = '/v1/admin/users/login/';
  static const String verifyUrl = '/v1/admin/users/token/verify/';
  static const String logoutUrl = '/v1/admin/users/logout/';
  static const String refreshTokenUrl = '/v1/admin/users/token/refresh/';
  static const String cachedToken = 'CACHED_TOKEN';

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

  // Broadcasts
  static String getBroadcastsUrl(String matchId) =>
      '/v1/admin/matches/$matchId/broadcasts/';
  static String getBroadcastUrl(String matchId, String broadcastId) =>
      '/v1/admin/matches/$matchId/broadcasts/$broadcastId/';

  // TV Channels
  static const String tvChannelsUrl = '/v1/admin/media/tv-channels/';
  static String getMatchTvChannelsUrl(String matchId) =>
      '/v1/admin/matches/$matchId/tv-channels/';
  static String getMatchTvChannelUrl(String matchId, String itemId) =>
      '/v1/admin/matches/$matchId/tv-channels/$itemId/';

  // Commentators
  static const String commentatorsUrl = '/v1/admin/media/commentators/search/';
  static String getMatchCommentatorsUrl(String matchId) =>
      '/v1/admin/matches/$matchId/commentators/';
  static String getMatchCommentatorUrl(String matchId, String itemId) =>
      '/v1/admin/matches/$matchId/commentators/$itemId/';

  // Settings - Competition Config
  static const String competitionConfigsUrl =
      '/v1/admin/entities/competition/configs/';
  static const String competitionConfigsReorderUrl =
      '/v1/admin/entities/competition/configs/reorder/';
  static const String competitionSearch =
      '/v1/admin/entities/competition/search/';

  // News
  static const String newsListUrl = '/v1/admin/media/news/';
  static const String createNewsUrl = '/v1/admin/media/news/';
  static const String searchTeamsUrl = '/v1/admin/entities/teams/search/';

  static String getNewsUrl(String id) => '/v1/admin/media/news/$id/';
  static String getApproveNewsUrl(String id) =>
      '/v1/admin/media/news/$id/approve/';
  static String getUploadNewsImageUrl(String id) =>
      '/v1/admin/media/news/$id/images/';
}
