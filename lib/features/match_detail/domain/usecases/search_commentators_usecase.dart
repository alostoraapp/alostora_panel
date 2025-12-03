import '../../../../core/utils/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/commentator_entity.dart';
import '../../domain/repositories/match_detail_repository.dart';

class SearchCommentatorsUseCase
    implements UseCase<List<CommentatorEntity>, SearchCommentatorsParams> {
  final MatchDetailRepository repository;

  SearchCommentatorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CommentatorEntity>>> call(
      SearchCommentatorsParams params) async {
    return await repository.searchCommentators(params.query, params.page);
  }
}

class SearchCommentatorsParams {
  final String query;
  final int page;

  SearchCommentatorsParams({required this.query, required this.page});
}
