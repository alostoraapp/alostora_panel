import 'package:equatable/equatable.dart';

import '../../domain/entities/match_entity.dart';
import '../../domain/entities/match_status_enum.dart';
import 'team_model.dart';

class MatchModel extends Equatable {
  final String id;
  final String exId;
  final int matchTime;
  final int statusCode;
  final int? firstHalfStartTime;
  final int? secondHalfStartTime;
  final int homeScoreFinal;
  final int awayScoreFinal;
  final TeamModel homeTeam;
  final TeamModel awayTeam;

  const MatchModel({
    required this.id,
    required this.exId,
    required this.matchTime,
    required this.statusCode,
    this.firstHalfStartTime,
    this.secondHalfStartTime,
    required this.homeScoreFinal,
    required this.awayScoreFinal,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      exId: json['ex_id'],
      matchTime: json['match_time'],
      statusCode: json['status_code'],
      firstHalfStartTime: json['first_half_start_time'],
      secondHalfStartTime: json['second_half_start_time'],
      homeScoreFinal: json['home_score_final'],
      awayScoreFinal: json['away_score_final'],
      homeTeam: TeamModel.fromJson(json['home_team']),
      awayTeam: TeamModel.fromJson(json['away_team']),
    );
  }

  MatchEntity toEntity() {
    return MatchEntity(
      id: id,
      exId: exId,
      matchTime: DateTime.fromMillisecondsSinceEpoch(matchTime * 1000),
      status: MatchStatus.fromStatusCode(statusCode),
      firstHalfStartTime: firstHalfStartTime != null ? DateTime.fromMillisecondsSinceEpoch(firstHalfStartTime! * 1000) : null,
      secondHalfStartTime: secondHalfStartTime != null ? DateTime.fromMillisecondsSinceEpoch(secondHalfStartTime! * 1000) : null,
      homeScoreFinal: homeScoreFinal,
      awayScoreFinal: awayScoreFinal,
      homeTeam: homeTeam.toEntity(),
      awayTeam: awayTeam.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        exId,
        matchTime,
        statusCode,
        firstHalfStartTime,
        secondHalfStartTime,
        homeScoreFinal,
        awayScoreFinal,
        homeTeam,
        awayTeam,
      ];
}
