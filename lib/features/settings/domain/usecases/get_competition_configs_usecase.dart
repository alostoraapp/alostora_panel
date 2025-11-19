import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/competition_config_entity.dart';
import '../repositories/competition_config_repository.dart';

class GetCompetitionConfigsUseCase {
  final CompetitionConfigRepository repository;

  GetCompetitionConfigsUseCase(this.repository);

  Future<Either<Failure, List<CompetitionConfigEntity>>> call({String? search}) {
    return repository.getConfigs(search: search);
  }
}
