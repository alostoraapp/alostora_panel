import 'package:equatable/equatable.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object?> get props => [];
}

class GetMatches extends MatchesEvent {
  final String? search;
  final String? ordering;
  final bool? isLive;

  const GetMatches({
    this.search,
    this.ordering,
    this.isLive,
  });

  @override
  List<Object?> get props => [search, ordering, isLive];
}

class ChangeDate extends MatchesEvent {
  final DateTime newDate;

  const ChangeDate(this.newDate);

  @override
  List<Object?> get props => [newDate];
}
