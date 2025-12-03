import 'package:equatable/equatable.dart';
import '../../../domain/entities/match_commentator_entity.dart';

abstract class MatchCommentatorsState extends Equatable {
  const MatchCommentatorsState();

  @override
  List<Object> get props => [];
}

class MatchCommentatorsInitial extends MatchCommentatorsState {}

class MatchCommentatorsLoading extends MatchCommentatorsState {}

class MatchCommentatorsLoaded extends MatchCommentatorsState {
  final List<MatchCommentatorEntity> commentators;

  const MatchCommentatorsLoaded({required this.commentators});

  @override
  List<Object> get props => [commentators];
}

class MatchCommentatorsError extends MatchCommentatorsState {
  final String message;

  const MatchCommentatorsError({required this.message});

  @override
  List<Object> get props => [message];
}

class MatchCommentatorsOperationSuccess extends MatchCommentatorsState {
  final String message;

  const MatchCommentatorsOperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
