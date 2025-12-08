import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/team_detail_entity.dart';
import '../repositories/team_repository.dart';

class UpdateVenueUseCase
    implements UseCase<TeamVenueEntity, UpdateVenueParams> {
  final TeamRepository repository;

  UpdateVenueUseCase(this.repository);

  @override
  Future<Either<Failure, TeamVenueEntity>> call(
      UpdateVenueParams params) async {
    return await repository.updateVenue(params.venueId, params.body);
  }
}

class UpdateVenueParams extends Equatable {
  final String venueId;
  final Map<String, dynamic> body;

  const UpdateVenueParams({required this.venueId, required this.body});

  @override
  List<Object> get props => [venueId, body];
}
