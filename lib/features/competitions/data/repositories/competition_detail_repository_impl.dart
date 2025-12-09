import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/competition_detail_entity.dart';
import '../../domain/repositories/competition_detail_repository.dart';
import '../datasources/competition_detail_remote_data_source.dart';

class CompetitionDetailRepositoryImpl implements CompetitionDetailRepository {
  final CompetitionDetailRemoteDataSource remoteDataSource;

  CompetitionDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CompetitionDetailEntity>> getCompetitionDetail(
      String id) async {
    try {
      final remoteCompetition = await remoteDataSource.getCompetitionDetail(id);
      return Right(remoteCompetition);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompetitionDetailEntity>> updateCompetitionDetail(
      String id, Map<String, dynamic> body) async {
    try {
      final remoteCompetition =
          await remoteDataSource.updateCompetitionDetail(id, body);
      return Right(remoteCompetition);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
