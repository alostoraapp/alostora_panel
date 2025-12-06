import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/app_exception.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/data/datasources/news_remote_data_source.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews(
      {int limit = 10, int offset = 0}) async {
    try {
      final news = await remoteDataSource.getNews(limit: limit, offset: offset);
      return Right(news);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> createNews(
      Map<String, dynamic> newsData) async {
    try {
      final news = await remoteDataSource.createNews(newsData);
      return Right(news);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> updateNews(
      String id, Map<String, dynamic> newsData) async {
    try {
      final news = await remoteDataSource.updateNews(id, newsData);
      return Right(news);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNews(String id) async {
    try {
      await remoteDataSource.deleteNews(id);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approveNews(
      String id, Map<String, dynamic> statusData) async {
    try {
      await remoteDataSource.approveNews(id, statusData);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(message: e.errorResponse.firstError));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
