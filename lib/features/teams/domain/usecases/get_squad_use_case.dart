import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/squad_entity.dart';
import '../repositories/team_repository.dart';

class GetSquadUseCase
    implements UseCase<List<SquadMemberEntity>, GetSquadParams> {
  final TeamRepository repository;

  GetSquadUseCase(this.repository);

  @override
  Future<Either<Failure, List<SquadMemberEntity>>> call(
      GetSquadParams params) async {
    return await repository.getSquad(params.teamId);
  }
}

class GetSquadParams extends Equatable {
  final String teamId;

  const GetSquadParams({required this.teamId});

  @override
  List<Object> get props => [teamId];
}
