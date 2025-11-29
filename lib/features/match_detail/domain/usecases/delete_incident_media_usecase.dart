import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/incident_entity.dart';
import '../repositories/match_detail_repository.dart';

class DeleteIncidentMediaParams {
  final String matchId;
  final String incidentId;

  DeleteIncidentMediaParams({
    required this.matchId,
    required this.incidentId,
  });
}

class DeleteIncidentMediaUseCase
    implements UseCase<List<IncidentEntity>, DeleteIncidentMediaParams> {
  final MatchDetailRepository repository;

  DeleteIncidentMediaUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncidentEntity>>> call(
      DeleteIncidentMediaParams params) async {
    return await repository.deleteIncidentMedia(
      params.matchId,
      params.incidentId,
    );
  }
}
