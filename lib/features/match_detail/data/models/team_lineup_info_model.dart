import '../../domain/entities/team_lineup_info_entity.dart';

class TeamLineupInfoModel extends TeamLineupInfoEntity {
  const TeamLineupInfoModel({
    required super.id,
    required super.name,
    super.shortName,
    super.displayName,
    super.logo,
  });

  factory TeamLineupInfoModel.fromJson(Map<String, dynamic> json) {
    return TeamLineupInfoModel(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      displayName: json['display_name'],
      logo: json['logo'],
    );
  }
}
