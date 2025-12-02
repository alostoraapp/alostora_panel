import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final String displayName;
  final String logo;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.shortName,
    required this.displayName,
    required this.logo,
  });

  @override
  List<Object?> get props => [id, name, shortName, displayName, logo];
}
