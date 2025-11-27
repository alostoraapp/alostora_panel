import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/incident_entity.dart';
import '../entities/lineup_entity.dart';

abstract class MatchDetailRepository {
  Future<Either<Failure, LineupEntity>> getLineup(String matchId);
  Future<Either<Failure, LineupEntity>> updateManOfTheMatch(
      String matchId, String playerLineupId);
  Future<Either<Failure, List<IncidentEntity>>> getMatchIncidents(
      String matchId);
}
