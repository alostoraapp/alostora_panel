import 'package:equatable/equatable.dart';

import '../../domain/entities/competition_entity.dart';
import 'match_model.dart';

class CompetitionModel extends Equatable {
  final String id;
  final String exId;
  final String name;
  final String logo;
  final String? countryName;
  final List<MatchModel> matches;

  const CompetitionModel({
    required this.id,
    required this.exId,
    required this.name,
    required this.logo,
    this.countryName,
    required this.matches,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    final matchesList = json['matches'] as List?;
    return CompetitionModel(
      id: json['id'],
      exId: json['ex_id'],
      name: json['name'],
      logo: json['logo'],
      countryName: json['country_name'],
      matches: matchesList
              ?.where((i) =>
                  i != null && i['home_team'] != null && i['away_team'] != null)
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
      logo: logo,
      countryName: countryName,
      matches: matches.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, exId, name, logo, countryName, matches];
}
