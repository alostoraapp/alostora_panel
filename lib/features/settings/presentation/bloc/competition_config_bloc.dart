import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_competition_config_usecase.dart';
import '../../domain/usecases/delete_competition_config_usecase.dart';
import '../../domain/usecases/get_competition_configs_usecase.dart';
import '../../domain/usecases/reorder_competition_configs_usecase.dart';
import '../../domain/usecases/toggle_competition_status_usecase.dart';
import 'competition_config_event.dart';
import 'competition_config_state.dart';

class CompetitionConfigBloc extends Bloc<CompetitionConfigEvent, CompetitionConfigState> {
  final GetCompetitionConfigsUseCase getCompetitionConfigs;
  final AddCompetitionConfigUseCase addCompetitionConfig;
  final ToggleCompetitionStatusUseCase toggleCompetitionStatus;
  final DeleteCompetitionConfigUseCase deleteCompetitionConfig;
  final ReorderCompetitionConfigsUseCase reorderCompetitionConfigs;

  CompetitionConfigBloc({
    required this.getCompetitionConfigs,
    required this.addCompetitionConfig,
    required this.toggleCompetitionStatus,
    required this.deleteCompetitionConfig,
    required this.reorderCompetitionConfigs,
  }) : super(CompetitionConfigInitial()) {
    // Registering handlers
    on<GetCompetitionConfigsEvent>(_onGetConfigs);
    on<SearchCompetitionConfigsEvent>(_onSearchConfigs);
    on<AddCompetitionConfigEvent>(_onAddConfig);
    on<ToggleCompetitionStatusEvent>(_onToggleStatus);
    on<DeleteCompetitionConfigEvent>(_onDeleteConfig);
    on<ReorderCompetitionConfigsEvent>(_onReorderConfigs);
  }

  Future<void> _onGetConfigs(GetCompetitionConfigsEvent event, Emitter<CompetitionConfigState> emit) async {
    emit(CompetitionConfigLoading());
    final result = await getCompetitionConfigs(search: event.search);
    result.fold(
      (failure) => emit(CompetitionConfigError(failure.message)),
      (configs) => emit(CompetitionConfigLoaded(configs)),
    );
  }

  Future<void> _onSearchConfigs(SearchCompetitionConfigsEvent event, Emitter<CompetitionConfigState> emit) async {
    emit(CompetitionConfigLoading());
    // Passing the search query to the use case
    final result = await getCompetitionConfigs(search: event.query);
    result.fold(
      (failure) => emit(CompetitionConfigError(failure.message)),
      (configs) => emit(CompetitionConfigLoaded(configs)),
    );
  }

  Future<void> _onAddConfig(AddCompetitionConfigEvent event, Emitter<CompetitionConfigState> emit) async {
    // Typically, we'd show a loading indicator or just optimistic update.
    // For simplicity, let's reload the list after adding.
    final result = await addCompetitionConfig(event.competitionId);
    result.fold(
      (failure) => emit(CompetitionConfigError(failure.message)),
      (config) => add(const GetCompetitionConfigsEvent()), // Reload
    );
  }

  Future<void> _onToggleStatus(ToggleCompetitionStatusEvent event, Emitter<CompetitionConfigState> emit) async {
    if (state is CompetitionConfigLoaded) {
      final currentConfigs = (state as CompetitionConfigLoaded).configs;
      // Optimistic update?
      // Let's just call API and reload or update local state.
      final result = await toggleCompetitionStatus(event.id, event.isActive);
      result.fold(
        (failure) => emit(CompetitionConfigError(failure.message)),
        (updatedConfig) {
          final updatedList = currentConfigs.map((c) => c.id == updatedConfig.id ? updatedConfig : c).toList();
          emit(CompetitionConfigLoaded(updatedList));
        },
      );
    }
  }

  Future<void> _onDeleteConfig(DeleteCompetitionConfigEvent event, Emitter<CompetitionConfigState> emit) async {
     if (state is CompetitionConfigLoaded) {
      final currentConfigs = (state as CompetitionConfigLoaded).configs;
      final result = await deleteCompetitionConfig(event.id);
      result.fold(
        (failure) => emit(CompetitionConfigError(failure.message)),
        (_) {
          final updatedList = currentConfigs.where((c) => c.id != event.id).toList();
          emit(CompetitionConfigLoaded(updatedList));
        },
      );
    }
  }

  Future<void> _onReorderConfigs(ReorderCompetitionConfigsEvent event, Emitter<CompetitionConfigState> emit) async {
    if (state is CompetitionConfigLoaded) {
       // Optimistic update
      final currentConfigs = List.of((state as CompetitionConfigLoaded).configs);
      
      if (event.oldIndex < event.newIndex) {
        // dragging down
         // Adjust index because removing the item shifts subsequent items
      }
      
      // The UI usually handles the drag and drop visual, calling this event to persist.
      // The event passed orderedIds which is the new order.
      // However, the UI snippet provided uses reorderable list logic which gives oldIndex and newIndex.
      // The usecase expects list of IDs.
      
      // Let's reconstruct the list based on old/new index to be safe, OR trust the UI passed the right ID list if the event was designed that way.
      // But my event takes orderedIds directly.
      
      final item = currentConfigs.removeAt(event.oldIndex);
      var newIndex = event.newIndex;
      if (event.oldIndex < newIndex) {
          newIndex -= 1;
      }
      currentConfigs.insert(newIndex, item);
      
      emit(CompetitionConfigLoaded(currentConfigs)); // Optimistic update UI

      final ids = currentConfigs.map((e) => e.id).toList();
      final result = await reorderCompetitionConfigs(ids);
      
      result.fold(
        (failure) {
            // Revert if failed? For now just show error
            emit(CompetitionConfigError(failure.message));
            add(const GetCompetitionConfigsEvent()); // Reload to sync
        }, 
        (_) {
            // Success
        }
      );
    }
  }
}
