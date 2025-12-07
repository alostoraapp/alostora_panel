import 'package:equatable/equatable.dart';

abstract class MatchCommentatorsEvent extends Equatable {
  const MatchCommentatorsEvent();

  @override
  List<Object?> get props => [];
}

class GetMatchCommentatorsEvent extends MatchCommentatorsEvent {
  final String matchId;

  const GetMatchCommentatorsEvent({required this.matchId});

  @override
  List<Object?> get props => [matchId];
}

class AddCommentatorToMatchEvent extends MatchCommentatorsEvent {
  final String matchId;
  final String commentatorId;
  final String? tvChannelId;

  const AddCommentatorToMatchEvent({
    required this.matchId,
    required this.commentatorId,
    this.tvChannelId,
  });

  @override
  List<Object?> get props => [matchId, commentatorId, tvChannelId];
}

class DeleteCommentatorFromMatchEvent extends MatchCommentatorsEvent {
  final String matchId;
  final String itemId;

  const DeleteCommentatorFromMatchEvent({
    required this.matchId,
    required this.itemId,
  });

  @override
  List<Object?> get props => [matchId, itemId];
}
