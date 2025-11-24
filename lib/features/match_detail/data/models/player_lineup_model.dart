import '../../domain/entities/player_lineup_entity.dart';
import 'player_info_model.dart';

class PlayerLineupModel extends PlayerLineupEntity {
  const PlayerLineupModel({
    required super.id,
    super.player,
    required super.teamSide,
    required super.isStarter,
    required super.isCaptain,
    required super.shirtNumber,
    super.position,
    super.rating,
  });

  factory PlayerLineupModel.fromJson(Map<String, dynamic> json) {
    return PlayerLineupModel(
      id: json['id'],
      player: json['player'] != null
          ? PlayerInfoModel.fromJson(json['player'])
          : null,
      teamSide: json['team_side'],
      isStarter: json['is_starter'],
      isCaptain: json['is_captain'],
      shirtNumber: json['shirt_number'],
      position: json['position'],
      rating: double.tryParse(json['rating']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}
