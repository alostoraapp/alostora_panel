import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/competition_detail_entity.dart';

abstract class CompetitionDetailRepository {
  Future<Either<Failure, CompetitionDetailEntity>> getCompetitionDetail(
      String id);
  Future<Either<Failure, CompetitionDetailEntity>> updateCompetitionDetail(
      String id, Map<String, dynamic> body);
}
