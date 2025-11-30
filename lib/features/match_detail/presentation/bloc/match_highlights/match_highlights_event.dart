import 'package:equatable/equatable.dart';

abstract class MatchHighlightsEvent extends Equatable {
  const MatchHighlightsEvent();

  @override
  List<Object> get props => [];
}

class GetMatchHighlightsEvent extends MatchHighlightsEvent {
  final String matchId;

  const GetMatchHighlightsEvent(this.matchId);

  @override
  List<Object> get props => [matchId];
}

class CreateHighlightEvent extends MatchHighlightsEvent {
  final String matchId;
  final Map<String, dynamic> params;

  const CreateHighlightEvent({required this.matchId, required this.params});

  @override
  List<Object> get props => [matchId, params];
}

class UpdateHighlightEvent extends MatchHighlightsEvent {
  final String matchId;
  final String highlightId;
  final Map<String, dynamic> params;

  const UpdateHighlightEvent({
    required this.matchId,
    required this.highlightId,
    required this.params,
  });

  @override
  List<Object> get props => [matchId, highlightId, params];
}

class DeleteHighlightEvent extends MatchHighlightsEvent {
  final String matchId;
  final String highlightId;

  const DeleteHighlightEvent(
      {required this.matchId, required this.highlightId});

  @override
  List<Object> get props => [matchId, highlightId];
}

class ApproveHighlightEvent extends MatchHighlightsEvent {
  final String matchId;
  final String highlightId;
  final String status;
  final String priority;

  const ApproveHighlightEvent({
    required this.matchId,
    required this.highlightId,
    required this.status,
    required this.priority,
  });

  @override
  List<Object> get props => [matchId, highlightId, status, priority];
}
