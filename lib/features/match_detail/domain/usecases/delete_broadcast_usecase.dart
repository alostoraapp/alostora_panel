import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../repositories/match_detail_repository.dart';

class DeleteBroadcastParams {
  final String matchId;
  final String broadcastId;

  DeleteBroadcastParams({required this.matchId, required this.broadcastId});
}

class DeleteBroadcastUseCase implements UseCase<void, DeleteBroadcastParams> {
  final MatchDetailRepository repository;

  DeleteBroadcastUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteBroadcastParams params) async {
    return await repository.deleteBroadcast(params.matchId, params.broadcastId);
  }
}
