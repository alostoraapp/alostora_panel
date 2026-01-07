import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../../../core/utils/either.dart';
import '../../repositories/news_category_repository.dart';

class DeleteNewsCategoryUseCase implements UseCase<void, String> {
  final NewsCategoryRepository repository;

  DeleteNewsCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteNewsCategory(params);
  }
}
