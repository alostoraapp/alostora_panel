import 'package:equatable/equatable.dart';

import 'match_entity.dart';

class CompetitionEntity extends Equatable {
  final String id;
  final String exId;
  final String name;
  final String logo;
  final String? countryName;
  final List<MatchEntity> matches;

  const CompetitionEntity({
    required this.id,
    required this.exId,
    required this.name,
    required this.logo,
    this.countryName,
    required this.matches,
  });

  @override
  List<Object?> get props => [id, exId, name, logo, countryName, matches];
}
