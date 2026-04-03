import 'package:equatable/equatable.dart';
import '../../../../core/utils/json_helper.dart';

class CountryEntity extends Equatable {
  final String id;
  final dynamic _name;
  final dynamic _shortName;
  final dynamic _displayName;
  final String logo;

  const CountryEntity({
    required this.id,
    required dynamic name,
    required dynamic shortName,
    required dynamic displayName,
    required this.logo,
  })  : _name = name,
        _shortName = shortName,
        _displayName = displayName;

  String get name => JsonHelper.localized(_name);
  String get shortName => JsonHelper.localized(_shortName);
  String get displayName => JsonHelper.localized(_displayName);

  @override
  List<Object?> get props => [id, _name, _shortName, _displayName, logo];
}
