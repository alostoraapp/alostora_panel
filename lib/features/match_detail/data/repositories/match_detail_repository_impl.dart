import 'package:image_picker/image_picker.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/incident_entity.dart';
import '../../domain/entities/lineup_entity.dart';
import '../../domain/entities/highlight_entity.dart';
import '../../domain/entities/broadcast_entity.dart';
import '../../domain/entities/tv_channel_entity.dart';
import '../../domain/entities/match_tv_channel_entity.dart';
import '../../domain/repositories/match_detail_repository.dart';

import '../datasources/match_detail_remote_data_source.dart';

class MatchDetailRepositoryImpl implements MatchDetailRepository {
  final MatchDetailRemoteDataSource remoteDataSource;

  const MatchDetailRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LineupEntity>> getLineup(String matchId) async {
    try {
      final remoteLineup = await remoteDataSource.getLineup(matchId);
      return Right(remoteLineup);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LineupEntity>> updateManOfTheMatch(
      String matchId, String playerLineupId) async {
    try {
      final remoteLineup =
          await remoteDataSource.updateManOfTheMatch(matchId, playerLineupId);
      return Right(remoteLineup);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IncidentEntity>>> getMatchIncidents(
      String matchId) async {
    try {
      final remoteIncidents = await remoteDataSource.getMatchIncidents(matchId);
      return Right(remoteIncidents);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IncidentEntity>>> updateIncidentMedia(
      String matchId,
      String incidentId,
      String? mediaUrl,
      XFile? mediaCover,
      int? videoTime) async {
    try {
      final result = await remoteDataSource.updateIncidentMedia(
          matchId, incidentId, mediaUrl, mediaCover, videoTime);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IncidentEntity>>> deleteIncidentMedia(
      String matchId, String incidentId) async {
    try {
      final remoteIncidents =
          await remoteDataSource.deleteIncidentMedia(matchId, incidentId);
      return Right(remoteIncidents);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approveIncidentMedia({
    required String matchId,
    required String incidentId,
    required String status,
    required String priority,
  }) async {
    try {
      await remoteDataSource.approveIncidentMedia(
          matchId, incidentId, status, priority);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // Highlights Implementation
  @override
  Future<Either<Failure, List<HighlightEntity>>> getHighlights(
      String matchId) async {
    try {
      final result = await remoteDataSource.getHighlights(matchId);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createHighlight(
      String matchId, Map<String, dynamic> params) async {
    try {
      await remoteDataSource.createHighlight(matchId, params);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHighlight(
      String matchId, String highlightId, Map<String, dynamic> params) async {
    try {
      await remoteDataSource.updateHighlight(matchId, highlightId, params);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHighlight(
      String matchId, String highlightId) async {
    try {
      await remoteDataSource.deleteHighlight(matchId, highlightId);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approveHighlight(String matchId,
      String highlightId, String status, String priority) async {
    try {
      await remoteDataSource.approveHighlight(
          matchId, highlightId, status, priority);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // Broadcasts Implementation
  @override
  Future<Either<Failure, List<BroadcastEntity>>> getBroadcasts(
      String matchId) async {
    try {
      final result = await remoteDataSource.getBroadcasts(matchId);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createBroadcast(
      String matchId, Map<String, dynamic> params) async {
    try {
      await remoteDataSource.createBroadcast(matchId, params);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBroadcast(
      String matchId, String broadcastId, Map<String, dynamic> params) async {
    try {
      await remoteDataSource.updateBroadcast(matchId, broadcastId, params);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBroadcast(
      String matchId, String broadcastId) async {
    try {
      await remoteDataSource.deleteBroadcast(matchId, broadcastId);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TvChannelEntity>>> searchTvChannels(
      String query, int page) async {
    try {
      final result = await remoteDataSource.searchTvChannels(query, page);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // Match TV Channels
  @override
  Future<Either<Failure, List<MatchTvChannelEntity>>> getMatchTvChannels(
      String matchId) async {
    try {
      final result = await remoteDataSource.getMatchTvChannels(matchId);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTvChannelToMatch(
      String matchId, String tvChannelId) async {
    try {
      await remoteDataSource.addTvChannelToMatch(matchId, tvChannelId);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTvChannelFromMatch(
      String matchId, String itemId) async {
    try {
      await remoteDataSource.deleteTvChannelFromMatch(matchId, itemId);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
