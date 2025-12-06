import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';

class DeleteNewsUseCase {
  final NewsRepository repository;

  DeleteNewsUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteNews(id);
  }
}
