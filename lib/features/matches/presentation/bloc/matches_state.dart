import 'package:equatable/equatable.dart';

import '../../domain/entities/competition_entity.dart';

abstract class MatchesState extends Equatable {
  final DateTime? selectedDate;

  const MatchesState({this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
}

class MatchesInitial extends MatchesState {
  MatchesInitial() : super(selectedDate: DateTime.now());
}

class MatchesLoading extends MatchesState {
  const MatchesLoading({required DateTime? selectedDate})
      : super(selectedDate: selectedDate);
}

class MatchesLoaded extends MatchesState {
  final List<CompetitionEntity> competitions;

  const MatchesLoaded(this.competitions, {required DateTime? selectedDate})
      : super(selectedDate: selectedDate);

  @override
  List<Object?> get props => [competitions, selectedDate];
}

class MatchesError extends MatchesState {
  final String message;

  const MatchesError(this.message, {required DateTime? selectedDate})
      : super(selectedDate: selectedDate);

  @override
  List<Object?> get props => [message, selectedDate];
}
