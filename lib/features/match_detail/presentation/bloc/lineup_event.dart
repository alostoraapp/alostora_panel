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
