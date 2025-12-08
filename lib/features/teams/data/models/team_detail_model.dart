import '../../domain/entities/team_detail_entity.dart';

class TeamDetailModel extends TeamDetailEntity {
  const TeamDetailModel({
    required super.id,
    super.logo,
    required super.national,
    super.foundationTime,
    super.website,
    super.marketValue,
    super.marketValueCurrency,
    super.totalPlayers,
    super.foreignPlayers,
    super.nationalPlayers,
    required super.virtual,
    super.country,
    super.venue,
    super.coach,
    super.competition,
    super.name,
    super.shortName,
    super.displayName,
  });

  factory TeamDetailModel.fromJson(Map<String, dynamic> json) {
    return TeamDetailModel(
      id: json['id'],
      logo: json['logo'],
      national: json['national'] ?? false,
      foundationTime: json['foundation_time'],
      website: json['website'],
      marketValue: (json['market_value'] as num?)?.toDouble(),
      marketValueCurrency: json['market_value_currency'],
      totalPlayers: json['total_players'],
      foreignPlayers: json['foreign_players'],
      nationalPlayers: json['national_players'],
      virtual: json['virtual'] ?? false,
      country: json['country'] != null
          ? TeamCountryModel.fromJson(json['country'])
          : null,
      venue:
          json['venue'] != null ? TeamVenueModel.fromJson(json['venue']) : null,
      coach: json['coach'] is Map<String, dynamic>
          ? TeamCoachModel.fromJson(json['coach'])
          : null, // Handle case where coach might be null or string (though API says object, sometimes it's null)
      competition: json['competition'] != null
          ? TeamCompetitionModel.fromJson(json['competition'])
          : null,
      name: _parseLocalized(json['name']),
      shortName: _parseLocalized(json['short_name']),
      displayName: _parseLocalized(json['display_name']),
    );
  }

  static Map<String, String>? _parseLocalized(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json.map((key, value) => MapEntry(key, value.toString()));
    }
    return null;
  }
}

class TeamCountryModel extends TeamCountryEntity {
  const TeamCountryModel({
    required super.id,
    super.logo,
    super.name,
    super.shortName,
    super.displayName,
  });

  factory TeamCountryModel.fromJson(Map<String, dynamic> json) {
    return TeamCountryModel(
      id: json['id'],
      logo: json['logo'],
      name: TeamDetailModel._parseLocalized(json['name']),
      shortName: TeamDetailModel._parseLocalized(json['short_name']),
      displayName: TeamDetailModel._parseLocalized(json['display_name']),
    );
  }
}

class TeamVenueModel extends TeamVenueEntity {
  const TeamVenueModel({
    required super.id,
    super.city,
    super.capacity,
    super.country,
    super.name,
    super.shortName,
  });

  factory TeamVenueModel.fromJson(Map<String, dynamic> json) {
    return TeamVenueModel(
      id: json['id'],
      city: TeamDetailModel._parseLocalized(json['city']),
      capacity: json['capacity'],
      country: json['country'] != null
          ? TeamCountryModel.fromJson(json['country'])
          : null,
      name: TeamDetailModel._parseLocalized(json['name']),
      shortName: TeamDetailModel._parseLocalized(json['short_name']),
    );
  }
}

class TeamCoachModel extends TeamCoachEntity {
  const TeamCoachModel({
    required super.id,
    super.logo,
    super.nationality,
    super.country,
    super.type,
    super.name,
    super.shortName,
  });

  factory TeamCoachModel.fromJson(Map<String, dynamic> json) {
    return TeamCoachModel(
      id: json['id'],
      logo: json['logo'],
      nationality: json['nationality'],
      country: json['country'] != null
          ? TeamCountryModel.fromJson(json['country'])
          : null,
      type: json['type'],
      name: TeamDetailModel._parseLocalized(json['name']),
      shortName: TeamDetailModel._parseLocalized(json['short_name']),
    );
  }
}

class TeamCompetitionModel extends TeamCompetitionEntity {
  const TeamCompetitionModel({
    required super.id,
    super.logo,
    super.type,
    super.gender,
    super.country,
    super.name,
    super.shortName,
  });

  factory TeamCompetitionModel.fromJson(Map<String, dynamic> json) {
    return TeamCompetitionModel(
      id: json['id'],
      logo: json['logo'],
      type: json['type'],
      gender: json['gender'],
      country: json['country'] != null
          ? TeamCountryModel.fromJson(json['country'])
          : null,
      name: TeamDetailModel._parseLocalized(json['name']),
      shortName: TeamDetailModel._parseLocalized(json['short_name']),
    );
  }
}
