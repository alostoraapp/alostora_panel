import '../models/player_lineup_model.dart';
import '../models/team_lineup_info_model.dart';
import '../../domain/entities/lineup_entity.dart';

class LineupModel extends LineupEntity {
  const LineupModel({
    required super.homeTeam,
    required super.awayTeam,
    required super.players,
    super.homeFormation,
    super.awayFormation,
    super.manOfTheMatchId,
  });

  factory LineupModel.fromJson(Map<String, dynamic> json) {
    return LineupModel(
      homeTeam: TeamLineupInfoModel.fromJson(json['home_team']),
      awayTeam: TeamLineupInfoModel.fromJson(json['away_team']),
      players: (json['players'] as List)
          .map((playerJson) => PlayerLineupModel.fromJson(playerJson))
          .toList(),
      homeFormation: json['home_formation'],
      awayFormation: json['away_formation'],
      manOfTheMatchId: json['man_of_the_match']?['id'],
    );
  }
}
