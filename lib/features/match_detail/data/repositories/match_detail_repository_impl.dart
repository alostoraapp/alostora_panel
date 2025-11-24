import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/lineup_entity.dart';
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
}
