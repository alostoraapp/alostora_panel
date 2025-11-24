import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/lineup_entity.dart';
import '../repositories/match_detail_repository.dart';

class GetLineupUsecase implements UseCase<LineupEntity, GetLineupParams> {
  final MatchDetailRepository repository;

  GetLineupUsecase({required this.repository});

  @override
  Future<Either<Failure, LineupEntity>> call(GetLineupParams params) async {
    return await repository.getLineup(params.matchId);
  }
}

class GetLineupParams extends Equatable {
  final String matchId;

  const GetLineupParams({required this.matchId});

  @override
  List<Object?> get props => [matchId];
}
