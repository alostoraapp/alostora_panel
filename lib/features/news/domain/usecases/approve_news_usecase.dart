import 'package:alostora/core/utils/either.dart';
import 'package:alostora/core/error/failure.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';

class ApproveNewsUseCase {
  final NewsRepository repository;

  ApproveNewsUseCase(this.repository);

  Future<Either<Failure, void>> call(
      String id, Map<String, dynamic> statusData) {
    return repository.approveNews(id, statusData);
  }
}
