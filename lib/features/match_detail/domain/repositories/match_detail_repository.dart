import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/incident_entity.dart';
import '../entities/lineup_entity.dart';
import '../entities/highlight_entity.dart';
import '../entities/broadcast_entity.dart';
import '../entities/tv_channel_entity.dart';
import '../entities/match_tv_channel_entity.dart';
import '../entities/commentator_entity.dart';
import '../entities/match_commentator_entity.dart';

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
  Future<Either<Failure, void>> approveIncidentMedia({
    required String matchId,
    required String incidentId,
    required String status,
    required String priority,
  });

  // Highlights
  Future<Either<Failure, List<HighlightEntity>>> getHighlights(String matchId);
  Future<Either<Failure, void>> createHighlight(
      String matchId, Map<String, dynamic> params);
  Future<Either<Failure, void>> updateHighlight(
      String matchId, String highlightId, Map<String, dynamic> params);
  Future<Either<Failure, void>> deleteHighlight(
      String matchId, String highlightId);
  Future<Either<Failure, void>> approveHighlight(
      String matchId, String highlightId, String status, String priority);

  // Broadcasts
  Future<Either<Failure, List<BroadcastEntity>>> getBroadcasts(String matchId);
  Future<Either<Failure, void>> createBroadcast(
      String matchId, Map<String, dynamic> params);
  Future<Either<Failure, void>> updateBroadcast(
      String matchId, String broadcastId, Map<String, dynamic> params);
  Future<Either<Failure, void>> deleteBroadcast(
      String matchId, String broadcastId);
  Future<Either<Failure, List<TvChannelEntity>>> searchTvChannels(
      String query, int page);

  // Match TV Channels
  Future<Either<Failure, List<MatchTvChannelEntity>>> getMatchTvChannels(
      String matchId);
  Future<Either<Failure, void>> addTvChannelToMatch(
      String matchId, String tvChannelId);
  Future<Either<Failure, void>> deleteTvChannelFromMatch(
      String matchId, String itemId);

  Future<Either<Failure, List<CommentatorEntity>>> searchCommentators(
      String query, int page);

  // Match Commentators
  Future<Either<Failure, List<MatchCommentatorEntity>>> getMatchCommentators(
      String matchId);
  Future<Either<Failure, void>> addCommentatorToMatch(
      String matchId, String commentatorId);
  Future<Either<Failure, void>> deleteCommentatorFromMatch(
      String matchId, String itemId);
}
