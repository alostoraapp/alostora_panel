import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/incident_entity.dart';
import '../repositories/match_detail_repository.dart';

class GetMatchIncidentsUseCase
    implements UseCase<List<IncidentEntity>, String> {
  final MatchDetailRepository repository;

  GetMatchIncidentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncidentEntity>>> call(String matchId) async {
    return await repository.getMatchIncidents(matchId);
  }
}
