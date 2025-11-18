import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../entities/competition_entity.dart';

abstract class MatchesRepository {
  Future<Either<Failure, List<CompetitionEntity>>> getMatches({
    String? search,
    String? ordering,
    bool? isLive,
    int? startTimestamp,
    int? endTimestamp,
  });
}
