import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/competition_config_entity.dart';
import '../repositories/competition_config_repository.dart';

class AddCompetitionConfigUseCase {
  final CompetitionConfigRepository repository;

  AddCompetitionConfigUseCase(this.repository);

  Future<Either<Failure, CompetitionConfigEntity>> call(String competitionId) {
    return repository.addConfig(competitionId);
  }
}
