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
