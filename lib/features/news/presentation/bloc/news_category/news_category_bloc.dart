import 'package:bloc/bloc.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/news_categories/add_news_category_usecase.dart';
import '../../../domain/usecases/news_categories/delete_news_category_usecase.dart';
import '../../../domain/usecases/news_categories/get_news_categories_usecase.dart';
import '../../../domain/usecases/news_categories/reorder_news_categories_usecase.dart';
import '../../../domain/usecases/news_categories/toggle_news_category_status_usecase.dart';
import '../../../domain/usecases/news_categories/update_news_category_usecase.dart';
import 'news_category_event.dart';
import 'news_category_state.dart';

class NewsCategoryBloc extends Bloc<NewsCategoryEvent, NewsCategoryState> {
  final GetNewsCategoriesUseCase getNewsCategories;
  final AddNewsCategoryUseCase addNewsCategory;
  final UpdateNewsCategoryUseCase updateNewsCategory;
  final ToggleNewsCategoryStatusUseCase toggleNewsCategoryStatus;
  final DeleteNewsCategoryUseCase deleteNewsCategory;
  final ReorderNewsCategoriesUseCase reorderNewsCategories;

  NewsCategoryBloc({
    required this.getNewsCategories,
    required this.addNewsCategory,
    required this.updateNewsCategory,
    required this.toggleNewsCategoryStatus,
    required this.deleteNewsCategory,
    required this.reorderNewsCategories,
  }) : super(NewsCategoryInitial()) {
    on<GetNewsCategoriesEvent>(_onGetNewsCategories);
    on<AddNewsCategoryEvent>(_onAddNewsCategory);
    on<UpdateNewsCategoryEvent>(_onUpdateNewsCategory);
    on<ToggleNewsCategoryStatusEvent>(_onToggleNewsCategoryStatus);
    on<DeleteNewsCategoryEvent>(_onDeleteNewsCategory);
    on<ReorderNewsCategoriesEvent>(_onReorderNewsCategories);
  }

  Future<void> _onGetNewsCategories(
    GetNewsCategoriesEvent event,
    Emitter<NewsCategoryState> emit,
  ) async {
    emit(NewsCategoryLoading());
    final result = await getNewsCategories(NoParams());
    result.fold(
      (failure) => emit(NewsCategoryError(failure.message)),
      (categories) => emit(NewsCategoryLoaded(categories)),
    );
  }

  Future<void> _onAddNewsCategory(
    AddNewsCategoryEvent event,
    Emitter<NewsCategoryState> emit,
  ) async {
    // Optimistic update or reload?
    // Usually reload is safer to get sorted list and IDs.
    // But we might want to show loading indicator.
    // Since we are adding, reloading is fine.
    emit(NewsCategoryLoading());
    final result = await addNewsCategory(event.body);
    result.fold(
      (failure) => emit(NewsCategoryError(failure.message)),
      (category) => add(const GetNewsCategoriesEvent()),
    );
  }

  Future<void> _onUpdateNewsCategory(
      UpdateNewsCategoryEvent event, Emitter<NewsCategoryState> emit) async {
    final result = await updateNewsCategory(
        UpdateNewsCategoryParams(id: event.id, body: event.body));
    result.fold(
      (failure) => emit(NewsCategoryError(failure.message)),
      (_) => add(GetNewsCategoriesEvent()),
    );
  }

  Future<void> _onToggleNewsCategoryStatus(
    ToggleNewsCategoryStatusEvent event,
    Emitter<NewsCategoryState> emit,
  ) async {
    // Allow optimistic update logic if needed, but for now simple reload or manual state update.
    // Let's implement manual state update to avoid full reload flickers if possible.
    // However, existing states use reload pattern.
    // Let's try to update state locally if loaded.
    final currentState = state;
    if (currentState is NewsCategoryLoaded) {
      final oldCategories = currentState.categories;
      // Optimistically update
      final index = oldCategories.indexWhere((c) => c.id == event.id);
      if (index != -1) {
        // This requires cloning logic or Equatable copyWith, but NewsCategory is constant.
        // Simpler to just call API and reload, or handle API result.
        // Let's call API.
      }
    }

    final result = await toggleNewsCategoryStatus(
      ToggleNewsCategoryParam(id: event.id, isActive: event.isActive),
    );

    result.fold(
      (failure) {
        // Show error? For now emit Error state might replace list.
        // Ideally show toast.
        emit(NewsCategoryError(failure.message));
        add(const GetNewsCategoriesEvent()); // Fallback reload
      },
      (updatedCategory) {
        // Reload list to ensure sync
        add(const GetNewsCategoriesEvent());
      },
    );
  }

  Future<void> _onDeleteNewsCategory(
    DeleteNewsCategoryEvent event,
    Emitter<NewsCategoryState> emit,
  ) async {
    emit(NewsCategoryLoading());
    final result = await deleteNewsCategory(event.id);
    result.fold(
      (failure) => emit(NewsCategoryError(failure.message)),
      (_) => add(const GetNewsCategoriesEvent()),
    );
  }

  Future<void> _onReorderNewsCategories(
    ReorderNewsCategoriesEvent event,
    Emitter<NewsCategoryState> emit,
  ) async {
    final currentState = state;
    if (currentState is NewsCategoryLoaded) {
      final List<String> ids = List.from(event.orderedIds);
      final item = ids.removeAt(event.oldIndex);
      ids.insert(event.newIndex, item);

      // We should probably update UI immediately (optimistic)
      // But we need the full objects.
      // The event passed orderedIds which are Strings.
      // Wait, ReorderableListView in screen gives oldIndex/newIndex.
      // We need to reorder the actual objects in the state to update UI immediately.

      final currentList = List.of(currentState.categories);
      final movedItem = currentList.removeAt(event.oldIndex);
      currentList.insert(event.newIndex, movedItem);

      emit(NewsCategoryLoaded(currentList));

      final result = await reorderNewsCategories(ids);
      result.fold(
        (failure) {
          emit(NewsCategoryError(failure.message));
          add(const GetNewsCategoriesEvent());
        },
        (_) {
          // Success, maybe silent or reload to confirm?
          // Usually valid.
        },
      );
    }
  }
}
