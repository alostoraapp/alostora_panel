import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repositories/match_detail_repository.dart';

class DeleteCommentatorFromMatchUseCase
    implements UseCase<void, DeleteCommentatorParams> {
  final MatchDetailRepository repository;

  DeleteCommentatorFromMatchUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteCommentatorParams params) async {
    return await repository.deleteCommentatorFromMatch(
        params.matchId, params.itemId);
  }
}

class DeleteCommentatorParams {
  final String matchId;
  final String itemId;

  DeleteCommentatorParams({required this.matchId, required this.itemId});
}
