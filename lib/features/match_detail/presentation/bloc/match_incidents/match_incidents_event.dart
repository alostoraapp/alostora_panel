part of 'match_incidents_bloc.dart';

abstract class MatchIncidentsEvent extends Equatable {
  const MatchIncidentsEvent();

  @override
  List<Object> get props => [];
}

class GetMatchIncidentsEvent extends MatchIncidentsEvent {
  final String matchId;

  const GetMatchIncidentsEvent(this.matchId);

  @override
  List<Object> get props => [matchId];
}

class UpdateIncidentMediaEvent extends MatchIncidentsEvent {
  final String matchId;
  final String incidentId;
  final String? mediaUrl;
  final XFile? mediaCover;
  final int? videoTime;

  const UpdateIncidentMediaEvent({
    required this.matchId,
    required this.incidentId,
    this.mediaUrl,
    this.mediaCover,
    this.videoTime,
  });

  @override
  List<Object> get props =>
      [matchId, incidentId, mediaUrl ?? '', mediaCover ?? '', videoTime ?? 0];
}

class DeleteIncidentMediaEvent extends MatchIncidentsEvent {
  final String matchId;
  final String incidentId;

  const DeleteIncidentMediaEvent({
    required this.matchId,
    required this.incidentId,
  });

  @override
  List<Object> get props => [matchId, incidentId];
}

class ApproveIncidentMediaEvent extends MatchIncidentsEvent {
  final String matchId;
  final String incidentId;
  final String status;
  final String priority;

  const ApproveIncidentMediaEvent({
    required this.matchId,
    required this.incidentId,
    required this.status,
    required this.priority,
  });

  @override
  List<Object> get props => [matchId, incidentId, status, priority];
}
