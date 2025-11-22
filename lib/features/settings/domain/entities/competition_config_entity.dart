import 'package:equatable/equatable.dart';

class CompetitionConfigEntity extends Equatable {
  final String id;
  final CompetitionDetailsEntity competitionDetails;
  final bool isActiveByDefault;
  final int order;

  const CompetitionConfigEntity({
    required this.id,
    required this.competitionDetails,
    required this.isActiveByDefault,
    required this.order,
  });

  @override
  List<Object?> get props => [id, competitionDetails, isActiveByDefault, order];
}

class CompetitionDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final String logo;
  final CompetitionCountryEntity? country;

  const CompetitionDetailsEntity({
    required this.id,
    required this.name,
    required this.shortName,
    required this.logo,
    this.country,
  });

  @override
  List<Object?> get props => [id, name, shortName, logo, country];
}

class CompetitionCountryEntity extends Equatable {
  final String id;
  final String name;
  final String logo;

  const CompetitionCountryEntity({
    required this.id,
    required this.name,
    required this.logo,
  });

  @override
  List<Object?> get props => [id, name, logo];
}
