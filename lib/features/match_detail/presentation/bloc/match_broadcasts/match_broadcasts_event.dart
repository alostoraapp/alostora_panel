import 'package:equatable/equatable.dart';

abstract class MatchBroadcastsEvent extends Equatable {
  const MatchBroadcastsEvent();

  @override
  List<Object> get props => [];
}

class GetBroadcastsEvent extends MatchBroadcastsEvent {
  final String matchId;

  const GetBroadcastsEvent({required this.matchId});

  @override
  List<Object> get props => [matchId];
}

class CreateBroadcastEvent extends MatchBroadcastsEvent {
  final String matchId;
  final Map<String, dynamic> params;

  const CreateBroadcastEvent({required this.matchId, required this.params});

  @override
  List<Object> get props => [matchId, params];
}

class UpdateBroadcastEvent extends MatchBroadcastsEvent {
  final String matchId;
  final String broadcastId;
  final Map<String, dynamic> params;

  const UpdateBroadcastEvent({
    required this.matchId,
    required this.broadcastId,
    required this.params,
  });

  @override
  List<Object> get props => [matchId, broadcastId, params];
}

class DeleteBroadcastEvent extends MatchBroadcastsEvent {
  final String matchId;
  final String broadcastId;

  const DeleteBroadcastEvent(
      {required this.matchId, required this.broadcastId});

  @override
  List<Object> get props => [matchId, broadcastId];
}
