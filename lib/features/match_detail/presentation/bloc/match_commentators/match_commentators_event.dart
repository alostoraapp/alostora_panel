import 'package:equatable/equatable.dart';

abstract class MatchCommentatorsEvent extends Equatable {
  const MatchCommentatorsEvent();

  @override
  List<Object> get props => [];
}

class GetMatchCommentatorsEvent extends MatchCommentatorsEvent {
  final String matchId;

  const GetMatchCommentatorsEvent({required this.matchId});

  @override
  List<Object> get props => [matchId];
}

class AddCommentatorToMatchEvent extends MatchCommentatorsEvent {
  final String matchId;
  final String commentatorId;

  const AddCommentatorToMatchEvent({
    required this.matchId,
    required this.commentatorId,
  });

  @override
  List<Object> get props => [matchId, commentatorId];
}

class DeleteCommentatorFromMatchEvent extends MatchCommentatorsEvent {
  final String matchId;
  final String itemId;

  const DeleteCommentatorFromMatchEvent({
    required this.matchId,
    required this.itemId,
  });

  @override
  List<Object> get props => [matchId, itemId];
}
