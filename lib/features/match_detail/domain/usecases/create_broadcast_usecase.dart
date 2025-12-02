import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../repositories/match_detail_repository.dart';

class CreateBroadcastParams {
  final String matchId;
  final Map<String, dynamic> params;

  CreateBroadcastParams({required this.matchId, required this.params});
}

class CreateBroadcastUseCase implements UseCase<void, CreateBroadcastParams> {
  final MatchDetailRepository repository;

  CreateBroadcastUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateBroadcastParams params) async {
    return await repository.createBroadcast(params.matchId, params.params);
  }
}
