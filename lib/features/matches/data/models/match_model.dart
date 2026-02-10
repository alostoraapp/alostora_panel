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
  final bool hasManOfTheMatch;
  final bool hasIncidentsMedia;
  final bool hasHighlights;
  final bool hasLiveBroadcast;
  final bool hasCommentators;

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
    required this.hasManOfTheMatch,
    required this.hasIncidentsMedia,
    required this.hasHighlights,
    required this.hasLiveBroadcast,
    required this.hasCommentators,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id']?.toString() ?? '',
      exId: json['ex_id']?.toString() ?? '',
      matchTime: json['match_time'] is int ? json['match_time'] : 0,
      statusCode: json['status_code'] is int ? json['status_code'] : 0,
      firstHalfStartTime: json['first_half_start_time'] is int
          ? json['first_half_start_time']
          : null,
      secondHalfStartTime: json['second_half_start_time'] is int
          ? json['second_half_start_time']
          : null,
      homeScoreFinal:
          json['home_score_final'] is int ? json['home_score_final'] : 0,
      awayScoreFinal:
          json['away_score_final'] is int ? json['away_score_final'] : 0,
      homeTeam: TeamModel.fromJson(json['home_team'] ?? {}),
      awayTeam: TeamModel.fromJson(json['away_team'] ?? {}),
      hasManOfTheMatch: json['has_man_of_the_match'] ?? false,
      hasIncidentsMedia: json['has_incidents_media'] ?? false,
      hasHighlights: json['has_highlights'] ?? false,
      hasLiveBroadcast: json['has_live_broadcast'] ?? false,
      hasCommentators: json['has_commentators'] ?? false,
    );
  }

  MatchEntity toEntity() {
    return MatchEntity(
      id: id,
      exId: exId,
      matchTime: DateTime.fromMillisecondsSinceEpoch(matchTime * 1000),
      status: MatchStatus.fromStatusCode(statusCode),
      firstHalfStartTime: firstHalfStartTime != null
          ? DateTime.fromMillisecondsSinceEpoch(firstHalfStartTime! * 1000)
          : null,
      secondHalfStartTime: secondHalfStartTime != null
          ? DateTime.fromMillisecondsSinceEpoch(secondHalfStartTime! * 1000)
          : null,
      homeScoreFinal: homeScoreFinal,
      awayScoreFinal: awayScoreFinal,
      homeTeam: homeTeam.toEntity(),
      awayTeam: awayTeam.toEntity(),
      hasManOfTheMatch: hasManOfTheMatch,
      hasIncidentsMedia: hasIncidentsMedia,
      hasHighlights: hasHighlights,
      hasLiveBroadcast: hasLiveBroadcast,
      hasCommentators: hasCommentators,
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
        hasManOfTheMatch,
        hasIncidentsMedia,
        hasHighlights,
        hasLiveBroadcast,
        hasCommentators,
      ];
}
