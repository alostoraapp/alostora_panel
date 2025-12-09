import 'package:equatable/equatable.dart';

class CompetitionDetailEntity extends Equatable {
  final String id;
  final String? logo;
  final int? type;
  final int? gender;
  final String? primaryColor;
  final String? secondaryColor;
  final int? roundCount;
  final int? curRound;
  final CompetitionCategoryEntity? category;
  final CompetitionCountryEntity? country;
  final CompetitionSeasonEntity? curSeason;
  final CompetitionStageEntity? curStage;
  final Map<String, String>? name;
  final Map<String, String>? shortName;

  const CompetitionDetailEntity({
    required this.id,
    this.logo,
    this.type,
    this.gender,
    this.primaryColor,
    this.secondaryColor,
    this.roundCount,
    this.curRound,
    this.category,
    this.country,
    this.curSeason,
    this.curStage,
    this.name,
    this.shortName,
  });

  @override
  List<Object?> get props => [
        id,
        logo,
        type,
        gender,
        primaryColor,
        secondaryColor,
        roundCount,
        curRound,
        category,
        country,
        curSeason,
        curStage,
        name,
        shortName,
      ];
}

class CompetitionCategoryEntity extends Equatable {
  final String id;
  final Map<String, String>? name;

  const CompetitionCategoryEntity({required this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}

class CompetitionCountryEntity extends Equatable {
  final String id;
  final String? logo;
  final Map<String, String>? name;

  const CompetitionCountryEntity({required this.id, this.logo, this.name});

  @override
  List<Object?> get props => [id, logo, name];
}

class CompetitionSeasonEntity extends Equatable {
  final String id;
  final String? year;
  final Map<String, String>? name;

  const CompetitionSeasonEntity({required this.id, this.year, this.name});

  @override
  List<Object?> get props => [id, year, name];
}

class CompetitionStageEntity extends Equatable {
  final String id;
  final int? order;
  final Map<String, String>? name;

  const CompetitionStageEntity({required this.id, this.order, this.name});

  @override
  List<Object?> get props => [id, order, name];
}
