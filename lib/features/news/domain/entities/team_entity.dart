import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final String? displayName;
  final String? logo;

  const TeamEntity({
    required this.id,
    required this.name,
    required this.shortName,
    this.displayName,
    this.logo,
  });

  @override
  List<Object?> get props => [id, name, shortName, displayName, logo];
}
