import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/team_detail_entity.dart';
import '../../domain/entities/squad_entity.dart';
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

  @override
  Future<Either<Failure, TeamCoachEntity>> updateCoach(
      String coachId, Map<String, dynamic> body) async {
    try {
      final remoteCoach = await remoteDataSource.updateCoach(coachId, body);
      return Right(remoteCoach);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TeamVenueEntity>> updateVenue(
      String venueId, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.updateVenue(venueId, body);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SquadMemberEntity>>> getSquad(
      String teamId) async {
    try {
      final result = await remoteDataSource.getSquad(teamId);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlayerEntity>> updatePlayer(
      String playerId, Map<String, dynamic> data) async {
    try {
      final result = await remoteDataSource.updatePlayer(playerId, data);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
