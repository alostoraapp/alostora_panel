import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getNews(
      {int limit = 10, int offset = 0});
  Future<Either<Failure, NewsEntity>> createNews(Map<String, dynamic> newsData);
  Future<Either<Failure, NewsEntity>> updateNews(
      String id, Map<String, dynamic> newsData);
  Future<Either<Failure, void>> deleteNews(String id);
  Future<Either<Failure, void>> approveNews(
      String id, Map<String, dynamic> statusData);
}
