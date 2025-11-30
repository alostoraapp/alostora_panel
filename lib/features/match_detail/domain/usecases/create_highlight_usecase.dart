import 'package:alostora/core/error/failure.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/core/utils/either.dart';
import 'package:alostora/features/match_detail/domain/repositories/match_detail_repository.dart';
import 'package:equatable/equatable.dart';

class CreateHighlightUseCase implements UseCase<void, CreateHighlightParams> {
  final MatchDetailRepository repository;

  CreateHighlightUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateHighlightParams params) async {
    return await repository.createHighlight(params.matchId, params.params);
  }
}

class CreateHighlightParams extends Equatable {
  final String matchId;
  final Map<String, dynamic> params;

  const CreateHighlightParams({required this.matchId, required this.params});

  @override
  List<Object?> get props => [matchId, params];
}
