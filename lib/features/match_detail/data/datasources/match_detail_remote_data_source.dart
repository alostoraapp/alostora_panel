import 'package:dio/dio.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/incident_model.dart';
import '../models/lineup_model.dart';
import '../models/highlight_model.dart';
import '../models/broadcast_model.dart';
import '../models/tv_channel_model.dart';
import '../models/match_tv_channel_model.dart';

import 'package:image_picker/image_picker.dart';

abstract class MatchDetailRemoteDataSource {
  Future<LineupModel> getLineup(String matchId);
  Future<LineupModel> updateManOfTheMatch(
      String matchId, String playerLineupId);
  Future<List<IncidentModel>> getMatchIncidents(String matchId);
  Future<List<IncidentModel>> updateIncidentMedia(String matchId,
      String incidentId, String? mediaUrl, XFile? mediaCover, int? videoTime);
  Future<List<IncidentModel>> deleteIncidentMedia(
      String matchId, String incidentId);
  Future<void> approveIncidentMedia(
      String matchId, String incidentId, String status, String priority);

  // Highlights
  Future<List<HighlightModel>> getHighlights(String matchId);
  Future<void> createHighlight(String matchId, Map<String, dynamic> params);
  Future<void> updateHighlight(
      String matchId, String highlightId, Map<String, dynamic> params);
  Future<void> deleteHighlight(String matchId, String highlightId);
  Future<void> approveHighlight(
      String matchId, String highlightId, String status, String priority);

  // Broadcasts
  Future<List<BroadcastModel>> getBroadcasts(String matchId);
  Future<void> createBroadcast(String matchId, Map<String, dynamic> params);
  Future<void> updateBroadcast(
      String matchId, String broadcastId, Map<String, dynamic> params);
  Future<void> deleteBroadcast(String matchId, String broadcastId);
  Future<List<TvChannelModel>> searchTvChannels(String query, int page);

  // Match TV Channels
  Future<List<MatchTvChannelModel>> getMatchTvChannels(String matchId);
  Future<void> addTvChannelToMatch(String matchId, String tvChannelId);
  Future<void> deleteTvChannelFromMatch(String matchId, String itemId);
}

class MatchDetailRemoteDataSourceImpl implements MatchDetailRemoteDataSource {
  final ApiClient _apiClient;

  const MatchDetailRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LineupModel> getLineup(String matchId) async {
    final response = await _apiClient.get(AppConstants.getLineupUrl(matchId));
    return LineupModel.fromJson(response);
  }

  @override
  Future<LineupModel> updateManOfTheMatch(
      String matchId, String playerLineupId) async {
    final response = await _apiClient.patch(
      AppConstants.getUpdateManOfTheMatchUrl(matchId),
      data: {'player_lineup_id': playerLineupId},
    );
    return LineupModel.fromJson(response);
  }

