import '../../../../core/config/constants.dart';
import '../../../../core/services/api_client.dart';
import '../../../matches/data/models/team_model.dart';
import '../models/team_detail_model.dart';
import '../models/squad_model.dart';
import '../../../matches/domain/entities/team_entity.dart';

abstract class TeamRemoteDataSource {
  Future<List<TeamEntity>> getTeams({
    int page = 1,
    String? search,
    String? competitionId,
    String? seasonId,
  });
  Future<TeamDetailModel> getTeamDetail(String teamId);
  Future<TeamDetailModel> updateTeam(String teamId, Map<String, dynamic> data);
  Future<TeamCoachModel> updateCoach(String coachId, Map<String, dynamic> data);
  Future<TeamVenueModel> updateVenue(String venueId, Map<String, dynamic> data);
  Future<List<SquadMemberModel>> getSquad(String teamId);
  Future<PlayerModel> updatePlayer(String playerId, Map<String, dynamic> data);
}

class TeamRemoteDataSourceImpl implements TeamRemoteDataSource {
  final ApiClient apiClient;

  TeamRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<TeamEntity>> getTeams({
    int page = 1,
    String? search,
    String? competitionId,
    String? seasonId,
  }) async {
    final response = await apiClient.get(
      AppConstants.teamsUrl,
      queryParameters: {
        'page': page,
        if (search != null) 'search': search,
        if (competitionId != null) 'competition': competitionId,
        if (seasonId != null) 'season': seasonId,
      },
    );

    final List<dynamic> results = response['results'];
    return results.map((json) => TeamModel.fromJson(json).toEntity()).toList();
  }

  @override
  Future<TeamDetailModel> getTeamDetail(String id) async {
    final response = await apiClient.get('${AppConstants.teamsUrl}$id/');
    return TeamDetailModel.fromJson(response);
  }

  @override
  Future<TeamDetailModel> updateTeam(
      String teamId, Map<String, dynamic> data) async {
    await apiClient.patch(
      AppConstants.updateTeamUrl(teamId),
      data: data,
    );
    return TeamDetailModel.fromJson({});
  }

  @override
  Future<TeamCoachModel> updateCoach(
      String coachId, Map<String, dynamic> data) async {
    final response = await apiClient.patch(
      AppConstants.updateCoachUrl(coachId),
      data: data,
    );
    return TeamCoachModel.fromJson(response);
  }

  @override
  Future<TeamVenueModel> updateVenue(
      String venueId, Map<String, dynamic> data) async {
    final response = await apiClient.patch(
      AppConstants.updateVenueUrl(venueId),
      data: data,
    );
    return TeamVenueModel.fromJson(response);
  }

  @override
  Future<List<SquadMemberModel>> getSquad(String teamId) async {
    final response = await apiClient.get(
      AppConstants.getSquadUrl(teamId),
    );
    final List<dynamic> results = response;
    return results.map((json) => SquadMemberModel.fromJson(json)).toList();
  }

  @override
  Future<PlayerModel> updatePlayer(
      String playerId, Map<String, dynamic> data) async {
    // The API now supports updating both squad info and player info in one request
    // via /teams/{team_id}/squad/{member_id}/

    if (data.containsKey('team_id') && data.containsKey('member_id')) {
      // Create a copy of data and remove the IDs to send a clean payload
      final payload = Map<String, dynamic>.from(data);
      final teamId = payload.remove('team_id');
      final memberId = payload.remove('member_id');

      final response = await apiClient.patch(
        AppConstants.updateSquadMemberUrl(teamId, memberId),
        data: payload,
      );
      // The response is a SquadMember object, but we need to return a PlayerModel
      // or at least something compatible.
      // The SquadMember object contains a 'player' field which is the PlayerModel.
      if (response.containsKey('player')) {
        return PlayerModel.fromJson(response['player']);
      }
      // Fallback if structure is different
      return PlayerModel(
          id: playerId, name: {}, shortName: {}, displayName: {});
    } else {
      // Fallback for legacy calls or if only player info is updated without context
      // (This shouldn't happen with current implementation but good for safety)
      final response = await apiClient.patch(
        AppConstants.updatePlayerUrl(playerId),
        data: data,
      );
      return PlayerModel.fromJson(response);
    }
  }
}
