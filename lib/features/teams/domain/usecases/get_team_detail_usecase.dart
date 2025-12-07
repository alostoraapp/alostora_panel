import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/team_detail_entity.dart';
import '../repositories/team_repository.dart';

class GetTeamDetailUseCase implements UseCase<TeamDetailEntity, String> {
  final TeamRepository repository;

  GetTeamDetailUseCase(this.repository);

  @override
  Future<Either<Failure, TeamDetailEntity>> call(String teamId) async {
    return await repository.getTeamDetail(teamId);
  }
}
