import '../../domain/entities/tv_channel_entity.dart';
import 'country_model.dart';

class TvChannelModel extends TvChannelEntity {
  const TvChannelModel({
    required super.id,
    required super.name,
    required super.logo,
    required super.country,
  });

  factory TvChannelModel.fromJson(Map<String, dynamic> json) {
    return TvChannelModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      country: CountryModel.fromJson(json['country'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'country': (country as CountryModel).toJson(),
    };
  }
}
