import 'package:image_picker/image_picker.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../entities/incident_entity.dart';
import '../repositories/match_detail_repository.dart';

class UpdateIncidentMediaParams {
  final String matchId;
  final String incidentId;
  final String? mediaUrl;
  final XFile? mediaCover;
  final int? videoTime;

  UpdateIncidentMediaParams({
    required this.matchId,
    required this.incidentId,
    this.mediaUrl,
    this.mediaCover,
    this.videoTime,
  });
}

class UpdateIncidentMediaUseCase
    implements UseCase<List<IncidentEntity>, UpdateIncidentMediaParams> {
  final MatchDetailRepository repository;

  UpdateIncidentMediaUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncidentEntity>>> call(
      UpdateIncidentMediaParams params) async {
    return await repository.updateIncidentMedia(
      params.matchId,
      params.incidentId,
      params.mediaUrl,
      params.mediaCover,
      params.videoTime,
    );
  }
}
