import '../../domain/entities/competition_detail_entity.dart';

class CompetitionDetailModel extends CompetitionDetailEntity {
  const CompetitionDetailModel({
    required super.id,
    super.logo,
    super.type,
    super.gender,
    super.primaryColor,
    super.secondaryColor,
    super.roundCount,
    super.curRound,
    super.category,
    super.country,
    super.curSeason,
    super.curStage,
    super.name,
    super.shortName,
  });

  factory CompetitionDetailModel.fromJson(Map<String, dynamic> json) {
    return CompetitionDetailModel(
      id: json['id'],
      logo: json['logo'],
      type: json['type'],
      gender: json['gender'],
      primaryColor: json['primary_color'],
      secondaryColor: json['secondary_color'],
      roundCount: json['round_count'],
      curRound: json['cur_round'],
      category: json['category'] != null
          ? CompetitionCategoryModel.fromJson(json['category'])
          : null,
      country: json['country'] != null
          ? CompetitionCountryModel.fromJson(json['country'])
          : null,
      curSeason: json['cur_season'] != null
          ? CompetitionSeasonModel.fromJson(json['cur_season'])
          : null,
      curStage: json['cur_stage'] != null
          ? CompetitionStageModel.fromJson(json['cur_stage'])
          : null,
      name: _parseLocalized(json['name']),
      shortName: _parseLocalized(json['short_name']),
    );
  }

  static Map<String, String>? _parseLocalized(dynamic json) {
    if (json is Map) {
      return json
          .map((key, value) => MapEntry(key.toString(), value.toString()));
    }
    return null;
  }
}

class CompetitionCategoryModel extends CompetitionCategoryEntity {
  const CompetitionCategoryModel({required super.id, super.name});

  factory CompetitionCategoryModel.fromJson(Map<String, dynamic> json) {
    return CompetitionCategoryModel(
      id: json['id'],
      name: CompetitionDetailModel._parseLocalized(json['name']),
    );
  }
}

class CompetitionCountryModel extends CompetitionCountryEntity {
  const CompetitionCountryModel({required super.id, super.logo, super.name});

  factory CompetitionCountryModel.fromJson(Map<String, dynamic> json) {
    return CompetitionCountryModel(
      id: json['id'],
      logo: json['logo'],
      name: CompetitionDetailModel._parseLocalized(json['name']),
    );
  }
}

class CompetitionSeasonModel extends CompetitionSeasonEntity {
  const CompetitionSeasonModel({required super.id, super.year, super.name});

  factory CompetitionSeasonModel.fromJson(Map<String, dynamic> json) {
    return CompetitionSeasonModel(
      id: json['id'],
      year: json['year'],
      name: CompetitionDetailModel._parseLocalized(json['name']),
    );
  }
}

class CompetitionStageModel extends CompetitionStageEntity {
  const CompetitionStageModel({required super.id, super.order, super.name});

  factory CompetitionStageModel.fromJson(Map<String, dynamic> json) {
    return CompetitionStageModel(
      id: json['id'],
      order: json['order'],
      name: CompetitionDetailModel._parseLocalized(json['name']),
    );
  }
}
