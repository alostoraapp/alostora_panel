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
  final int? startTimestamp;
  final int? endTimestamp;

  const GetMatches({
    this.search,
    this.ordering,
    this.isLive,
    this.startTimestamp,
    this.endTimestamp,
  });

  @override
  List<Object?> get props => [search, ordering, isLive, startTimestamp, endTimestamp];
}
