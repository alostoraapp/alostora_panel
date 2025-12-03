import 'package:equatable/equatable.dart';

import 'match_status_enum.dart';
import 'team_entity.dart';

class MatchEntity extends Equatable {
  final String id;
  final String exId;
  final DateTime matchTime;
  final MatchStatus status;
  final DateTime? firstHalfStartTime;
  final DateTime? secondHalfStartTime;
  final int homeScoreFinal;
  final int awayScoreFinal;
  final TeamEntity homeTeam;
  final TeamEntity awayTeam;
  final bool hasManOfTheMatch;
  final bool hasIncidentsMedia;
  final bool hasHighlights;
  final bool hasLiveBroadcast;
  final bool hasTvChannels;
  final bool hasCommentators;

  const MatchEntity({
    required this.id,
    required this.exId,
    required this.matchTime,
    required this.status,
    this.firstHalfStartTime,
    this.secondHalfStartTime,
    required this.homeScoreFinal,
    required this.awayScoreFinal,
    required this.homeTeam,
    required this.awayTeam,
    this.hasManOfTheMatch = false,
    this.hasIncidentsMedia = false,
    this.hasHighlights = false,
    this.hasLiveBroadcast = false,
    this.hasTvChannels = false,
    this.hasCommentators = false,
  });

  @override
  List<Object?> get props => [
        id,
        exId,
        matchTime,
        status,
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
        hasTvChannels,
        hasCommentators,
      ];
}
