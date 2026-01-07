import '../../../../core/utils/either.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../datasources/news_category_remote_data_source.dart';
import '../../domain/entities/news_category.dart';
import '../../domain/repositories/news_category_repository.dart';

class NewsCategoryRepositoryImpl implements NewsCategoryRepository {
  final NewsCategoryRemoteDataSource remoteDataSource;

  NewsCategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NewsCategory>>> getNewsCategories() async {
    try {
      final remoteNewsCategories = await remoteDataSource.getNewsCategories();
      return Right(remoteNewsCategories);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NewsCategory>> addNewsCategory(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.addNewsCategory(body);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NewsCategory>> updateNewsCategory(
      String id, Map<String, dynamic> body) async {
    try {
      final remoteNewsCategory =
          await remoteDataSource.updateNewsCategory(id, body);
      return Right(remoteNewsCategory.toEntity());
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NewsCategory>> getNewsCategory(String id) async {
    try {
      final result = await remoteDataSource.getNewsCategory(id);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NewsCategory>> toggleNewsCategoryStatus(
      String id, bool isActive) async {
    try {
      final result =
          await remoteDataSource.toggleNewsCategoryStatus(id, isActive);
      return Right(result);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNewsCategory(String id) async {
    try {
      await remoteDataSource.deleteNewsCategory(id);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reorderNewsCategories(
      List<String> orderedIds) async {
    try {
      await remoteDataSource.reorderNewsCategories(orderedIds);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
