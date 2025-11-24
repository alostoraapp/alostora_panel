import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/lineup_entity.dart';
import '../repositories/match_detail_repository.dart';

class UpdateManOfTheMatch
    implements UseCase<LineupEntity, UpdateManOfTheMatchParams> {
  final MatchDetailRepository repository;

  UpdateManOfTheMatch(this.repository);

  @override
  Future<Either<Failure, LineupEntity>> call(
      UpdateManOfTheMatchParams params) async {
    return await repository.updateManOfTheMatch(
        params.matchId, params.playerLineupId);
  }
}

class UpdateManOfTheMatchParams extends Equatable {
  final String matchId;
  final String playerLineupId;

  const UpdateManOfTheMatchParams(
      {required this.matchId, required this.playerLineupId});

  @override
  List<Object?> get props => [matchId, playerLineupId];
}
