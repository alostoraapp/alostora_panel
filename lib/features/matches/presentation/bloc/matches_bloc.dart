import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/get_matches_usecase.dart';
import 'matches_event.dart';
import 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final GetMatchesUseCase _getMatchesUseCase;

  MatchesBloc(this._getMatchesUseCase) : super(MatchesInitial()) {
    on<GetMatches>(
      _onGetMatches,
      // Use switchMap to cancel previous requests and only handle the latest.
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
    on<ChangeDate>(_onChangeDate);
  }

  void _onChangeDate(ChangeDate event, Emitter<MatchesState> emit) {
    // Do nothing if the date is the same
    if (state.selectedDate == event.newDate) return;

    // Emit a new state with the new date. This will be the current state
    // when _onGetMatches is called.
    emit(MatchesLoading(selectedDate: event.newDate));
    
    // Trigger fetching matches for the new date.
    add(const GetMatches());
  }

  Future<void> _onGetMatches(GetMatches event, Emitter<MatchesState> emit) async {
    final date = state.selectedDate ?? DateTime.now();

    // Ensure we are in a loading state before fetching data.
    if (state is! MatchesLoading) {
      emit(MatchesLoading(selectedDate: date));
    }

    final startTimestamp = DateTime(date.year, date.month, date.day).toUtc().millisecondsSinceEpoch ~/ 1000;
    final endTimestamp = DateTime(date.year, date.month, date.day, 23, 59, 59).toUtc().millisecondsSinceEpoch ~/ 1000;

    final failureOrCompetitions = await _getMatchesUseCase(
      GetMatchesParams(
        search: event.search,
        ordering: event.ordering,
        isLive: event.isLive,
        startTimestamp: startTimestamp,
        endTimestamp: endTimestamp,
      ),
    );

    // After fetching, emit either an error or the loaded state.
    // The selectedDate from the current state is passed along.
    failureOrCompetitions.fold(
      (failure) => emit(MatchesError(failure.message, selectedDate: state.selectedDate)),
      (competitions) => emit(MatchesLoaded(competitions, selectedDate: state.selectedDate)),
    );
  }
}
