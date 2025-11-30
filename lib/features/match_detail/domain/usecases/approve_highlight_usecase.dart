import 'package:alostora/core/error/failure.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/core/utils/either.dart';
import 'package:alostora/features/match_detail/domain/repositories/match_detail_repository.dart';
import 'package:equatable/equatable.dart';

class ApproveHighlightUseCase implements UseCase<void, ApproveHighlightParams> {
  final MatchDetailRepository repository;

  ApproveHighlightUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ApproveHighlightParams params) async {
    return await repository.approveHighlight(
      params.matchId,
      params.highlightId,
      params.status,
      params.priority,
    );
  }
}

class ApproveHighlightParams extends Equatable {
  final String matchId;
  final String highlightId;
  final String status;
  final String priority;

  const ApproveHighlightParams({
    required this.matchId,
    required this.highlightId,
    required this.status,
    required this.priority,
  });

  @override
  List<Object?> get props => [matchId, highlightId, status, priority];
}
