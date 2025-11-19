import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/competition_config_entity.dart';
import '../../domain/entities/competition_search_entity.dart';
import '../../domain/repositories/competition_config_repository.dart';
import '../datasources/competition_config_remote_datasource.dart';

class CompetitionConfigRepositoryImpl implements CompetitionConfigRepository {
  final CompetitionConfigRemoteDataSource remoteDataSource;

  CompetitionConfigRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CompetitionConfigEntity>>> getConfigs({String? search}) async {
    try {
      final result = await remoteDataSource.getConfigs(search: search);
      return Right(result);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompetitionConfigEntity>> addConfig(String competitionId) async {
    try {
      final result = await remoteDataSource.addConfig(competitionId);
      return Right(result);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompetitionConfigEntity>> toggleStatus(String id, bool isActive) async {
    try {
      final result = await remoteDataSource.toggleStatus(id, isActive);
      return Right(result);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteConfig(String id) async {
    try {
      await remoteDataSource.deleteConfig(id);
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reorderConfigs(List<String> orderedIds) async {
    try {
      await remoteDataSource.reorderConfigs(orderedIds);
      return const Right(null);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CompetitionSearchEntity>>> searchCompetitions({required String query, int page = 1, int pageSize = 10}) async {
    try {
      final result = await remoteDataSource.searchCompetitions(query: query, page: page, pageSize: pageSize);
      return Right(result);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
