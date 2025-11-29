import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alostora/features/match_detail/domain/entities/incident_entity.dart';
import 'package:alostora/features/match_detail/domain/usecases/get_match_incidents_usecase.dart';
import '../../../domain/usecases/delete_incident_media_usecase.dart';
import '../../../domain/usecases/update_incident_media_usecase.dart';
import 'package:alostora/features/match_detail/domain/usecases/approve_incident_media_usecase.dart';

part 'match_incidents_event.dart';
part 'match_incidents_state.dart';

class MatchIncidentsBloc
    extends Bloc<MatchIncidentsEvent, MatchIncidentsState> {
  final GetMatchIncidentsUseCase getMatchIncidentsUseCase;
  final UpdateIncidentMediaUseCase updateIncidentMediaUseCase;
  final DeleteIncidentMediaUseCase deleteIncidentMediaUseCase;
  final ApproveIncidentMediaUseCase approveIncidentMediaUseCase;

  MatchIncidentsBloc({
    required this.getMatchIncidentsUseCase,
    required this.updateIncidentMediaUseCase,
    required this.deleteIncidentMediaUseCase,
    required this.approveIncidentMediaUseCase,
  }) : super(MatchIncidentsInitial()) {
    on<GetMatchIncidentsEvent>(_onGetMatchIncidents);
    on<UpdateIncidentMediaEvent>(_onUpdateIncidentMedia);
    on<DeleteIncidentMediaEvent>(_onDeleteIncidentMedia);
    on<ApproveIncidentMediaEvent>(_onApproveIncidentMedia);
  }

  Future<void> _onGetMatchIncidents(
    GetMatchIncidentsEvent event,
    Emitter<MatchIncidentsState> emit,
  ) async {
    emit(MatchIncidentsLoading());
    final result = await getMatchIncidentsUseCase(event.matchId);
    result.fold(
      (failure) => emit(MatchIncidentsError(failure.message)),
      (incidents) => emit(MatchIncidentsLoaded(incidents)),
    );
  }

  Future<void> _onUpdateIncidentMedia(
    UpdateIncidentMediaEvent event,
    Emitter<MatchIncidentsState> emit,
  ) async {
    emit(MatchIncidentsLoading());
    final result = await updateIncidentMediaUseCase(UpdateIncidentMediaParams(
      matchId: event.matchId,
      incidentId: event.incidentId,
      mediaUrl: event.mediaUrl,
      mediaCover: event.mediaCover,
      videoTime: event.videoTime,
    ));
    result.fold(
      (failure) => emit(MatchIncidentsError(failure.message)),
      (incidents) => emit(MatchIncidentsLoaded(incidents)),
    );
  }

  Future<void> _onDeleteIncidentMedia(
    DeleteIncidentMediaEvent event,
    Emitter<MatchIncidentsState> emit,
  ) async {
    emit(MatchIncidentsLoading());
    final result = await deleteIncidentMediaUseCase(DeleteIncidentMediaParams(
      matchId: event.matchId,
      incidentId: event.incidentId,
    ));
    result.fold(
      (failure) => emit(MatchIncidentsError(failure.message)),
      (incidents) => emit(MatchIncidentsLoaded(incidents)),
    );
  }

  Future<void> _onApproveIncidentMedia(
    ApproveIncidentMediaEvent event,
    Emitter<MatchIncidentsState> emit,
  ) async {
    emit(MatchIncidentsLoading());
    final result = await approveIncidentMediaUseCase(ApproveIncidentMediaParams(
      matchId: event.matchId,
      incidentId: event.incidentId,
      status: event.status,
      priority: event.priority,
    ));
    result.fold(
      (failure) => emit(MatchIncidentsError(failure.message)),
      (_) {
        // After approval, refresh the list
        add(GetMatchIncidentsEvent(event.matchId));
      },
    );
  }
}
