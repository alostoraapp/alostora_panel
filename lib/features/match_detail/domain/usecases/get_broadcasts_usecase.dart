import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/broadcast_entity.dart';
import '../repositories/match_detail_repository.dart';

class GetBroadcastsUseCase implements UseCase<List<BroadcastEntity>, String> {
  final MatchDetailRepository repository;

  GetBroadcastsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BroadcastEntity>>> call(String matchId) async {
    return await repository.getBroadcasts(matchId);
  }
}
