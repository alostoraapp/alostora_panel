import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/match_commentator_entity.dart';
import '../../domain/repositories/match_detail_repository.dart';

class GetMatchCommentatorsUseCase
    implements UseCase<List<MatchCommentatorEntity>, String> {
  final MatchDetailRepository repository;

  GetMatchCommentatorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MatchCommentatorEntity>>> call(
      String matchId) async {
    return await repository.getMatchCommentators(matchId);
  }
}
