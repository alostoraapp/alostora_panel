part of 'lineup_bloc.dart';

abstract class LineupState extends Equatable {
  const LineupState();

  @override
  List<Object> get props => [];
}

class LineupInitial extends LineupState {}

class LineupLoading extends LineupState {}

class LineupLoaded extends LineupState {
  final LineupEntity lineup;

  const LineupLoaded({required this.lineup});

  @override
  List<Object> get props => [lineup];
}

class LineupError extends LineupState {
  final String message;

  const LineupError({required this.message});

  @override
  List<Object> get props => [message];
}
