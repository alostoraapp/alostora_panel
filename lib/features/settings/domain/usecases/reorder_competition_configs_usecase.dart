import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../repositories/competition_config_repository.dart';

class ReorderCompetitionConfigsUseCase {
  final CompetitionConfigRepository repository;

  ReorderCompetitionConfigsUseCase(this.repository);

  Future<Either<Failure, void>> call(List<String> orderedIds) {
    return repository.reorderConfigs(orderedIds);
  }
}
