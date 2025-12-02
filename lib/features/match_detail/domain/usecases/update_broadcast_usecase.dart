import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../repositories/match_detail_repository.dart';

class UpdateBroadcastParams {
  final String matchId;
  final String broadcastId;
  final Map<String, dynamic> params;

  UpdateBroadcastParams({
    required this.matchId,
    required this.broadcastId,
    required this.params,
  });
}

class UpdateBroadcastUseCase implements UseCase<void, UpdateBroadcastParams> {
  final MatchDetailRepository repository;

  UpdateBroadcastUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateBroadcastParams params) async {
    return await repository.updateBroadcast(
        params.matchId, params.broadcastId, params.params);
  }
}
