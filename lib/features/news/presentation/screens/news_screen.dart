import 'dart:async';
import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/config/app_colors.dart';
import 'package:alostora/core/constants/app_icons.dart';
import 'package:alostora/injection_container.dart';
import 'package:alostora/core/l10n/s.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/presentation/bloc/news_bloc.dart';
import 'package:alostora/features/news/presentation/bloc/news_event.dart';
import 'package:alostora/features/news/presentation/bloc/news_state.dart';
import 'package:alostora/core/presentation/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:alostora/core/presentation/cubit/language_cubit.dart';
import '../../../../app_router.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      final newsBloc = context.read<NewsBloc>();
      final currentState = newsBloc.state;
      String? categoryId;
      if (currentState is NewsLoaded) {
        categoryId = currentState.selectedCategoryId;
      }
      newsBloc.add(GetNewsEvent(
        categoryId: categoryId,
        search: _searchController.text,
      ));
    });
  }

  void _navigateToEditScreen(BuildContext context, NewsEntity? news) {
    context.pushNamed(
      AppRoutes.newsEdit,
      extra: {
        'news': news,
        'newsBloc': context.read<NewsBloc>(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return BlocProvider(
      create: (context) => sl<NewsBloc>()..add(const GetNewsEvent()),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading && state is! NewsLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsError && state is! NewsLoaded) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<NewsBloc>().add(const GetNewsEvent()),
            );
          } else if (state is NewsLoaded ||
              (state is NewsLoading &&
                  context.read<NewsBloc>().state is NewsLoaded)) {
            final currentState = state is NewsLoaded
                ? state
                : (context.read<NewsBloc>().state as NewsLoaded);
            final activeLanguage =
                context.read<LanguageCubit>().state.languageCode;
            int initialIndex = 0;
            if (currentState.selectedCategoryId != null) {
              final index = currentState.categories
                  .indexWhere((c) => c.id == currentState.selectedCategoryId);
              if (index != -1) {
                initialIndex = index + 1;
              }
            }
            return DefaultTabController(
              length: currentState.categories.length + 1,
              initialIndex: initialIndex,
              child: Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            s.news,
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: theme.colorScheme.outline
                                      .withOpacity(0.5),
                                ),
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: s.search,
                                  prefixIcon: Icon(Icons.search,
                                      size: 20,
                                      color:
                                          theme.colorScheme.onSurfaceVariant),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                                style: theme.textTheme.bodyMedium,
                                onSubmitted: (value) {
                                  context.read<NewsBloc>().add(GetNewsEvent(
                                      categoryId:
                                          currentState.selectedCategoryId,
                                      search: value));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: 38.0,
                                height: 38.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<NewsBloc>().add(GetNewsEvent(
                                        categoryId:
                                            currentState.selectedCategoryId,
                                        search: _searchController.text));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: theme.colorScheme.outline
                                              .withOpacity(0.5)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    elevation: 0,
                                  ),
                                  child: Icon(
                                    Icons.refresh,
                                    size: 20,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 38.0,
                                height: 38.0,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _navigateToEditScreen(context, null),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  ),
                                  child: SvgPicture.asset(
                                    AppIcons.add,
                                    width: 24,
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                      theme.colorScheme.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      onTap: (index) {
                        if (index == 0) {
                          if (currentState.selectedCategoryId != null) {
                            context.read<NewsBloc>().add(GetNewsEvent(
                                categoryId: null,
                                search: _searchController.text));
                          }
                        } else {
                          final category = currentState.categories[index - 1];
                          if (currentState.selectedCategoryId != category.id) {
                            context.read<NewsBloc>().add(GetNewsEvent(
                                categoryId: category.id,
                                search: _searchController.text));
                          }
                        }
                      },
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      splashBorderRadius: BorderRadius.circular(12),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColors.kPrimary600,
                      indicatorWeight: 2.0,
                      dividerColor: theme.colorScheme.outline,
                      unselectedLabelColor: theme.colorScheme.onTertiary,
                      tabs: [
                        const Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('All'),
                          ),
                        ),
                        ...currentState.categories.map(
                          (category) => Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(category.title[activeLanguage] ??
                                  category.title['en'] ??
                                  ''),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                              (scrollInfo.metrics.maxScrollExtent * 0.6)) {
                            final newsBloc = context.read<NewsBloc>();
                            final currentState = newsBloc.state;
                            if (currentState is NewsLoaded &&
                                !currentState.hasReachedMax &&
                                !currentState.isLoadingMore) {
                              newsBloc.add(GetNewsEvent(
                                  offset: currentState.news.length,
                                  categoryId: currentState.selectedCategoryId,
                                  search: _searchController.text));
                            }
                          }
                          return false;
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: currentState.isLoadingMore
                              ? currentState.news.length + 1
                              : currentState.news.length,
                          itemBuilder: (context, index) {
                            if (index >= currentState.news.length) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                            final newsItem = currentState.news[index];
                            final coverImage = newsItem.images.firstWhere(
                                (img) => img.order == 'cover',
                                orElse: () => newsItem.images.isNotEmpty
                                    ? newsItem.images.first
                                    : const NewsImageEntity(
                                        id: '',
                                        image: '',
                                        order: '',
                                        sourceUrl: '',
                                        createdAt: ''));

                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: theme.colorScheme.outline
                                        .withOpacity(0.1)),
                              ),
                              child: InkWell(
                                onTap: () =>
                                    _navigateToEditScreen(context, newsItem),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Cover Image
                                      SizedBox(
                                        width: 110,
                                        height: 85,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            coverImage.image.isNotEmpty
                                                ? Image.network(
                                                    coverImage.image
                                                            .startsWith('http')
                                                        ? coverImage.image
                                                        : '${AppConstants.baseUrl}${coverImage.image}',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Container(
                                                      color: theme.colorScheme
                                                          .surfaceContainerHighest,
                                                      child: Icon(
                                                          Icons.broken_image,
                                                          color: theme
                                                              .colorScheme
                                                              .onSurfaceVariant),
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      color: theme.colorScheme
                                                          .surfaceContainerHighest,
                                                    ),
                                                    child: Icon(Icons.image,
                                                        color: theme.colorScheme
                                                            .onSurfaceVariant),
                                                  ),
                                            if (newsItem.categoryDetails !=
                                                null)
                                              Positioned(
                                                bottom: 6,
                                                left: 6,
                                                right: 6,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.65),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Text(
                                                    newsItem.categoryDetails!
                                                                .title[
                                                            context
                                                                .read<
                                                                    LanguageCubit>()
                                                                .state
                                                                .languageCode] ??
                                                        newsItem
                                                            .categoryDetails!
                                                            .title['en'] ??
                                                        '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 8, 4, 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newsItem.title[context
                                                        .read<LanguageCubit>()
                                                        .state
                                                        .languageCode] ??
                                                    newsItem.title['en'] ??
                                                    '',
                                                style: theme
                                                    .textTheme.titleSmall
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  if (newsItem.priority ==
                                                      'urgent')
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 6.0),
                                                      child: Icon(
                                                          Icons
                                                              .notifications_active,
                                                          color: Colors.red,
                                                          size: 16),
                                                    ),
                                                  if (newsItem.isPinned)
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 6.0),
                                                      child: Icon(
                                                          Icons.push_pin,
                                                          size: 16,
                                                          color: Colors.blue),
                                                    ),
                                                  if (newsItem.isLive)
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 6.0),
                                                      child: Icon(Icons.live_tv,
                                                          size: 16,
                                                          color: Colors.red),
                                                    ),
                                                  if (newsItem.relatedMatch !=
                                                          null &&
                                                      newsItem.relatedMatch!
                                                          .isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 6.0),
                                                      child: Icon(
                                                          Icons.sports_soccer,
                                                          size: 16,
                                                          color: theme
                                                              .colorScheme
                                                              .primary),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, left: 4.0),
                                        child: Center(
                                          child: _buildStatusIndicator(
                                              context, newsItem.status),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context, String status) {
    final theme = Theme.of(context);
    switch (status) {
      case 'draft':
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        );
      case 'pending_approval':
        return const Icon(Icons.pending_actions,
            color: Colors.orange, size: 20);
      case 'published':
        return Icon(Icons.check_circle,
            color: theme.colorScheme.primary, size: 20);
      default:
        return const SizedBox.shrink();
    }
  }
}
