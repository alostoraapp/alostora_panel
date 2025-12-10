import 'package:equatable/equatable.dart';

abstract class MatchDetailEvent extends Equatable {
  const MatchDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMatchDetail extends MatchDetailEvent {
  final String matchId;

  const GetMatchDetail(this.matchId);

  @override
  List<Object> get props => [matchId];
}
