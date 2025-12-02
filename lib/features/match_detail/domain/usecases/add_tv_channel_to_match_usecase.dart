import '../../../../core/utils/either.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/match_detail_repository.dart';

class AddTvChannelToMatchUseCase implements UseCase<void, AddTvChannelParams> {
  final MatchDetailRepository repository;

  AddTvChannelToMatchUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddTvChannelParams params) async {
    return await repository.addTvChannelToMatch(
        params.matchId, params.tvChannelId);
  }
}

class AddTvChannelParams extends Equatable {
  final String matchId;
  final String tvChannelId;

  const AddTvChannelParams({required this.matchId, required this.tvChannelId});

  @override
  List<Object?> get props => [matchId, tvChannelId];
}
