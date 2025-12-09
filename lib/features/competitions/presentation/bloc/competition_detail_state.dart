import 'package:equatable/equatable.dart';
import '../../domain/entities/competition_detail_entity.dart';

abstract class CompetitionDetailState extends Equatable {
  const CompetitionDetailState();

  @override
  List<Object?> get props => [];
}

class CompetitionDetailInitial extends CompetitionDetailState {}

class CompetitionDetailLoading extends CompetitionDetailState {}

class CompetitionDetailLoaded extends CompetitionDetailState {
  final CompetitionDetailEntity competition;

  const CompetitionDetailLoaded({required this.competition});

  @override
  List<Object?> get props => [competition];
}

class CompetitionDetailError extends CompetitionDetailState {
  final String message;

  const CompetitionDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CompetitionDetailUpdating extends CompetitionDetailState {
  final CompetitionDetailEntity? competition;

  const CompetitionDetailUpdating({this.competition});

  @override
  List<Object?> get props => [competition];
}

class CompetitionDetailUpdated extends CompetitionDetailState {
  final CompetitionDetailEntity competition;

  const CompetitionDetailUpdated({required this.competition});

  @override
  List<Object?> get props => [competition];
}

class CompetitionDetailUpdateError extends CompetitionDetailState {
  final String message;

  const CompetitionDetailUpdateError({required this.message});

  @override
  List<Object?> get props => [message];
}
