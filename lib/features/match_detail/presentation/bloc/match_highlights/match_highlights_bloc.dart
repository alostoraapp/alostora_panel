import 'package:alostora/features/match_detail/domain/usecases/approve_highlight_usecase.dart';
import 'package:alostora/features/match_detail/domain/usecases/create_highlight_usecase.dart';
import 'package:alostora/features/match_detail/domain/usecases/delete_highlight_usecase.dart';
import 'package:alostora/features/match_detail/domain/usecases/get_highlights_usecase.dart';
import 'package:alostora/features/match_detail/domain/usecases/update_highlight_usecase.dart';
import 'package:alostora/features/match_detail/presentation/bloc/match_highlights/match_highlights_event.dart';
import 'package:alostora/features/match_detail/presentation/bloc/match_highlights/match_highlights_state.dart';
import 'package:bloc/bloc.dart';

class MatchHighlightsBloc
    extends Bloc<MatchHighlightsEvent, MatchHighlightsState> {
  final GetHighlightsUseCase getHighlightsUseCase;
  final CreateHighlightUseCase createHighlightUseCase;
  final UpdateHighlightUseCase updateHighlightUseCase;
  final DeleteHighlightUseCase deleteHighlightUseCase;
  final ApproveHighlightUseCase approveHighlightUseCase;

  MatchHighlightsBloc({
    required this.getHighlightsUseCase,
    required this.createHighlightUseCase,
    required this.updateHighlightUseCase,
    required this.deleteHighlightUseCase,
    required this.approveHighlightUseCase,
  }) : super(MatchHighlightsInitial()) {
    on<GetMatchHighlightsEvent>(_onGetMatchHighlights);
    on<CreateHighlightEvent>(_onCreateHighlight);
    on<UpdateHighlightEvent>(_onUpdateHighlight);
    on<DeleteHighlightEvent>(_onDeleteHighlight);
    on<ApproveHighlightEvent>(_onApproveHighlight);
  }

  Future<void> _onGetMatchHighlights(
    GetMatchHighlightsEvent event,
    Emitter<MatchHighlightsState> emit,
  ) async {
    emit(MatchHighlightsLoading());
    final result = await getHighlightsUseCase(event.matchId);
    result.fold(
      (failure) => emit(MatchHighlightsError(failure.message)),
      (highlights) => emit(MatchHighlightsLoaded(highlights)),
    );
  }

  Future<void> _onCreateHighlight(
    CreateHighlightEvent event,
    Emitter<MatchHighlightsState> emit,
  ) async {
    emit(MatchHighlightsLoading());
    final result = await createHighlightUseCase(
        CreateHighlightParams(matchId: event.matchId, params: event.params));
    result.fold(
      (failure) => emit(MatchHighlightsError(failure.message)),
      (_) => add(GetMatchHighlightsEvent(event.matchId)),
    );
  }

  Future<void> _onUpdateHighlight(
    UpdateHighlightEvent event,
    Emitter<MatchHighlightsState> emit,
  ) async {
    emit(MatchHighlightsLoading());
    final result = await updateHighlightUseCase(UpdateHighlightParams(
      matchId: event.matchId,
      highlightId: event.highlightId,
      params: event.params,
    ));
    result.fold(
      (failure) => emit(MatchHighlightsError(failure.message)),
      (_) => add(GetMatchHighlightsEvent(event.matchId)),
    );
  }

  Future<void> _onDeleteHighlight(
    DeleteHighlightEvent event,
    Emitter<MatchHighlightsState> emit,
  ) async {
    emit(MatchHighlightsLoading());
    final result = await deleteHighlightUseCase(DeleteHighlightParams(
      matchId: event.matchId,
      highlightId: event.highlightId,
    ));
    result.fold(
      (failure) => emit(MatchHighlightsError(failure.message)),
      (_) => add(GetMatchHighlightsEvent(event.matchId)),
    );
  }

  Future<void> _onApproveHighlight(
    ApproveHighlightEvent event,
    Emitter<MatchHighlightsState> emit,
  ) async {
    emit(MatchHighlightsLoading());
    final result = await approveHighlightUseCase(ApproveHighlightParams(
      matchId: event.matchId,
      highlightId: event.highlightId,
      status: event.status,
      priority: event.priority,
    ));
    result.fold(
      (failure) => emit(MatchHighlightsError(failure.message)),
      (_) => add(GetMatchHighlightsEvent(event.matchId)),
    );
  }
}
