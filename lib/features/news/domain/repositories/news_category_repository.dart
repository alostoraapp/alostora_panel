import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../entities/news_category.dart';

abstract class NewsCategoryRepository {
  Future<Either<Failure, List<NewsCategory>>> getNewsCategories();
  Future<Either<Failure, NewsCategory>> addNewsCategory(
      Map<String, dynamic> body);
  Future<Either<Failure, NewsCategory>> updateNewsCategory(
      String id, Map<String, dynamic> body);
  Future<Either<Failure, NewsCategory>> getNewsCategory(String id);
  Future<Either<Failure, NewsCategory>> toggleNewsCategoryStatus(
      String id, bool isActive);
  Future<Either<Failure, void>> deleteNewsCategory(String id);
  Future<Either<Failure, void>> reorderNewsCategories(List<String> orderedIds);
}
