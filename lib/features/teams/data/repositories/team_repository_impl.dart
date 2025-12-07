import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/team_detail_entity.dart';
import '../../domain/repositories/team_repository.dart';
import '../datasources/team_remote_data_source.dart';

class TeamRepositoryImpl implements TeamRepository {
  final TeamRemoteDataSource remoteDataSource;

  TeamRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, TeamDetailEntity>> getTeamDetail(String teamId) async {
    try {
      final remoteTeam = await remoteDataSource.getTeamDetail(teamId);
      return Right(remoteTeam);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TeamDetailEntity>> updateTeam(
      String teamId, Map<String, dynamic> body) async {
    try {
      final remoteTeam = await remoteDataSource.updateTeam(teamId, body);
      return Right(remoteTeam);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
