import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../../../core/utils/either.dart';
import '../../entities/news_category.dart';
import '../../repositories/news_category_repository.dart';

class AddNewsCategoryUseCase
    implements UseCase<NewsCategory, Map<String, dynamic>> {
  final NewsCategoryRepository repository;

  AddNewsCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, NewsCategory>> call(
      Map<String, dynamic> params) async {
    return await repository.addNewsCategory(params);
  }
}
