import 'package:equatable/equatable.dart';

abstract class CompetitionDetailEvent extends Equatable {
  const CompetitionDetailEvent();

  @override
  List<Object> get props => [];
}

class GetCompetitionDetailEvent extends CompetitionDetailEvent {
  final String competitionId;

  const GetCompetitionDetailEvent({required this.competitionId});

  @override
  List<Object> get props => [competitionId];
}

class UpdateCompetitionDetailEvent extends CompetitionDetailEvent {
  final String competitionId;
  final Map<String, dynamic> body;

  const UpdateCompetitionDetailEvent(
      {required this.competitionId, required this.body});

  @override
  List<Object> get props => [competitionId, body];
}
