part of 'match_incidents_bloc.dart';

abstract class MatchIncidentsState extends Equatable {
  const MatchIncidentsState();

  @override
  List<Object> get props => [];
}

class MatchIncidentsInitial extends MatchIncidentsState {}

class MatchIncidentsLoading extends MatchIncidentsState {}

class MatchIncidentsLoaded extends MatchIncidentsState {
  final List<IncidentEntity> incidents;

  const MatchIncidentsLoaded(this.incidents);

  @override
  List<Object> get props => [incidents];
}

class MatchIncidentsError extends MatchIncidentsState {
  final String message;

  const MatchIncidentsError(this.message);

  @override
  List<Object> get props => [message];
}
