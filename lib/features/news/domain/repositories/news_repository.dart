import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/domain/entities/team_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getNews(
      {int limit = 10, int offset = 0, String? categoryId});
  Future<Either<Failure, NewsEntity>> createNews(Map<String, dynamic> newsData);
  Future<Either<Failure, NewsEntity>> updateNews(
      String id, Map<String, dynamic> newsData);
  Future<Either<Failure, void>> deleteNews(String id);
  Future<Either<Failure, void>> approveNews(
      String id, Map<String, dynamic> statusData);
  Future<Either<Failure, NewsImageEntity>> uploadNewsImage(
      String id, dynamic image,
      {void Function(int, int)? onSendProgress});
  Future<Either<Failure, List<TeamEntity>>> searchTeams(String query);
}
