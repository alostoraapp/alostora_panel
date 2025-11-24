import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/lineup_entity.dart';
import '../../domain/usecases/get_lineup_usecase.dart';
import '../../domain/usecases/update_man_of_the_match.dart';

part 'lineup_event.dart';
part 'lineup_state.dart';

class LineupBloc extends Bloc<LineupEvent, LineupState> {
  final GetLineupUsecase _getLineupUsecase;
  final UpdateManOfTheMatch _updateManOfTheMatch;

  LineupBloc({
    required GetLineupUsecase getLineupUsecase,
    required UpdateManOfTheMatch updateManOfTheMatch,
  })  : _getLineupUsecase = getLineupUsecase,
        _updateManOfTheMatch = updateManOfTheMatch,
        super(LineupInitial()) {
    on<GetLineupEvent>(_onGetLineup);
    on<UpdateManOfTheMatchEvent>(_onUpdateManOfTheMatch);
  }

  Future<void> _onGetLineup(
    GetLineupEvent event,
    Emitter<LineupState> emit,
  ) async {
    emit(LineupLoading());
    final failureOrLineup =
        await _getLineupUsecase(GetLineupParams(matchId: event.matchId));
    failureOrLineup.fold(
      (failure) => emit(LineupError(message: failure.message)),
      (lineup) => emit(LineupLoaded(lineup: lineup)),
    );
  }

  Future<void> _onUpdateManOfTheMatch(
    UpdateManOfTheMatchEvent event,
    Emitter<LineupState> emit,
  ) async {
    // Check if the current state is LineupLoaded
    if (state is LineupLoaded) {
      final currentState = state as LineupLoaded;

      // Don't emit a loading state that removes the UI.
      // The UI will just rebuild with the new LineupLoaded state.
      final failureOrLineup = await _updateManOfTheMatch(
        UpdateManOfTheMatchParams(
          matchId: event.matchId,
          playerLineupId: event.playerLineupId,
        ),
      );

      failureOrLineup.fold(
        (failure) {
          // If the update fails, we can show an error, but for a better UX,
          // we avoid replacing the whole UI. We'll emit the previous state
          // but ideally, we'd show a snackbar. For now, we revert to the old state.
          // Emitting an error state here would cause the same problem as the loading state.
          emit(LineupError(message: failure.message));
          // To allow the user to see the content again, we re-emit the last known good state.
          emit(currentState);
        },
        // On success, emit the new loaded state with the updated lineup.
        // This will cause the BlocBuilder to rebuild, but since the widget type
        // is the same (BestPlayerTab), its state (_selectedTeamSide) will be preserved.
        (lineup) => emit(LineupLoaded(lineup: lineup)),
      );
    }
  }
}
