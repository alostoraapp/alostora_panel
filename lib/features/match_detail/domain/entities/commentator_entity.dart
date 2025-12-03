import 'package:equatable/equatable.dart';
import 'country_entity.dart';

class CommentatorEntity extends Equatable {
  final String id;
  final String name;
  final String? logo;
  final CountryEntity? country;

  const CommentatorEntity({
    required this.id,
    required this.name,
    this.logo,
    this.country,
  });

  @override
  List<Object?> get props => [id, name, logo, country];
}
