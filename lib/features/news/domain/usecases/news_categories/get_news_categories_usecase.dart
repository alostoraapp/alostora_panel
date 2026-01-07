import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../../../core/utils/either.dart';
import '../../entities/news_category.dart';
import '../../repositories/news_category_repository.dart';

class GetNewsCategoriesUseCase
    implements UseCase<List<NewsCategory>, NoParams> {
  final NewsCategoryRepository repository;

  GetNewsCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<NewsCategory>>> call(NoParams params) async {
    return await repository.getNewsCategories();
  }
}
