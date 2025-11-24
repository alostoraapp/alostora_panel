import 'package:equatable/equatable.dart';

import 'player_info_entity.dart';

class PlayerLineupEntity extends Equatable {
  final String id;
  final PlayerInfoEntity? player;
  final int teamSide;
  final bool isStarter;
  final bool isCaptain;
  final int shirtNumber;
  final String? position;
  final double? rating;

  const PlayerLineupEntity({
    required this.id,
    this.player,
    required this.teamSide,
    required this.isStarter,
    required this.isCaptain,
    required this.shirtNumber,
    this.position,
    this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        player,
        teamSide,
        isStarter,
        isCaptain,
        shirtNumber,
        position,
        rating,
      ];
}
