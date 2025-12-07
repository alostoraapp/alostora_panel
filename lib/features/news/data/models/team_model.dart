import 'package:alostora/features/news/domain/entities/team_entity.dart';

class TeamModel extends TeamEntity {
  const TeamModel({
    required super.id,
    required super.name,
    required super.shortName,
    super.displayName,
    super.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      displayName: json['display_name'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'display_name': displayName,
      'logo': logo,
    };
  }
}
