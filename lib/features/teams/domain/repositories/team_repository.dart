import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/team_detail_entity.dart';

abstract class TeamRepository {
  Future<Either<Failure, TeamDetailEntity>> getTeamDetail(String teamId);
  Future<Either<Failure, TeamDetailEntity>> updateTeam(
      String teamId, Map<String, dynamic> body);
  Future<Either<Failure, TeamCoachEntity>> updateCoach(
      String coachId, Map<String, dynamic> body);
  Future<Either<Failure, TeamVenueEntity>> updateVenue(
      String venueId, Map<String, dynamic> body);
}
