import 'package:dio/dio.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/incident_model.dart';
import '../models/lineup_model.dart';
import '../models/highlight_model.dart';

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
    final formData = FormData.fromMap(params);
    if (params['cover'] is XFile) {
      final XFile file = params['cover'];
      final bytes = await file.readAsBytes();
      formData.files.add(MapEntry(
        'cover',
        MultipartFile.fromBytes(bytes, filename: file.name),
      ));
    }

    await _apiClient.post(AppConstants.getHighlightsUrl(matchId),
        data: formData);
  }

  @override
  Future<void> updateHighlight(
      String matchId, String highlightId, Map<String, dynamic> params) async {
    final formData = FormData.fromMap(params);
    if (params['cover'] is XFile) {
      final XFile file = params['cover'];
      final bytes = await file.readAsBytes();
      formData.files.add(MapEntry(
        'cover',
        MultipartFile.fromBytes(bytes, filename: file.name),
      ));
    }
    await _apiClient.patch(AppConstants.getHighlightUrl(matchId, highlightId),
        data: formData);
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
}
