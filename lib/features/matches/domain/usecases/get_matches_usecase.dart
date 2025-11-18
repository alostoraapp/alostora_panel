import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/competition_entity.dart';
import '../repositories/matches_repository.dart';

class GetMatchesUseCase implements UseCase<List<CompetitionEntity>, GetMatchesParams> {
  final MatchesRepository _repository;

  GetMatchesUseCase(this._repository);

  @override
  Future<Either<Failure, List<CompetitionEntity>>> call(GetMatchesParams params) async {
    return await _repository.getMatches(
      search: params.search,
      ordering: params.ordering,
      isLive: params.isLive,
      startTimestamp: params.startTimestamp,
      endTimestamp: params.endTimestamp,
    );
  }
}

class GetMatchesParams {
  final String? search;
  final String? ordering;
  final bool? isLive;
  final int? startTimestamp;
  final int? endTimestamp;

  GetMatchesParams({
    this.search,
    this.ordering,
    this.isLive,
    this.startTimestamp,
    this.endTimestamp,
  });
}
