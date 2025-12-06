import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alostora/features/news/domain/usecases/get_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/create_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/update_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/delete_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/approve_news_usecase.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNews;
  final CreateNewsUseCase createNews;
  final UpdateNewsUseCase updateNews;
  final DeleteNewsUseCase deleteNews;
  final ApproveNewsUseCase approveNews;

  NewsBloc({
    required this.getNews,
    required this.createNews,
    required this.updateNews,
    required this.deleteNews,
    required this.approveNews,
  }) : super(NewsInitial()) {
    on<GetNewsEvent>(_onGetNews);
    on<CreateNewsEvent>(_onCreateNews);
    on<UpdateNewsEvent>(_onUpdateNews);
    on<DeleteNewsEvent>(_onDeleteNews);
    on<ApproveNewsEvent>(_onApproveNews);
  }

  Future<void> _onGetNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await getNews(limit: event.limit, offset: event.offset);
    result.fold(
      (failure) => emit(const NewsError('Failed to fetch news')),
      (news) => emit(NewsLoaded(news)),
    );
  }

  Future<void> _onCreateNews(
      CreateNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await createNews(event.newsData);
    result.fold(
      (failure) => emit(const NewsError('Failed to create news')),
      (news) {
        emit(const NewsOperationSuccess('News created successfully'));
        add(const GetNewsEvent());
      },
    );
  }

  Future<void> _onUpdateNews(
      UpdateNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await updateNews(event.id, event.newsData);
    result.fold(
      (failure) => emit(const NewsError('Failed to update news')),
      (news) {
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