  @override
  Future<List<IncidentModel>> getMatchIncidents(String matchId) async {
    final response =
        await _apiClient.get(AppConstants.getMatchIncidentsUrl(matchId));
    return (response as List)
        .map((e) => IncidentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<IncidentModel>> updateIncidentMedia(
      String matchId,
      String incidentId,
      String? mediaUrl,
      XFile? mediaCover,
      int? videoTime) async {
    final Map<String, dynamic> dataMap = {};
    if (mediaUrl != null) dataMap['media_url'] = mediaUrl;
    if (videoTime != null) dataMap['video_time'] = videoTime;

    if (mediaCover != null) {
      final bytes = await mediaCover.readAsBytes();
      dataMap['media_cover'] = MultipartFile.fromBytes(
        bytes,
        filename: mediaCover.name,
      );
    }

    final formData = FormData.fromMap(dataMap);

    final response = await _apiClient.patch(
      AppConstants.getIncidentMediaUrl(matchId, incidentId),
      data: formData,
    );
    return (response as List)
        .map((e) => IncidentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<IncidentModel>> deleteIncidentMedia(
      String matchId, String incidentId) async {
    final response = await _apiClient.delete(
      AppConstants.getIncidentMediaUrl(matchId, incidentId),
    );
    return (response as List)
        .map((e) => IncidentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> approveIncidentMedia(
      String matchId, String incidentId, String status, String priority) async {
    await _apiClient.post(
      AppConstants.getApproveIncidentMediaUrl(matchId, incidentId),
      data: {},
    );
  }

  @override
  Future<List<HighlightModel>> getHighlights(String matchId) async {
    final response =
        await _apiClient.get(AppConstants.getHighlightsUrl(matchId));
    return (response as List).map((e) => HighlightModel.fromJson(e)).toList();
  }

  @override
  Future<void> createHighlight(
      String matchId, Map<String, dynamic> params) async {
    // Check if we need to upload a file
    bool hasFile = params.values.any((value) => value is XFile);

    if (!hasFile) {
      // Send as JSON
      await _apiClient.post(AppConstants.getHighlightsUrl(matchId),
          data: params);
    } else {
      // Send as FormData
      final data = <String, dynamic>{};

      for (var entry in params.entries) {
        if (entry.key == 'title_translations' && entry.value is List) {
          List list = entry.value;
          for (int i = 0; i < list.length; i++) {
            Map item = list[i];
            item.forEach((key, value) {
              data['title_translations[$i][$key]'] = value;
            });
          }
        } else if (entry.value is XFile) {
          final XFile file = entry.value;
          final bytes = await file.readAsBytes();
          data[entry.key] = MultipartFile.fromBytes(bytes, filename: file.name);
        } else {
          data[entry.key] = entry.value;
        }
      }

      final formData = FormData.fromMap(data);
      await _apiClient.post(AppConstants.getHighlightsUrl(matchId),
          data: formData);
    }
  }

  @override
  Future<void> updateHighlight(
      String matchId, String highlightId, Map<String, dynamic> params) async {
    // Check if we need to upload a file
    bool hasFile = params.values.any((value) => value is XFile);

    if (!hasFile) {
      // Send as JSON
      await _apiClient.patch(AppConstants.getHighlightUrl(matchId, highlightId),
          data: params);
    } else {
      // Send as FormData
      final data = <String, dynamic>{};

      for (var entry in params.entries) {
        if (entry.key == 'title_translations' && entry.value is List) {
          List list = entry.value;
          for (int i = 0; i < list.length; i++) {
            Map item = list[i];
            item.forEach((key, value) {
              data['title_translations[$i][$key]'] = value;
            });
          }
        } else if (entry.value is XFile) {
          final XFile file = entry.value;
          final bytes = await file.readAsBytes();
          data[entry.key] = MultipartFile.fromBytes(bytes, filename: file.name);
        } else {
          data[entry.key] = entry.value;
        }
      }

      final formData = FormData.fromMap(data);
      await _apiClient.patch(AppConstants.getHighlightUrl(matchId, highlightId),
          data: formData);
    }
  }

  @override
  Future<void> deleteHighlight(String matchId, String highlightId) async {
    await _apiClient.delete(AppConstants.getHighlightUrl(matchId, highlightId));
  }

  @override
  Future<void> approveHighlight(String matchId, String highlightId,
      String status, String priority) async {
    await _apiClient.post(
      AppConstants.getApproveHighlightUrl(matchId, highlightId),
      data: {'status': status, 'priority': priority},
    );
  }

  // Broadcasts
  @override
  Future<List<BroadcastModel>> getBroadcasts(String matchId) async {
    final response =
        await _apiClient.get(AppConstants.getBroadcastsUrl(matchId));
    return (response as List).map((e) => BroadcastModel.fromJson(e)).toList();
  }

  @override
  Future<void> createBroadcast(
      String matchId, Map<String, dynamic> params) async {
    await _apiClient.post(AppConstants.getBroadcastsUrl(matchId), data: params);
  }

  @override
  Future<void> updateBroadcast(
      String matchId, String broadcastId, Map<String, dynamic> params) async {
    await _apiClient.patch(AppConstants.getBroadcastUrl(matchId, broadcastId),
        data: params);
  }

  @override
  Future<void> deleteBroadcast(String matchId, String broadcastId) async {
    await _apiClient.delete(AppConstants.getBroadcastUrl(matchId, broadcastId));
  }

  @override
  Future<List<TvChannelModel>> searchTvChannels(String query, int page) async {
    final response = await _apiClient.get(
      AppConstants.tvChannelsUrl,
      queryParameters: {'search': query, 'page': page},
    );
    return (response['results'] as List)
        .map((e) => TvChannelModel.fromJson(e))
        .toList();
  }

  // Match TV Channels
  @override
  Future<List<MatchTvChannelModel>> getMatchTvChannels(String matchId) async {
    final response =
        await _apiClient.get(AppConstants.getMatchTvChannelsUrl(matchId));
    return (response as List)
        .map((e) => MatchTvChannelModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> addTvChannelToMatch(String matchId, String tvChannelId) async {
    await _apiClient.post(
      AppConstants.getMatchTvChannelsUrl(matchId),
      data: {'tv_channel': tvChannelId},
    );
  }

  @override
  Future<void> deleteTvChannelFromMatch(String matchId, String itemId) async {
    await _apiClient.delete(AppConstants.getMatchTvChannelUrl(matchId, itemId));
  }
}
