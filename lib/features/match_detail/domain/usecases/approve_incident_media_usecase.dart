import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../repositories/match_detail_repository.dart';

class ApproveIncidentMediaUseCase
    implements UseCase<void, ApproveIncidentMediaParams> {
  final MatchDetailRepository repository;

  ApproveIncidentMediaUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ApproveIncidentMediaParams params) async {
    return await repository.approveIncidentMedia(
      matchId: params.matchId,
      incidentId: params.incidentId,
      status: params.status,
      priority: params.priority,
    );
  }
}

class ApproveIncidentMediaParams extends Equatable {
  final String matchId;
  final String incidentId;
  final String status;
  final String priority;

  const ApproveIncidentMediaParams({
    required this.matchId,
    required this.incidentId,
    required this.status,
    required this.priority,
  });

  @override
  List<Object?> get props => [matchId, incidentId, status, priority];
}
