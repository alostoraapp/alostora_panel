import '../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.id,
    required super.name,
    required super.shortName,
    required super.displayName,
    required super.logo,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      displayName: json['display_name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'display_name': displayName,
      'logo': logo,
    };
  }
}
