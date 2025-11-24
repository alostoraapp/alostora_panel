import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/lineup_entity.dart';
import '../../domain/usecases/get_lineup_usecase.dart';

part 'lineup_event.dart';
part 'lineup_state.dart';

class LineupBloc extends Bloc<LineupEvent, LineupState> {
  final GetLineupUsecase _getLineupUsecase;

  LineupBloc({required GetLineupUsecase getLineupUsecase})
      : _getLineupUsecase = getLineupUsecase,
        super(LineupInitial()) {
    on<GetLineupEvent>(_onGetLineup);
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
}
