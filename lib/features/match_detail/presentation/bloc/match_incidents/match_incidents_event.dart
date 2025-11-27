part of 'match_incidents_bloc.dart';

abstract class MatchIncidentsEvent extends Equatable {
  const MatchIncidentsEvent();

  @override
  List<Object> get props => [];
}

class GetMatchIncidentsEvent extends MatchIncidentsEvent {
  final String matchId;

  const GetMatchIncidentsEvent(this.matchId);

  @override
  List<Object> get props => [matchId];
}
