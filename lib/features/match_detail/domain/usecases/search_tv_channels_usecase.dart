import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/tv_channel_entity.dart';
import '../repositories/match_detail_repository.dart';

class SearchTvChannelsParams {
  final String query;
  final int page;

  SearchTvChannelsParams({required this.query, required this.page});
}

class SearchTvChannelsUseCase
    implements UseCase<List<TvChannelEntity>, SearchTvChannelsParams> {
  final MatchDetailRepository repository;

  SearchTvChannelsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TvChannelEntity>>> call(
      SearchTvChannelsParams params) async {
    return await repository.searchTvChannels(params.query, params.page);
  }
}
