import 'package:equatable/equatable.dart';

import '../../domain/entities/competition_config_entity.dart';

abstract class CompetitionConfigState extends Equatable {
  const CompetitionConfigState();

  @override
  List<Object?> get props => [];
}

class CompetitionConfigInitial extends CompetitionConfigState {}

class CompetitionConfigLoading extends CompetitionConfigState {}

class CompetitionConfigLoaded extends CompetitionConfigState {
  final List<CompetitionConfigEntity> configs;

  const CompetitionConfigLoaded(this.configs);

  @override
  List<Object?> get props => [configs];
}

class CompetitionConfigError extends CompetitionConfigState {
  final String message;

  const CompetitionConfigError(this.message);

  @override
  List<Object?> get props => [message];
}
