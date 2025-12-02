import 'package:equatable/equatable.dart';
import '../../../domain/entities/match_tv_channel_entity.dart';

abstract class MatchTvChannelsState extends Equatable {
  const MatchTvChannelsState();

  @override
  List<Object> get props => [];
}

class MatchTvChannelsInitial extends MatchTvChannelsState {}

class MatchTvChannelsLoading extends MatchTvChannelsState {}

class MatchTvChannelsLoaded extends MatchTvChannelsState {
  final List<MatchTvChannelEntity> tvChannels;

  const MatchTvChannelsLoaded({required this.tvChannels});

  @override
  List<Object> get props => [tvChannels];
}

class MatchTvChannelsError extends MatchTvChannelsState {
  final String message;

  const MatchTvChannelsError({required this.message});

  @override
  List<Object> get props => [message];
}

class MatchTvChannelsOperationSuccess extends MatchTvChannelsState {
  final String message;

  const MatchTvChannelsOperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
