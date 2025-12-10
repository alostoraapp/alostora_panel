import 'package:equatable/equatable.dart';
import '../../../../matches/domain/entities/match_entity.dart';

abstract class MatchDetailState extends Equatable {
  const MatchDetailState();

  @override
  List<Object> get props => [];
}

class MatchDetailInitial extends MatchDetailState {}

class MatchDetailLoading extends MatchDetailState {}

class MatchDetailLoaded extends MatchDetailState {
  final MatchEntity match;

  const MatchDetailLoaded(this.match);

  @override
  List<Object> get props => [match];
}

class MatchDetailError extends MatchDetailState {
  final String message;

  const MatchDetailError(this.message);

  @override
  List<Object> get props => [message];
}
