import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../../../core/utils/either.dart';
import '../../entities/news_category.dart';
import '../../repositories/news_category_repository.dart';

class UpdateNewsCategoryUseCase
    implements UseCase<NewsCategory, UpdateNewsCategoryParams> {
  final NewsCategoryRepository repository;

  UpdateNewsCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, NewsCategory>> call(
      UpdateNewsCategoryParams params) async {
    return await repository.updateNewsCategory(params.id, params.body);
  }
}

class UpdateNewsCategoryParams extends Equatable {
  final String id;
  final Map<String, dynamic> body;

  const UpdateNewsCategoryParams({required this.id, required this.body});

  @override
  List<Object?> get props => [id, body];
}
