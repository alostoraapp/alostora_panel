import '../../domain/entities/player_info_entity.dart';

class PlayerInfoModel extends PlayerInfoEntity {
  const PlayerInfoModel({
    required super.id,
    required super.name,
    super.shortName,
    super.displayName,
    super.logo,
  });

  factory PlayerInfoModel.fromJson(Map<String, dynamic> json) {
    return PlayerInfoModel(
      id: json['id']?.toString() ?? '',
      name: json['name'],
      shortName: json['short_name'],
      displayName: json['display_name'],
      logo: json['logo']?.toString(),
    );
  }
}
