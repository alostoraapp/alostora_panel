import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../repositories/competition_config_repository.dart';

class DeleteCompetitionConfigUseCase {
  final CompetitionConfigRepository repository;

  DeleteCompetitionConfigUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteConfig(id);
  }
}
