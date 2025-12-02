import '../../../../core/utils/either.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/match_detail_repository.dart';

class DeleteTvChannelFromMatchUseCase
    implements UseCase<void, DeleteTvChannelParams> {
  final MatchDetailRepository repository;

  DeleteTvChannelFromMatchUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTvChannelParams params) async {
    return await repository.deleteTvChannelFromMatch(
        params.matchId, params.itemId);
  }
}

class DeleteTvChannelParams extends Equatable {
  final String matchId;
  final String itemId;

  const DeleteTvChannelParams({required this.matchId, required this.itemId});

  @override
  List<Object?> get props => [matchId, itemId];
}
