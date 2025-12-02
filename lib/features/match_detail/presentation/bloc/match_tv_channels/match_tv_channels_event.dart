import 'package:equatable/equatable.dart';

abstract class MatchTvChannelsEvent extends Equatable {
  const MatchTvChannelsEvent();

  @override
  List<Object> get props => [];
}

class GetMatchTvChannelsEvent extends MatchTvChannelsEvent {
  final String matchId;

  const GetMatchTvChannelsEvent({required this.matchId});

  @override
  List<Object> get props => [matchId];
}

class AddTvChannelToMatchEvent extends MatchTvChannelsEvent {
  final String matchId;
  final String tvChannelId;

  const AddTvChannelToMatchEvent({
    required this.matchId,
    required this.tvChannelId,
  });

  @override
  List<Object> get props => [matchId, tvChannelId];
}

class DeleteTvChannelFromMatchEvent extends MatchTvChannelsEvent {
  final String matchId;
  final String itemId;

  const DeleteTvChannelFromMatchEvent({
    required this.matchId,
    required this.itemId,
  });

  @override
  List<Object> get props => [matchId, itemId];
}
