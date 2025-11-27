import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/incident_model.dart';
import '../models/lineup_model.dart';

abstract class MatchDetailRemoteDataSource {
  Future<LineupModel> getLineup(String matchId);
  Future<LineupModel> updateManOfTheMatch(
      String matchId, String playerLineupId);
  Future<List<IncidentModel>> getMatchIncidents(String matchId);
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
}
