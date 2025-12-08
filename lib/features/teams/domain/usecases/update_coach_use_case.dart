import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/team_detail_entity.dart';
import '../repositories/team_repository.dart';

class UpdateCoachUseCase
    implements UseCase<TeamCoachEntity, UpdateCoachParams> {
  final TeamRepository repository;

  UpdateCoachUseCase(this.repository);

  @override
  Future<Either<Failure, TeamCoachEntity>> call(
      UpdateCoachParams params) async {
    return await repository.updateCoach(params.coachId, params.body);
  }
}

class UpdateCoachParams extends Equatable {
  final String coachId;
  final Map<String, dynamic> body;

  const UpdateCoachParams({required this.coachId, required this.body});

  @override
  List<Object> get props => [coachId, body];
}
