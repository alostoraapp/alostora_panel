import 'package:alostora/core/error/failure.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/core/utils/either.dart';
import 'package:alostora/features/match_detail/domain/entities/highlight_entity.dart';
import 'package:alostora/features/match_detail/domain/repositories/match_detail_repository.dart';

class GetHighlightsUseCase implements UseCase<List<HighlightEntity>, String> {
  final MatchDetailRepository repository;

  GetHighlightsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HighlightEntity>>> call(String matchId) async {
    return await repository.getHighlights(matchId);
  }
}
