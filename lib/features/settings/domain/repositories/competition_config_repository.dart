import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/competition_config_entity.dart';
import '../entities/competition_search_entity.dart';

abstract class CompetitionConfigRepository {
  Future<Either<Failure, List<CompetitionConfigEntity>>> getConfigs({String? search});
  Future<Either<Failure, CompetitionConfigEntity>> addConfig(String competitionId);
  Future<Either<Failure, CompetitionConfigEntity>> toggleStatus(String id, bool isActive);
  Future<Either<Failure, void>> deleteConfig(String id);
  Future<Either<Failure, void>> reorderConfigs(List<String> orderedIds);
  Future<Either<Failure, List<CompetitionSearchEntity>>> searchCompetitions({
    required String query,
    int page = 1,
    int pageSize = 10,
  });
}
