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
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).asyncExpand(mapper),
    );
  }

  Future<void> _onGetMatches(GetMatches event, Emitter<MatchesState> emit) async {
    emit(MatchesLoading());
    final failureOrCompetitions = await _getMatchesUseCase(
      GetMatchesParams(
        search: event.search,
        ordering: event.ordering,
        isLive: event.isLive,
        startTimestamp: event.startTimestamp,
        endTimestamp: event.endTimestamp,
      ),
    );

    failureOrCompetitions.fold(
      (failure) => emit(MatchesError(failure.message)),
      (competitions) => emit(MatchesLoaded(competitions)),
    );
  }
}
