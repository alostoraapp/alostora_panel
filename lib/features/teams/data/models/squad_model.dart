import '../../domain/entities/squad_entity.dart';
import 'team_detail_model.dart';

class SquadMemberModel extends SquadMemberEntity {
  const SquadMemberModel({
    required super.id,
    required super.player,
    required super.position,
    required super.shirtNumber,
  });

  factory SquadMemberModel.fromJson(Map<String, dynamic> json) {
    return SquadMemberModel(
      id: json['id'],
      player: PlayerModel.fromJson(json['player']),
      position: json['position'],
      shirtNumber: json['shirt_number'],
    );
  }
}

class PlayerModel extends PlayerEntity {
  const PlayerModel({
    required super.id,
    super.name,
    super.shortName,
    super.displayName,
    super.logo,
    super.country,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: TeamDetailModel.parseLocalized(json['name']),
      shortName: TeamDetailModel.parseLocalized(json['short_name']),
      displayName: TeamDetailModel.parseLocalized(json['display_name']),
      logo: json['logo'],
      country: json['country'] != null
          ? TeamCountryModel.fromJson(json['country'])
          : null,
    );
  }
}
