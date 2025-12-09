part of 'team_detail_bloc.dart';

abstract class TeamDetailState extends Equatable {
  const TeamDetailState();

  @override
  List<Object?> get props => [];
}

class TeamDetailInitial extends TeamDetailState {}

class TeamDetailLoading extends TeamDetailState {}

class TeamDetailLoaded extends TeamDetailState {
  final TeamDetailEntity team;

  const TeamDetailLoaded({required this.team});

  @override
  List<Object> get props => [team];
}

class TeamDetailError extends TeamDetailState {
  final String message;

  const TeamDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

class TeamDetailUpdating extends TeamDetailState {
  final TeamDetailEntity? team;

  const TeamDetailUpdating({this.team});

  @override
  List<Object?> get props => [team];
}

class TeamDetailUpdated extends TeamDetailState {
  final TeamDetailEntity team;

  const TeamDetailUpdated({required this.team});

  @override
  List<Object> get props => [team];
}

class TeamCoachUpdated extends TeamDetailState {
  final TeamCoachEntity coach;

  const TeamCoachUpdated({required this.coach});

  @override
  List<Object> get props => [coach];
}

class TeamVenueUpdated extends TeamDetailState {
  final TeamVenueEntity venue;

  const TeamVenueUpdated({required this.venue});

  @override
  List<Object> get props => [venue];
}

class TeamDetailUpdateError extends TeamDetailState {
  final String message;

  const TeamDetailUpdateError({required this.message});

  @override
  List<Object> get props => [message];
}

class TeamSquadLoaded extends TeamDetailState {
  final List<SquadMemberEntity> squad;
  final TeamDetailEntity? team;

  const TeamSquadLoaded({required this.squad, this.team});

  @override
  List<Object?> get props => [squad, team];
}

class TeamPlayerUpdated extends TeamDetailState {
  final PlayerEntity player;
  final TeamDetailEntity? team;

  const TeamPlayerUpdated({required this.player, this.team});

  @override
  List<Object?> get props => [player, team];
}
