import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_tv_channel_to_match_usecase.dart';
import '../../../domain/usecases/delete_tv_channel_from_match_usecase.dart';
import '../../../domain/usecases/get_match_tv_channels_usecase.dart';
import 'match_tv_channels_event.dart';
import 'match_tv_channels_state.dart';

class MatchTvChannelsBloc
    extends Bloc<MatchTvChannelsEvent, MatchTvChannelsState> {
  final GetMatchTvChannelsUseCase getMatchTvChannels;
  final AddTvChannelToMatchUseCase addTvChannelToMatch;
  final DeleteTvChannelFromMatchUseCase deleteTvChannelFromMatch;

  MatchTvChannelsBloc({
    required this.getMatchTvChannels,
    required this.addTvChannelToMatch,
    required this.deleteTvChannelFromMatch,
  }) : super(MatchTvChannelsInitial()) {
    on<GetMatchTvChannelsEvent>(_onGetMatchTvChannels);
    on<AddTvChannelToMatchEvent>(_onAddTvChannelToMatch);
    on<DeleteTvChannelFromMatchEvent>(_onDeleteTvChannelFromMatch);
  }

  Future<void> _onGetMatchTvChannels(
    GetMatchTvChannelsEvent event,
    Emitter<MatchTvChannelsState> emit,
  ) async {
    emit(MatchTvChannelsLoading());
    final result = await getMatchTvChannels(event.matchId);
    result.fold(
      (failure) => emit(MatchTvChannelsError(message: failure.message)),
      (tvChannels) => emit(MatchTvChannelsLoaded(tvChannels: tvChannels)),
    );
  }

  Future<void> _onAddTvChannelToMatch(
    AddTvChannelToMatchEvent event,
    Emitter<MatchTvChannelsState> emit,
  ) async {
    emit(MatchTvChannelsLoading());
    final result = await addTvChannelToMatch(
      AddTvChannelParams(
        matchId: event.matchId,
        tvChannelId: event.tvChannelId,
      ),
    );
    result.fold(
      (failure) => emit(MatchTvChannelsError(message: failure.message)),
      (_) {
        emit(const MatchTvChannelsOperationSuccess(
            message: 'TV Channel added successfully'));
        add(GetMatchTvChannelsEvent(matchId: event.matchId));
      },
    );
  }

  Future<void> _onDeleteTvChannelFromMatch(
    DeleteTvChannelFromMatchEvent event,
    Emitter<MatchTvChannelsState> emit,
  ) async {
    emit(MatchTvChannelsLoading());
    final result = await deleteTvChannelFromMatch(
      DeleteTvChannelParams(
        matchId: event.matchId,
        itemId: event.itemId,
      ),
    );
    result.fold(
      (failure) => emit(MatchTvChannelsError(message: failure.message)),
      (_) {
        emit(const MatchTvChannelsOperationSuccess(
            message: 'TV Channel deleted successfully'));
        add(GetMatchTvChannelsEvent(matchId: event.matchId));
      },
    );
  }
}
