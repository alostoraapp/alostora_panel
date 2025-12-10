import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/match_entity.dart';
import '../repositories/matches_repository.dart';

class GetMatchUseCase implements UseCase<MatchEntity, String> {
  final MatchesRepository repository;

  GetMatchUseCase(this.repository);

  @override
  Future<Either<Failure, MatchEntity>> call(String params) async {
    return await repository.getMatch(params);
  }
}
