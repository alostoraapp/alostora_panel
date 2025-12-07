import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/team_detail_entity.dart';
import '../../domain/usecases/get_team_detail_usecase.dart';
import '../../domain/usecases/update_team_usecase.dart';

part 'team_detail_event.dart';
part 'team_detail_state.dart';

class TeamDetailBloc extends Bloc<TeamDetailEvent, TeamDetailState> {
  final GetTeamDetailUseCase getTeamDetail;
  final UpdateTeamUseCase updateTeam;

  TeamDetailBloc({
    required this.getTeamDetail,
    required this.updateTeam,
  }) : super(TeamDetailInitial()) {
    on<GetTeamDetailEvent>(_onGetTeamDetail);
    on<UpdateTeamEvent>(_onUpdateTeam);
  }

  Future<void> _onGetTeamDetail(
    GetTeamDetailEvent event,
    Emitter<TeamDetailState> emit,
  ) async {
    emit(TeamDetailLoading());
    final result = await getTeamDetail(event.teamId);
    result.fold(
      (failure) => emit(TeamDetailError(
          message: failure.toString())), // Map failure to message
      (team) => emit(TeamDetailLoaded(team: team)),
    );
  }

  Future<void> _onUpdateTeam(
    UpdateTeamEvent event,
    Emitter<TeamDetailState> emit,
  ) async {
    emit(TeamDetailUpdating());
    final result = await updateTeam(UpdateTeamParams(
      teamId: event.teamId,
      body: event.body,
    ));
    result.fold(
      (failure) => emit(TeamDetailUpdateError(message: failure.toString())),
      (team) => emit(TeamDetailUpdated(team: team)),
    );
  }
}
