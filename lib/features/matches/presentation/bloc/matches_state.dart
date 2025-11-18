import 'package:equatable/equatable.dart';

import '../../domain/entities/competition_entity.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object?> get props => [];
}

class MatchesInitial extends MatchesState {}

class MatchesLoading extends MatchesState {}

class MatchesLoaded extends MatchesState {
  final List<CompetitionEntity> competitions;

  const MatchesLoaded(this.competitions);

  @override
  List<Object?> get props => [competitions];
}

class MatchesError extends MatchesState {
  final String message;

  const MatchesError(this.message);

  @override
  List<Object?> get props => [message];
}
