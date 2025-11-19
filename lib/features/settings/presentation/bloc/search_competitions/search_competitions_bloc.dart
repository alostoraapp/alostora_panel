import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/search_competitions_usecase.dart';
import 'search_competitions_event.dart';
import 'search_competitions_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

class SearchCompetitionsBloc extends Bloc<SearchCompetitionsEvent, SearchCompetitionsState> {
  final SearchCompetitionsUseCase searchCompetitions;

  SearchCompetitionsBloc(this.searchCompetitions) : super(const SearchCompetitionsState()) {
    on<SearchCompetitionsQueryChanged>(
      _onQueryChanged,
      transformer: debounce(_duration),
    );
    on<LoadMoreCompetitions>(
      _onLoadMore,
      transformer: debounce(_duration),
    );
  }

  Future<void> _onQueryChanged(SearchCompetitionsQueryChanged event, Emitter<SearchCompetitionsState> emit) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        status: SearchCompetitionsStatus.initial,
        competitions: [],
        hasReachedMax: false,
        query: '',
        page: 1,
      ));
      return;
    }

    emit(state.copyWith(
      status: SearchCompetitionsStatus.loading,
      query: event.query,
      page: 1,
      competitions: [],
      hasReachedMax: false,
    ));

    final result = await searchCompetitions(query: event.query, page: 1, pageSize: 10);

    result.fold(
      (failure) => emit(state.copyWith(status: SearchCompetitionsStatus.failure, errorMessage: failure.message)),
      (competitions) {
        emit(state.copyWith(
          status: SearchCompetitionsStatus.success,
          competitions: competitions,
          hasReachedMax: competitions.length < 10,
          page: 1,
        ));
      },
    );
  }

  Future<void> _onLoadMore(LoadMoreCompetitions event, Emitter<SearchCompetitionsState> emit) async {
    if (state.hasReachedMax || state.status == SearchCompetitionsStatus.loading) return;

    final nextPage = state.page + 1;
    final result = await searchCompetitions(query: state.query, page: nextPage, pageSize: 10);

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (newCompetitions) {
        if (newCompetitions.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          emit(state.copyWith(
            status: SearchCompetitionsStatus.success,
            competitions: List.of(state.competitions)..addAll(newCompetitions),
            hasReachedMax: newCompetitions.length < 10,
            page: nextPage,
          ));
        }
      },
    );
  }
}
