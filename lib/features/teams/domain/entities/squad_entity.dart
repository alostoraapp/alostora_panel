import 'package:equatable/equatable.dart';

import 'team_detail_entity.dart';

class SquadMemberEntity extends Equatable {
  final String id;
  final PlayerEntity player;
  final String position;
  final int shirtNumber;

  const SquadMemberEntity({
    required this.id,
    required this.player,
    required this.position,
    required this.shirtNumber,
  });

  @override
  List<Object?> get props => [id, player, position, shirtNumber];
}

class PlayerEntity extends Equatable {
  final String id;
  final Map<String, String>? name;
  final Map<String, String>? shortName;
  final Map<String, String>? displayName;
  final String? logo;
  final TeamCountryEntity? country;

  const PlayerEntity({
    required this.id,
    this.name,
    this.shortName,
    this.displayName,
    this.logo,
    this.country,
  });

  @override
  List<Object?> get props => [id, name, shortName, displayName, logo, country];
}
