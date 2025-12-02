import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/match_tv_channel_entity.dart';
import '../repositories/match_detail_repository.dart';

class GetMatchTvChannelsUseCase
    implements UseCase<List<MatchTvChannelEntity>, String> {
  final MatchDetailRepository repository;

  GetMatchTvChannelsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MatchTvChannelEntity>>> call(
      String matchId) async {
    return await repository.getMatchTvChannels(matchId);
  }
}
