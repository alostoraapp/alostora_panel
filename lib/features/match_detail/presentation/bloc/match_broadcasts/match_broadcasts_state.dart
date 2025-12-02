import 'package:equatable/equatable.dart';
import '../../../domain/entities/broadcast_entity.dart';

abstract class MatchBroadcastsState extends Equatable {
  const MatchBroadcastsState();

  @override
  List<Object> get props => [];
}

class MatchBroadcastsInitial extends MatchBroadcastsState {}

class MatchBroadcastsLoading extends MatchBroadcastsState {}

class MatchBroadcastsLoaded extends MatchBroadcastsState {
  final List<BroadcastEntity> broadcasts;

  const MatchBroadcastsLoaded({required this.broadcasts});

  @override
  List<Object> get props => [broadcasts];
}

class MatchBroadcastsError extends MatchBroadcastsState {
  final String message;

  const MatchBroadcastsError({required this.message});

  @override
  List<Object> get props => [message];
}
