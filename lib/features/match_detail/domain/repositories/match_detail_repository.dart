import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/lineup_entity.dart';

abstract class MatchDetailRepository {
  Future<Either<Failure, LineupEntity>> getLineup(String matchId);
}
