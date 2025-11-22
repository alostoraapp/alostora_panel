import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  final String id;
  final String exId;
  final String name;
  final String shortName;
  final String logo;

  const TeamEntity({
    required this.id,
    required this.exId,
    required this.name,
    required this.shortName,
    required this.logo,
  });

  @override
  List<Object?> get props => [id, exId, name, shortName, logo];
}
