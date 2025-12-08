import 'package:equatable/equatable.dart';

class TeamDetailEntity extends Equatable {
  final String id;
  final String? logo;
  final bool national;
  final int? foundationTime;
  final String? website;
  final double? marketValue;
  final String? marketValueCurrency;
  final int? totalPlayers;
  final int? foreignPlayers;
  final int? nationalPlayers;
  final bool virtual;
  final TeamCountryEntity? country;
  final TeamVenueEntity? venue;
  final TeamCoachEntity? coach;
  final TeamCompetitionEntity? competition;
  final Map<String, String>? name;
  final Map<String, String>? shortName;
  final Map<String, String>? displayName;

  const TeamDetailEntity({
    required this.id,
    this.logo,
    required this.national,
    this.foundationTime,
    this.website,
    this.marketValue,
    this.marketValueCurrency,
    this.totalPlayers,
    this.foreignPlayers,
    this.nationalPlayers,
    required this.virtual,
    this.country,
    this.venue,
    this.coach,
    this.competition,
    this.name,
    this.shortName,
    this.displayName,
  });

  @override
  List<Object?> get props => [
        id,
        logo,
        national,
        foundationTime,
        website,
        marketValue,
        marketValueCurrency,
        totalPlayers,
        foreignPlayers,
        nationalPlayers,
        virtual,
        country,
        venue,
        coach,
        competition,
        name,
        shortName,
        displayName,
      ];
}

class TeamCountryEntity extends Equatable {
  final String id;
  final String? logo;
  final Map<String, String>? name;
  final Map<String, String>? shortName;
  final Map<String, String>? displayName;

  const TeamCountryEntity({
    required this.id,
    this.logo,
    this.name,
    this.shortName,
    this.displayName,
  });

  @override
  List<Object?> get props => [id, logo, name, shortName, displayName];
}

class TeamVenueEntity extends Equatable {
  final String id;
  final Map<String, String>? city;
  final int? capacity;
  final TeamCountryEntity? country;
  final Map<String, String>? name;
  final Map<String, String>? shortName;

  const TeamVenueEntity({
    required this.id,
    this.city,
    this.capacity,
    this.country,
    this.name,
    this.shortName,
  });

  @override
  List<Object?> get props => [id, city, capacity, country, name, shortName];
}

class TeamCoachEntity extends Equatable {
  final String id;
  final String? logo;
  final String? nationality;
  final TeamCountryEntity? country;
  final int? type;
  final Map<String, String>? name;
  final Map<String, String>? shortName;

  const TeamCoachEntity({
    required this.id,
    this.logo,
    this.nationality,
    this.country,
    this.type,
    this.name,
    this.shortName,
  });

  @override
  List<Object?> get props =>
      [id, logo, nationality, country, type, name, shortName];
}

class TeamCompetitionEntity extends Equatable {
  final String id;
  final String? logo;
  final int? type;
  final int? gender;
  final TeamCountryEntity? country;
  final Map<String, String>? name;
  final Map<String, String>? shortName;

  const TeamCompetitionEntity({
    required this.id,
    this.logo,
    this.type,
    this.gender,
    this.country,
    this.name,
    this.shortName,
  });

  @override
  List<Object?> get props => [id, logo, type, gender, country, name, shortName];
}
