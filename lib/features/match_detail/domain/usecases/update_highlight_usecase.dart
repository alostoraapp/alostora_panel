import 'package:alostora/core/error/failure.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/core/utils/either.dart';
import 'package:alostora/features/match_detail/domain/repositories/match_detail_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateHighlightUseCase implements UseCase<void, UpdateHighlightParams> {
  final MatchDetailRepository repository;

  UpdateHighlightUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateHighlightParams params) async {
    return await repository.updateHighlight(
        params.matchId, params.highlightId, params.params);
  }
}

class UpdateHighlightParams extends Equatable {
  final String matchId;
  final String highlightId;
  final Map<String, dynamic> params;

  const UpdateHighlightParams({
    required this.matchId,
    required this.highlightId,
    required this.params,
  });

  @override
  List<Object?> get props => [matchId, highlightId, params];
}
