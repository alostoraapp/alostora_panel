import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/incident_entity.dart';
import '../entities/lineup_entity.dart';

import 'package:image_picker/image_picker.dart';

abstract class MatchDetailRepository {
  Future<Either<Failure, LineupEntity>> getLineup(String matchId);
  Future<Either<Failure, LineupEntity>> updateManOfTheMatch(
      String matchId, String playerLineupId);
  Future<Either<Failure, List<IncidentEntity>>> getMatchIncidents(
      String matchId);
  Future<Either<Failure, List<IncidentEntity>>> updateIncidentMedia(
      String matchId,
      String incidentId,
      String? mediaUrl,
      XFile? mediaCover,
      int? videoTime);
  Future<Either<Failure, List<IncidentEntity>>> deleteIncidentMedia(
      String matchId, String incidentId);
}
