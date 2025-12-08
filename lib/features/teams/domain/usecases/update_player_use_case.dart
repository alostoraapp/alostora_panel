import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/squad_entity.dart';
import '../repositories/team_repository.dart';

class UpdatePlayerUseCase implements UseCase<PlayerEntity, UpdatePlayerParams> {
  final TeamRepository repository;

  UpdatePlayerUseCase(this.repository);

  @override
  Future<Either<Failure, PlayerEntity>> call(UpdatePlayerParams params) async {
    return await repository.updatePlayer(params.playerId, params.body);
  }
}

class UpdatePlayerParams extends Equatable {
  final String playerId;
  final Map<String, dynamic> body;

  const UpdatePlayerParams({required this.playerId, required this.body});

  @override
  List<Object> get props => [playerId, body];
}
