import 'package:equatable/equatable.dart';

import '../../domain/entities/competition_entity.dart';
import 'match_model.dart';

class CompetitionModel extends Equatable {
  final String id;
  final String exId;
  final String name;
  final String shortName;
  final String logo;
  final String? countryName;
  final List<MatchModel> matches;

  const CompetitionModel({
    required this.id,
    required this.exId,
    required this.name,
    required this.shortName,
    required this.logo,
    this.countryName,
    required this.matches,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    final matchesList = json['matches'] as List?;
    return CompetitionModel(
      id: json['id']?.toString() ?? '',
      exId: json['ex_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      shortName: json['short_name']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      countryName: json['country_name']?.toString(),
      matches: matchesList
              ?.where((i) => i != null)
              .map((i) => MatchModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  CompetitionEntity toEntity() {
    return CompetitionEntity(
      id: id,
      exId: exId,
      name: name,
      shortName: shortName,
      logo: logo,
      countryName: countryName,
      matches: matches.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props =>
      [id, exId, name, shortName, logo, countryName, matches];
}
