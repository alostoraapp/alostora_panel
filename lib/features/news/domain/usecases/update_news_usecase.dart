import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';

class UpdateNewsUseCase {
  final NewsRepository repository;

  UpdateNewsUseCase(this.repository);

  Future<Either<Failure, NewsEntity>> call(
      String id, Map<String, dynamic> newsData) {
    return repository.updateNews(id, newsData);
  }
}
