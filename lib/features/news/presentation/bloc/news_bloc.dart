import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/features/news/domain/entities/news_category.dart';
import 'package:alostora/features/news/domain/usecases/get_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/create_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/update_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/delete_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/approve_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/news_categories/get_news_categories_usecase.dart';
import 'news_event.dart';
import 'news_state.dart';

import 'package:image_picker/image_picker.dart';
import 'package:alostora/features/news/domain/usecases/upload_news_image_usecase.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNews;
  final CreateNewsUseCase createNews;
  final UpdateNewsUseCase updateNews;
  final DeleteNewsUseCase deleteNews;
  final ApproveNewsUseCase approveNews;
  final UploadNewsImageUseCase uploadNewsImage;
  final GetNewsCategoriesUseCase getNewsCategories;

  NewsBloc({
    required this.getNews,
    required this.createNews,
    required this.updateNews,
    required this.deleteNews,
    required this.approveNews,
    required this.uploadNewsImage,
    required this.getNewsCategories,
  }) : super(NewsInitial()) {
    on<GetNewsEvent>(_onGetNews);
    on<CreateNewsEvent>(_onCreateNews);
    on<UpdateNewsEvent>(_onUpdateNews);
    on<DeleteNewsEvent>(_onDeleteNews);
    on<ApproveNewsEvent>(_onApproveNews);
  }

  Future<void> _onGetNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    final isRefresh = event.offset == 0;
    List<NewsCategory> categories = [];
    String? currentCategoryId = event.categoryId;

    if (state is NewsLoaded) {
      categories = (state as NewsLoaded).categories;
      // If categoryId is not passed (e.g. load more), use the one from state
      if (currentCategoryId == null && !isRefresh) {
        currentCategoryId = (state as NewsLoaded).selectedCategoryId;
      }
    }

    if (!isRefresh && state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      if (currentState.hasReachedMax || currentState.isLoadingMore) return;
      emit(currentState.copyWith(isLoadingMore: true));
    } else {
      emit(NewsLoading());
    }

    // Fetch categories if empty
    if (categories.isEmpty) {
      final catResult = await getNewsCategories(NoParams());
      catResult.fold(
        (l) => null,
        (r) => categories = r,
      );
    }

    final result = await getNews(
        limit: event.limit,
        offset: event.offset,
        categoryId: currentCategoryId);

    result.fold(
      (failure) {
        if (!isRefresh && state is NewsLoaded) {
          emit((state as NewsLoaded).copyWith(isLoadingMore: false));
        } else {
          emit(const NewsError('Failed to fetch news'));
        }
      },
      (news) {
        final hasReachedMax = news.length < event.limit;
        if (!isRefresh && state is NewsLoaded) {
          emit(NewsLoaded(
            (state as NewsLoaded).news + news,
            categories: categories,
            selectedCategoryId: currentCategoryId,
            hasReachedMax: hasReachedMax,
            isLoadingMore: false,
          ));
        } else {
          emit(NewsLoaded(news,
              categories: categories,
              selectedCategoryId: currentCategoryId,
              hasReachedMax: hasReachedMax));
        }
      },
    );
  }

  Future<void> _onCreateNews(
      CreateNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final newsData = Map<String, dynamic>.from(event.newsData);
    final List<XFile> images =
        (newsData['images'] as List<dynamic>?)?.cast<XFile>() ?? [];
    final int? coverImageIndex = newsData['cover_image_index'];

    // Remove images and cover_image_index from metadata payload
    newsData.remove('images');
    newsData.remove('cover_image_index');

    // 1. Create News Metadata
    final result = await createNews(newsData);

    await result.fold(
      (failure) async => emit(const NewsError('Failed to create news')),
      (news) async {
        // 2. Upload Images
        String? newCoverImageId;
        for (int i = 0; i < images.length; i++) {
          final uploadResult = await uploadNewsImage(
              UploadNewsImageParams(id: news.id, image: images[i]));

          if (coverImageIndex == i) {
            uploadResult.fold(
              (l) => null, // Ignore failure for cover detection
              (img) => newCoverImageId = img.id,
            );
          }
        }

        // 3. Set Cover Image if it was a new image
        if (newCoverImageId != null) {
          await updateNews(news.id, {'cover_image_id': newCoverImageId});
        }

        emit(const NewsOperationSuccess('News created successfully'));
        add(const GetNewsEvent());
      },
    );
  }

  Future<void> _onUpdateNews(
      UpdateNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final newsData = Map<String, dynamic>.from(event.newsData);
    final List<XFile> images =
        (newsData['images'] as List<dynamic>?)?.cast<XFile>() ?? [];
    final int? coverImageIndex = newsData['cover_image_index'];

    // Remove images and cover_image_index from metadata payload
    newsData.remove('images');
    newsData.remove('cover_image_index');

    // 1. Update News Metadata (including deleted_images and existing cover_image_id)
    final result = await updateNews(event.id, newsData);

    await result.fold(
      (failure) async => emit(const NewsError('Failed to update news')),
      (news) async {
        // 2. Upload New Images
        String? newCoverImageId;
        for (int i = 0; i < images.length; i++) {
          final uploadResult = await uploadNewsImage(
              UploadNewsImageParams(id: news.id, image: images[i]));

          if (coverImageIndex == i) {
            uploadResult.fold(
              (l) => null,
              (img) => newCoverImageId = img.id,
            );
          }
        }

        // 3. Set Cover Image if it was a new image
        if (newCoverImageId != null) {
          await updateNews(news.id, {'cover_image_id': newCoverImageId});
        }

        emit(const NewsOperationSuccess('News updated successfully'));
        add(const GetNewsEvent());
      },
    );
  }

  Future<void> _onDeleteNews(
      DeleteNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await deleteNews(event.id);
    result.fold(
      (failure) => emit(const NewsError('Failed to delete news')),
      (_) {
        emit(const NewsOperationSuccess('News deleted successfully'));
        add(const GetNewsEvent());
      },
    );
  }

  Future<void> _onApproveNews(
      ApproveNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await approveNews(event.id, event.statusData);
    result.fold(
      (failure) => emit(const NewsError('Failed to approve news')),
      (_) {
        emit(const NewsOperationSuccess('News approved successfully'));
        add(const GetNewsEvent());
      },
    );
  }
}
