import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/lineup_model.dart';

abstract class MatchDetailRemoteDataSource {
  Future<LineupModel> getLineup(String matchId);
}

class MatchDetailRemoteDataSourceImpl implements MatchDetailRemoteDataSource {
  final ApiClient _apiClient;

  const MatchDetailRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LineupModel> getLineup(String matchId) async {
    final response = await _apiClient.get(AppConstants.getLineupUrl(matchId));
    return LineupModel.fromJson(response);
  }
}
