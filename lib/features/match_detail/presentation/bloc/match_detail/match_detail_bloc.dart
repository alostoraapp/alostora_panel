import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../matches/domain/usecases/get_match_usecase.dart';
import 'match_detail_event.dart';
import 'match_detail_state.dart';

class MatchDetailBloc extends Bloc<MatchDetailEvent, MatchDetailState> {
  final GetMatchUseCase getMatchUseCase;

  MatchDetailBloc(this.getMatchUseCase) : super(MatchDetailInitial()) {
    on<GetMatchDetail>(_onGetMatchDetail);
  }

  Future<void> _onGetMatchDetail(
    GetMatchDetail event,
    Emitter<MatchDetailState> emit,
  ) async {
    emit(MatchDetailLoading());
    final result = await getMatchUseCase(event.matchId);
    result.fold(
      (failure) => emit(MatchDetailError(failure.message)),
      (match) => emit(MatchDetailLoaded(match)),
    );
  }
}
