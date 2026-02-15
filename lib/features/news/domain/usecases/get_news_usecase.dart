import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<Either<Failure, List<NewsEntity>>> call(
      {int limit = 10, int offset = 0, String? categoryId, String? search}) {
    return repository.getNews(
        limit: limit, offset: offset, categoryId: categoryId, search: search);
  }
}
