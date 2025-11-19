import '../../domain/entities/competition_config_entity.dart';

class CompetitionConfigModel extends CompetitionConfigEntity {
  const CompetitionConfigModel({
    required super.id,
    required super.competitionDetails,
    required super.isActiveByDefault,
    required super.order,
  });

  factory CompetitionConfigModel.fromJson(Map<String, dynamic> json) {
    return CompetitionConfigModel(
      id: json['id'],
      competitionDetails: CompetitionDetailsModel.fromJson(json['competition_details']),
      isActiveByDefault: json['is_active_by_default'],
      order: json['order'],
    );
  }
}

class CompetitionDetailsModel extends CompetitionDetailsEntity {
  const CompetitionDetailsModel({
    required super.id,
    required super.name,
    required super.logo,
    super.country,
  });

  factory CompetitionDetailsModel.fromJson(Map<String, dynamic> json) {
    return CompetitionDetailsModel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      country: json['country'] != null ? CompetitionCountryModel.fromJson(json['country']) : null,
    );
  }
}

class CompetitionCountryModel extends CompetitionCountryEntity {
  const CompetitionCountryModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory CompetitionCountryModel.fromJson(Map<String, dynamic> json) {
    return CompetitionCountryModel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
