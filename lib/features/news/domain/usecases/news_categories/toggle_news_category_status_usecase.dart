import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../../../core/utils/either.dart';
import '../../entities/news_category.dart';
import '../../repositories/news_category_repository.dart';

class ToggleNewsCategoryStatusUseCase
    implements UseCase<NewsCategory, ToggleNewsCategoryParam> {
  final NewsCategoryRepository repository;

  ToggleNewsCategoryStatusUseCase(this.repository);

  @override
  Future<Either<Failure, NewsCategory>> call(
      ToggleNewsCategoryParam params) async {
    return await repository.toggleNewsCategoryStatus(
        params.id, params.isActive);
  }
}

class ToggleNewsCategoryParam extends Equatable {
  final String id;
  final bool isActive;

  const ToggleNewsCategoryParam({required this.id, required this.isActive});

  @override
  List<Object?> get props => [id, isActive];
}
