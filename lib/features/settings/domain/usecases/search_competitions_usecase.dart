import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/competition_search_entity.dart';
import '../repositories/competition_config_repository.dart';

class SearchCompetitionsUseCase {
  final CompetitionConfigRepository repository;

  SearchCompetitionsUseCase(this.repository);

  Future<Either<Failure, List<CompetitionSearchEntity>>> call({
    required String query,
    int page = 1,
    int pageSize = 10,
  }) async {
    return await repository.searchCompetitions(query: query, page: page, pageSize: pageSize);
  }
}
