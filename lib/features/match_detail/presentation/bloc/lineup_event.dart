part of 'lineup_bloc.dart';

abstract class LineupEvent extends Equatable {
  const LineupEvent();

  @override
  List<Object> get props => [];
}

class GetLineupEvent extends LineupEvent {
  final String matchId;

  const GetLineupEvent({required this.matchId});

  @override
  List<Object> get props => [matchId];
}

class UpdateManOfTheMatchEvent extends LineupEvent {
  final String matchId;
  final String playerLineupId;

  const UpdateManOfTheMatchEvent(
      {required this.matchId, required this.playerLineupId});

  @override
  List<Object> get props => [matchId, playerLineupId];
}
