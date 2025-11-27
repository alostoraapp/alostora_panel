import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alostora/features/match_detail/domain/entities/incident_entity.dart';
import 'package:alostora/features/match_detail/domain/usecases/get_match_incidents_usecase.dart';

part 'match_incidents_event.dart';
part 'match_incidents_state.dart';

class MatchIncidentsBloc
    extends Bloc<MatchIncidentsEvent, MatchIncidentsState> {
  final GetMatchIncidentsUseCase getMatchIncidentsUseCase;

  MatchIncidentsBloc({required this.getMatchIncidentsUseCase})
      : super(MatchIncidentsInitial()) {
    on<GetMatchIncidentsEvent>(_onGetMatchIncidents);
  }

  Future<void> _onGetMatchIncidents(
    GetMatchIncidentsEvent event,
    Emitter<MatchIncidentsState> emit,
  ) async {
    emit(MatchIncidentsLoading());
    final result = await getMatchIncidentsUseCase(event.matchId);
    result.fold(
      (failure) => emit(MatchIncidentsError(failure.message)),
      (incidents) => emit(MatchIncidentsLoaded(incidents)),
    );
  }
}
