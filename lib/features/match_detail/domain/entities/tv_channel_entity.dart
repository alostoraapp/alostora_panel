import 'package:equatable/equatable.dart';
import 'country_entity.dart';

class TvChannelEntity extends Equatable {
  final String id;
  final String name;
  final String logo;
  final CountryEntity country;

  const TvChannelEntity({
    required this.id,
    required this.name,
    required this.logo,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, logo, country];
}
