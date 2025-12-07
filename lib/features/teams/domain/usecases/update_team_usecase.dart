import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/team_detail_entity.dart';
import '../repositories/team_repository.dart';

class UpdateTeamUseCase implements UseCase<TeamDetailEntity, UpdateTeamParams> {
  final TeamRepository repository;

  UpdateTeamUseCase(this.repository);

  @override
  Future<Either<Failure, TeamDetailEntity>> call(
      UpdateTeamParams params) async {
    return await repository.updateTeam(params.teamId, params.body);
  }
}

class UpdateTeamParams extends Equatable {
  final String teamId;
  final Map<String, dynamic> body;

  const UpdateTeamParams({required this.teamId, required this.body});

  @override
  List<Object?> get props => [teamId, body];
}
