import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repositories/match_detail_repository.dart';

class AddCommentatorToMatchUseCase
    implements UseCase<void, AddCommentatorParams> {
  final MatchDetailRepository repository;

  AddCommentatorToMatchUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddCommentatorParams params) async {
    return await repository.addCommentatorToMatch(
      params.matchId,
      params.commentatorId,
      params.tvChannelId,
    );
  }
}

class AddCommentatorParams {
  final String matchId;
  final String commentatorId;
  final String? tvChannelId;

  AddCommentatorParams({
    required this.matchId,
    required this.commentatorId,
    this.tvChannelId,
  });
}
