import 'package:equatable/equatable.dart';
import '../../../../core/utils/json_helper.dart';
import 'country_entity.dart';

class TvChannelEntity extends Equatable {
  final String id;
  final dynamic _name;
  final String logo;
  final CountryEntity country;

  const TvChannelEntity({
    required this.id,
    required dynamic name,
    required this.logo,
    required this.country,
  }) : _name = name;

  String get name => JsonHelper.localized(_name);

  @override
  List<Object?> get props => [id, _name, logo, country];
}
