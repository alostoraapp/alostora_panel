import 'package:alostora/core/error/failure.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/core/utils/either.dart';
import 'package:alostora/features/match_detail/domain/repositories/match_detail_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteHighlightUseCase implements UseCase<void, DeleteHighlightParams> {
  final MatchDetailRepository repository;

  DeleteHighlightUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteHighlightParams params) async {
    return await repository.deleteHighlight(params.matchId, params.highlightId);
  }
}

class DeleteHighlightParams extends Equatable {
  final String matchId;
  final String highlightId;

  const DeleteHighlightParams(
      {required this.matchId, required this.highlightId});

  @override
  List<Object?> get props => [matchId, highlightId];
}
