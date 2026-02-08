import 'package:equatable/equatable.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsEntity> news;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const NewsLoaded(this.news,
      {this.hasReachedMax = false, this.isLoadingMore = false});

  NewsLoaded copyWith({
    List<NewsEntity>? news,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return NewsLoaded(
      news ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [news, hasReachedMax, isLoadingMore];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsOperationSuccess extends NewsState {
  final String message;

  const NewsOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}
