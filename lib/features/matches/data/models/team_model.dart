import 'package:equatable/equatable.dart';

import '../../domain/entities/team_entity.dart';

class TeamModel extends Equatable {
  final String id;
  final String exId;
  final String name;
  final String shortName;
  final String logo;

  const TeamModel({
    required this.id,
    required this.exId,
    required this.name,
    required this.shortName,
    required this.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      exId: json['ex_id'],
      name: json['name'],
      shortName: json['short_name'],
      logo: json['logo'],
    );
  }

  TeamEntity toEntity() {
    return TeamEntity(
      id: id,
      exId: exId,
      name: name,
      shortName: shortName,
      logo: logo,
    );
  }

  @override
  List<Object?> get props => [id, exId, name, shortName, logo];
}
