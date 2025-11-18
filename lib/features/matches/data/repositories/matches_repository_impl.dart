import 'package:dio/dio.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/competition_entity.dart';
import '../../domain/repositories/matches_repository.dart';
import '../datasources/matches_remote_datasource.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  final MatchesRemoteDataSource _remoteDataSource;

  MatchesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<CompetitionEntity>>> getMatches({
    String? search,
    String? ordering,
    bool? isLive,
    int? startTimestamp,
    int? endTimestamp,
  }) async {
    try {
      final competitionModels = await _remoteDataSource.getMatches(
        search: search,
        ordering: ordering,
        isLive: isLive,
        startTimestamp: startTimestamp,
        endTimestamp: endTimestamp,
      );
      return Right(competitionModels.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      if (e.error is AppException) {
        return Left(ServerFailure(message: (e.error as AppException).toString()));
      }
      return Left(ServerFailure(message: e.message ?? 'Unknown Dio Error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
