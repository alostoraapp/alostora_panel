part of 'team_detail_bloc.dart';

abstract class TeamDetailEvent extends Equatable {
  const TeamDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTeamDetailEvent extends TeamDetailEvent {
  final String teamId;

  const GetTeamDetailEvent({required this.teamId});

  @override
  List<Object> get props => [teamId];
}

class UpdateTeamEvent extends TeamDetailEvent {
  final String teamId;
  final Map<String, dynamic> body;

  const UpdateTeamEvent({required this.teamId, required this.body});

  @override
  List<Object> get props => [teamId, body];
}

class UpdateCoachEvent extends TeamDetailEvent {
  final String teamId; // Need teamId to refresh team details
  final String coachId;
  final Map<String, dynamic> body;

  const UpdateCoachEvent({
    required this.teamId,
    required this.coachId,
    required this.body,
  });

  @override
  List<Object> get props => [teamId, coachId, body];
}

class UpdateVenueEvent extends TeamDetailEvent {
  final String teamId;
  final String venueId;
  final Map<String, dynamic> body;

  const UpdateVenueEvent({
    required this.teamId,
    required this.venueId,
    required this.body,
  });

  @override
  List<Object> get props => [teamId, venueId, body];
}

class GetSquadEvent extends TeamDetailEvent {
  final String teamId;

  const GetSquadEvent({required this.teamId});

  @override
  List<Object> get props => [teamId];
}

class UpdatePlayerEvent extends TeamDetailEvent {
  final String teamId;
  final String playerId;
  final Map<String, dynamic> body;

  const UpdatePlayerEvent({
    required this.teamId,
    required this.playerId,
    required this.body,
  });

  @override
  List<Object> get props => [teamId, playerId, body];
}
