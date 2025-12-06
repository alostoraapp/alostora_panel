import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';

class CreateNewsUseCase {
  final NewsRepository repository;

  CreateNewsUseCase(this.repository);

  Future<Either<Failure, NewsEntity>> call(Map<String, dynamic> newsData) {
    return repository.createNews(newsData);
  }
}
