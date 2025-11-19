import 'package:equatable/equatable.dart';

abstract class CompetitionConfigEvent extends Equatable {
  const CompetitionConfigEvent();

  @override
  List<Object?> get props => [];
}

class GetCompetitionConfigsEvent extends CompetitionConfigEvent {
  final String? search;

  const GetCompetitionConfigsEvent({this.search});

  @override
  List<Object?> get props => [search];
}

class SearchCompetitionConfigsEvent extends CompetitionConfigEvent {
  final String query;

  const SearchCompetitionConfigsEvent(this.query);

  @override
  List<Object?> get props => [query];
}


class AddCompetitionConfigEvent extends CompetitionConfigEvent {
  final String competitionId;

  const AddCompetitionConfigEvent(this.competitionId);

  @override
  List<Object?> get props => [competitionId];
}

class ToggleCompetitionStatusEvent extends CompetitionConfigEvent {
  final String id;
  final bool isActive;

  const ToggleCompetitionStatusEvent(this.id, this.isActive);

  @override
  List<Object?> get props => [id, isActive];
}

class DeleteCompetitionConfigEvent extends CompetitionConfigEvent {
  final String id;

  const DeleteCompetitionConfigEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ReorderCompetitionConfigsEvent extends CompetitionConfigEvent {
  final List<String> orderedIds;
  final int oldIndex;
  final int newIndex;

  const ReorderCompetitionConfigsEvent(this.orderedIds, this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [orderedIds, oldIndex, newIndex];
}
