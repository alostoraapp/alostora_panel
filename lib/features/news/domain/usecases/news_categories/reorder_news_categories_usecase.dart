import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../../../core/utils/either.dart';
import '../../repositories/news_category_repository.dart';

class ReorderNewsCategoriesUseCase implements UseCase<void, List<String>> {
  final NewsCategoryRepository repository;

  ReorderNewsCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(List<String> params) async {
    return await repository.reorderNewsCategories(params);
  }
}
