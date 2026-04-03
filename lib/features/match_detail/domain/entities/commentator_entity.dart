import 'package:equatable/equatable.dart';
import '../../../../core/utils/json_helper.dart';
import 'country_entity.dart';

class CommentatorEntity extends Equatable {
  final String id;
  final dynamic _name;
  final String? logo;
  final CountryEntity? country;

  const CommentatorEntity({
    required this.id,
    required dynamic name,
    this.logo,
    this.country,
  }) : _name = name;

  String get name => JsonHelper.localized(_name);

  @override
  List<Object?> get props => [id, _name, logo, country];
}
