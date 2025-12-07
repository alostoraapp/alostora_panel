import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../models/team_detail_model.dart';

abstract class TeamRemoteDataSource {
  Future<TeamDetailModel> getTeamDetail(String teamId);
  Future<TeamDetailModel> updateTeam(String teamId, Map<String, dynamic> body);
}

class TeamRemoteDataSourceImpl implements TeamRemoteDataSource {
  final ApiClient apiClient;

  TeamRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TeamDetailModel> getTeamDetail(String teamId) async {
    final response = await apiClient.get(
      AppConstants.getTeamDetailUrl(teamId),
    );
    return TeamDetailModel.fromJson(response);
  }

  @override
  Future<TeamDetailModel> updateTeam(
      String teamId, Map<String, dynamic> body) async {
    final response = await apiClient.patch(
      AppConstants.updateTeamUrl(teamId),
      data: body,
    );
    return TeamDetailModel.fromJson(response);
  }
}
