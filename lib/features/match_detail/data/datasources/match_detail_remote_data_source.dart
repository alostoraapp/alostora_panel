import 'package:dio/dio.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/incident_model.dart';
import '../models/lineup_model.dart';

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
      data: {
        'status': status,
        'priority': priority,
      },
    );
  }
}
