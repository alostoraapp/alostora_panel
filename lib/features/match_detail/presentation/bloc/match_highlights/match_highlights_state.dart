import 'package:alostora/features/match_detail/domain/entities/highlight_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MatchHighlightsState extends Equatable {
  const MatchHighlightsState();

  @override
  List<Object> get props => [];
}

class MatchHighlightsInitial extends MatchHighlightsState {}

class MatchHighlightsLoading extends MatchHighlightsState {}

class MatchHighlightsLoaded extends MatchHighlightsState {
  final List<HighlightEntity> highlights;

  const MatchHighlightsLoaded(this.highlights);

  @override
  List<Object> get props => [highlights];
}

class MatchHighlightsError extends MatchHighlightsState {
  final String message;

  const MatchHighlightsError(this.message);

  @override
  List<Object> get props => [message];
}
