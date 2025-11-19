import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/competition_config_entity.dart';
import '../repositories/competition_config_repository.dart';

class ToggleCompetitionStatusUseCase {
  final CompetitionConfigRepository repository;

  ToggleCompetitionStatusUseCase(this.repository);

  Future<Either<Failure, CompetitionConfigEntity>> call(String id, bool isActive) {
    return repository.toggleStatus(id, isActive);
  }
}
