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
      id: json['id']?.toString() ?? '',
      exId: json['ex_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      shortName: json['short_name']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
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
