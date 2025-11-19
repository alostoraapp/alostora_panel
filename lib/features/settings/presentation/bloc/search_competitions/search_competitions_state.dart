import 'package:equatable/equatable.dart';
import '../../../domain/entities/competition_search_entity.dart';

enum SearchCompetitionsStatus { initial, loading, success, failure }

class SearchCompetitionsState extends Equatable {
  final SearchCompetitionsStatus status;
  final List<CompetitionSearchEntity> competitions;
  final bool hasReachedMax;
  final String query;
  final int page;
  final String? errorMessage;

  const SearchCompetitionsState({
    this.status = SearchCompetitionsStatus.initial,
    this.competitions = const [],
    this.hasReachedMax = false,
    this.query = '',
    this.page = 1,
    this.errorMessage,
  });

  SearchCompetitionsState copyWith({
    SearchCompetitionsStatus? status,
    List<CompetitionSearchEntity>? competitions,
    bool? hasReachedMax,
    String? query,
    int? page,
    String? errorMessage,
  }) {
    return SearchCompetitionsState(
      status: status ?? this.status,
      competitions: competitions ?? this.competitions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query ?? this.query,
      page: page ?? this.page,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, competitions, hasReachedMax, query, page, errorMessage];
}
