import 'package:equatable/equatable.dart';

import 'player_lineup_entity.dart';
import 'team_lineup_info_entity.dart';

class LineupEntity extends Equatable {
  final TeamLineupInfoEntity homeTeam;
  final TeamLineupInfoEntity awayTeam;
  final List<PlayerLineupEntity> players;
  final String? homeFormation;
  final String? awayFormation;
  final String? manOfTheMatchId;

  const LineupEntity({
    required this.homeTeam,
    required this.awayTeam,
    required this.players,
    this.homeFormation,
    this.awayFormation,
    this.manOfTheMatchId,
  });

  @override
  List<Object?> get props => [
        homeTeam,
        awayTeam,
        players,
        homeFormation,
        awayFormation,
        manOfTheMatchId,
      ];
}
