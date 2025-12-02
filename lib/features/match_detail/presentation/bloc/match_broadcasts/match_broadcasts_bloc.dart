import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_broadcast_usecase.dart';
import '../../../domain/usecases/delete_broadcast_usecase.dart';
import '../../../domain/usecases/get_broadcasts_usecase.dart';
import '../../../domain/usecases/update_broadcast_usecase.dart';
import 'match_broadcasts_event.dart';
import 'match_broadcasts_state.dart';

class MatchBroadcastsBloc
    extends Bloc<MatchBroadcastsEvent, MatchBroadcastsState> {
  final GetBroadcastsUseCase getBroadcastsUseCase;
  final CreateBroadcastUseCase createBroadcastUseCase;
  final UpdateBroadcastUseCase updateBroadcastUseCase;
  final DeleteBroadcastUseCase deleteBroadcastUseCase;

  MatchBroadcastsBloc({
    required this.getBroadcastsUseCase,
    required this.createBroadcastUseCase,
    required this.updateBroadcastUseCase,
    required this.deleteBroadcastUseCase,
  }) : super(MatchBroadcastsInitial()) {
    on<GetBroadcastsEvent>(_onGetBroadcasts);
    on<CreateBroadcastEvent>(_onCreateBroadcast);
    on<UpdateBroadcastEvent>(_onUpdateBroadcast);
    on<DeleteBroadcastEvent>(_onDeleteBroadcast);
  }

  Future<void> _onGetBroadcasts(
      GetBroadcastsEvent event, Emitter<MatchBroadcastsState> emit) async {
    emit(MatchBroadcastsLoading());
    final result = await getBroadcastsUseCase(event.matchId);
    result.fold(
      (failure) => emit(MatchBroadcastsError(message: failure.message)),
      (broadcasts) => emit(MatchBroadcastsLoaded(broadcasts: broadcasts)),
    );
  }

  Future<void> _onCreateBroadcast(
      CreateBroadcastEvent event, Emitter<MatchBroadcastsState> emit) async {
    emit(MatchBroadcastsLoading());
    final result = await createBroadcastUseCase(
        CreateBroadcastParams(matchId: event.matchId, params: event.params));
    result.fold(
      (failure) => emit(MatchBroadcastsError(message: failure.message)),
      (_) => add(GetBroadcastsEvent(matchId: event.matchId)),
    );
  }

  Future<void> _onUpdateBroadcast(
      UpdateBroadcastEvent event, Emitter<MatchBroadcastsState> emit) async {
    emit(MatchBroadcastsLoading());
    final result = await updateBroadcastUseCase(UpdateBroadcastParams(
      matchId: event.matchId,
      broadcastId: event.broadcastId,
      params: event.params,
    ));
    result.fold(
      (failure) => emit(MatchBroadcastsError(message: failure.message)),
      (_) => add(GetBroadcastsEvent(matchId: event.matchId)),
    );
  }

  Future<void> _onDeleteBroadcast(
      DeleteBroadcastEvent event, Emitter<MatchBroadcastsState> emit) async {
    emit(MatchBroadcastsLoading());
    final result = await deleteBroadcastUseCase(DeleteBroadcastParams(
        matchId: event.matchId, broadcastId: event.broadcastId));
    result.fold(
      (failure) => emit(MatchBroadcastsError(message: failure.message)),
      (_) => add(GetBroadcastsEvent(matchId: event.matchId)),
    );
  }
}
