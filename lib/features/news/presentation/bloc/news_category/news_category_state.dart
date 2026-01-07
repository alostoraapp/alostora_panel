import 'package:equatable/equatable.dart';
import '../../../domain/entities/news_category.dart';

abstract class NewsCategoryState extends Equatable {
  const NewsCategoryState();

  @override
  List<Object?> get props => [];
}

class NewsCategoryInitial extends NewsCategoryState {}

class NewsCategoryLoading extends NewsCategoryState {}

class NewsCategoryLoaded extends NewsCategoryState {
  final List<NewsCategory> categories;

  const NewsCategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class NewsCategoryError extends NewsCategoryState {
  final String message;

  const NewsCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
