import 'package:equatable/equatable.dart';

abstract class SearchCompetitionsEvent extends Equatable {
  const SearchCompetitionsEvent();

  @override
  List<Object?> get props => [];
}

class SearchCompetitionsQueryChanged extends SearchCompetitionsEvent {
  final String query;

  const SearchCompetitionsQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadMoreCompetitions extends SearchCompetitionsEvent {
  const LoadMoreCompetitions();
}
