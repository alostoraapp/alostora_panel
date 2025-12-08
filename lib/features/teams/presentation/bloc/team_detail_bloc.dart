import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/team_detail_entity.dart';
import '../../domain/entities/squad_entity.dart';
import '../../domain/usecases/get_team_detail_usecase.dart';
import '../../domain/usecases/update_team_usecase.dart';
import '../../domain/usecases/update_coach_use_case.dart';
import '../../domain/usecases/update_venue_use_case.dart';
import '../../domain/usecases/get_squad_use_case.dart';
import '../../domain/usecases/update_player_use_case.dart';

part 'team_detail_event.dart';
part 'team_detail_state.dart';

class TeamDetailBloc extends Bloc<TeamDetailEvent, TeamDetailState> {
  final GetTeamDetailUseCase getTeamDetail;
  final UpdateTeamUseCase updateTeam;
  final UpdateCoachUseCase updateCoach;
  final UpdateVenueUseCase updateVenue;
  final GetSquadUseCase getSquad;
  final UpdatePlayerUseCase updatePlayer;

  TeamDetailBloc({
    required this.getTeamDetail,
    required this.updateTeam,
    required this.updateCoach,
    required this.updateVenue,
    required this.getSquad,
    required this.updatePlayer,
  }) : super(TeamDetailInitial()) {
    on<GetTeamDetailEvent>(_onGetTeamDetail);
    on<UpdateTeamEvent>(_onUpdateTeam);
    on<UpdateCoachEvent>(_onUpdateCoach);
    on<UpdateVenueEvent>(_onUpdateVenue);
    on<GetSquadEvent>(_onGetSquad);
    on<UpdatePlayerEvent>(_onUpdatePlayer);
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

  Future<void> _onUpdateCoach(
    UpdateCoachEvent event,
    Emitter<TeamDetailState> emit,
  ) async {
    emit(TeamDetailUpdating());
    final result = await updateCoach(UpdateCoachParams(
      coachId: event.coachId,
      body: event.body,
    ));
    result.fold(
      (failure) => emit(TeamDetailUpdateError(message: failure.toString())),
      (coach) {
        emit(TeamCoachUpdated(coach: coach));
        // After success, request team details again
        add(GetTeamDetailEvent(teamId: event.teamId));
      },
    );
  }

  Future<void> _onUpdateVenue(
    UpdateVenueEvent event,
    Emitter<TeamDetailState> emit,
  ) async {
    emit(TeamDetailUpdating());
    final result = await updateVenue(UpdateVenueParams(
      venueId: event.venueId,
      body: event.body,
    ));
    result.fold(
      (failure) => emit(TeamDetailUpdateError(message: failure.toString())),
      (venue) {
        emit(TeamVenueUpdated(venue: venue));
        // After success, request team details again
        add(GetTeamDetailEvent(teamId: event.teamId));
      },
    );
  }

  Future<void> _onGetSquad(
    GetSquadEvent event,
    Emitter<TeamDetailState> emit,
  ) async {
    TeamDetailEntity? currentTeam;
    if (state is TeamDetailLoaded) {
      currentTeam = (state as TeamDetailLoaded).team;
    } else if (state is TeamSquadLoaded) {
      currentTeam = (state as TeamSquadLoaded).team;
    } else if (state is TeamDetailUpdated) {
      currentTeam = (state as TeamDetailUpdated).team;
    }

    final result = await getSquad(GetSquadParams(teamId: event.teamId));
    result.fold(
      (failure) => emit(TeamDetailError(message: failure.toString())),
      (squad) => emit(TeamSquadLoaded(squad: squad, team: currentTeam)),
    );
  }

  Future<void> _onUpdatePlayer(
    UpdatePlayerEvent event,
    Emitter<TeamDetailState> emit,
  ) async {
    emit(TeamDetailUpdating());
    final result = await updatePlayer(UpdatePlayerParams(
      playerId: event.playerId,
      body: event.body,
    ));
    result.fold(
      (failure) => emit(TeamDetailUpdateError(message: failure.toString())),
      (player) {
        emit(TeamPlayerUpdated(player: player));
        // Refresh squad
        add(GetSquadEvent(teamId: event.teamId));
      },
    );
  }
}
