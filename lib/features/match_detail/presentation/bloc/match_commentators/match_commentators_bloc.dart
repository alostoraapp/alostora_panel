import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_commentator_to_match_usecase.dart';
import '../../../domain/usecases/delete_commentator_from_match_usecase.dart';
import '../../../domain/usecases/get_match_commentators_usecase.dart';
import 'match_commentators_event.dart';
import 'match_commentators_state.dart';

class MatchCommentatorsBloc
    extends Bloc<MatchCommentatorsEvent, MatchCommentatorsState> {
  final GetMatchCommentatorsUseCase getMatchCommentators;
  final AddCommentatorToMatchUseCase addCommentatorToMatch;
  final DeleteCommentatorFromMatchUseCase deleteCommentatorFromMatch;

  MatchCommentatorsBloc({
    required this.getMatchCommentators,
    required this.addCommentatorToMatch,
    required this.deleteCommentatorFromMatch,
  }) : super(MatchCommentatorsInitial()) {
    on<GetMatchCommentatorsEvent>(_onGetMatchCommentators);
    on<AddCommentatorToMatchEvent>(_onAddCommentatorToMatch);
    on<DeleteCommentatorFromMatchEvent>(_onDeleteCommentatorFromMatch);
  }

  Future<void> _onGetMatchCommentators(
    GetMatchCommentatorsEvent event,
    Emitter<MatchCommentatorsState> emit,
  ) async {
    emit(MatchCommentatorsLoading());
    final result = await getMatchCommentators(event.matchId);
    result.fold(
      (failure) => emit(MatchCommentatorsError(message: failure.message)),
      (commentators) =>
          emit(MatchCommentatorsLoaded(commentators: commentators)),
    );
  }

  Future<void> _onAddCommentatorToMatch(
    AddCommentatorToMatchEvent event,
    Emitter<MatchCommentatorsState> emit,
  ) async {
    emit(MatchCommentatorsLoading());
    final result = await addCommentatorToMatch(AddCommentatorParams(
      matchId: event.matchId,
      commentatorId: event.commentatorId,
    ));
    result.fold(
      (failure) => emit(MatchCommentatorsError(message: failure.message)),
      (_) {
        emit(const MatchCommentatorsOperationSuccess(
            message: 'Commentator added successfully'));
        add(GetMatchCommentatorsEvent(matchId: event.matchId));
      },
    );
  }

  Future<void> _onDeleteCommentatorFromMatch(
    DeleteCommentatorFromMatchEvent event,
    Emitter<MatchCommentatorsState> emit,
  ) async {
    emit(MatchCommentatorsLoading());
    final result = await deleteCommentatorFromMatch(DeleteCommentatorParams(
      matchId: event.matchId,
      itemId: event.itemId,
    ));
    result.fold(
      (failure) => emit(MatchCommentatorsError(message: failure.message)),
      (_) {
        emit(const MatchCommentatorsOperationSuccess(
            message: 'Commentator deleted successfully'));
        add(GetMatchCommentatorsEvent(matchId: event.matchId));
      },
    );
  }
}
