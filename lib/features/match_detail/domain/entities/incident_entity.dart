import 'package:equatable/equatable.dart';
import 'incident_enums.dart';
import 'player_info_entity.dart';

class IncidentEntity extends Equatable {
  final String id;
  final String matchId;
  final int order;
  final StatTypeChoices type;
  final int time;
  final int? addedTime;
  final IncidentPositionChoices position; // Home, Away, Neutral
  final PlayerInfoEntity? player;
  final PlayerInfoEntity? assist1;
  final PlayerInfoEntity? assist2;
  final PlayerInfoEntity? inPlayer; // For substitutions
  final PlayerInfoEntity? outPlayer; // For substitutions
  final IncidentReasonTypeChoices? reason;
  final String? mediaUrl;
  final bool isHome; // Helper to easily check if it belongs to home team

  const IncidentEntity({
    required this.id,
    required this.matchId,
    required this.order,
    required this.type,
    required this.time,
    this.addedTime,
    required this.position,
    this.player,
    this.assist1,
    this.assist2,
    this.inPlayer,
    this.outPlayer,
    this.reason,
    this.mediaUrl,
    required this.isHome,
  });

  @override
  List<Object?> get props => [
        id,
        matchId,
        order,
        type,
        time,
        addedTime,
        position,
        player,
        assist1,
        assist2,
        inPlayer,
        outPlayer,
        reason,
        mediaUrl,
        isHome,
      ];
}
