import '../../domain/entities/commentator_entity.dart';
import 'country_model.dart';

class CommentatorModel extends CommentatorEntity {
  const CommentatorModel({
    required super.id,
    required super.name,
    super.logo,
    super.country,
  });

  factory CommentatorModel.fromJson(Map<String, dynamic> json) {
    return CommentatorModel(
      id: json['id']?.toString() ?? '',
      name: json['name'],
      logo: json['logo']?.toString(),
      country: json['country'] != null
          ? CountryModel.fromJson(json['country'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'country': (country as CountryModel?)?.toJson(),
    };
  }
}
