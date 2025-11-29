import '../../domain/entities/incident_entity.dart';
import '../../domain/entities/incident_enums.dart';
import 'player_info_model.dart';

class IncidentModel extends IncidentEntity {
  const IncidentModel({
    required super.id,
    required super.matchId,
    required super.order,
    required super.type,
    required super.time,
    super.addedTime,
    required super.position,
    super.player,
    super.assist1,
    super.assist2,
    super.inPlayer,
    super.outPlayer,
    super.reason,
    super.mediaUrl,
    super.mediaCover,
    super.videoTime,
    required super.isHome,
    super.mediaStatus,
    super.mediaPriority,
  });

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    // Helper to parse enums from integer or string values
    T _parseEnum<T>(List<T> values, dynamic value) {
      if (value == null) {
        // Return the first value (usually unknown or default) if null
        return values.first;
      }
      for (final e in values) {
        if ((e as dynamic).value == value) {
          return e;
        }
      }
      return values.first;
    }

    return IncidentModel(
      id: json['id'],
      matchId: json['match'],
      order: json['order'] ?? 0,
      type: _parseEnum(StatTypeChoices.values, json['type']),
      time: json['time'],
      addedTime: null, // API doesn't seem to have added_time in the example
      position: _parseEnum(IncidentPositionChoices.values, json['position']),
      player: json['player'] != null
          ? PlayerInfoModel.fromJson(json['player'])
          : null,
      assist1: json['assist1'] != null
          ? PlayerInfoModel.fromJson(json['assist1'])
          : null,
      assist2: json['assist2'] != null
          ? PlayerInfoModel.fromJson(json['assist2'])
          : null,
      inPlayer: json['in_player'] != null
          ? PlayerInfoModel.fromJson(json['in_player'])
          : null,
      outPlayer: json['out_player'] != null
          ? PlayerInfoModel.fromJson(json['out_player'])
          : null,
      reason: json['reason_type'] != null
          ? _parseEnum(IncidentReasonTypeChoices.values, json['reason_type'])
          : null,
      mediaUrl: json['media_url'],
      mediaCover: json['media_cover'],
      videoTime: json['video_time'],
      isHome: json['position'] == 1, // 1 is Home in IncidentPositionChoices
      mediaStatus: json['media_status'] != null
          ? _parseEnum(
              MatchIncidentMediaStatusChoices.values, json['media_status'])
          : null,
      mediaPriority: json['media_priority'] != null
          ? _parseEnum(
              MatchIncidentMediaPriorityChoices.values, json['media_priority'])
          : null,
    );
  }
}
