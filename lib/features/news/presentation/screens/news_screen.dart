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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<NewsBloc>().add(const GetNewsEvent()),
            );
          } else if (state is NewsLoaded) {
            final activeLanguage =
                context.read<LanguageCubit>().state.languageCode;
            int initialIndex = 0;
            if (state.selectedCategoryId != null) {
              final index = state.categories
                  .indexWhere((c) => c.id == state.selectedCategoryId);
              if (index != -1) {
                initialIndex = index + 1;
              }
            }
            return DefaultTabController(
              length: state.categories.length + 1,
              initialIndex: initialIndex,
              child: Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            s.news,
                            style: theme.textTheme.titleLarge,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 38.0,
                                height: 38.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<NewsBloc>().add(GetNewsEvent(
                                        categoryId: state.selectedCategoryId));
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
                              const SizedBox(width: 12),
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
                          if (state.selectedCategoryId != null) {
                            context
                                .read<NewsBloc>()
                                .add(const GetNewsEvent(categoryId: null));
                          }
                        } else {
                          final category = state.categories[index - 1];
                          if (state.selectedCategoryId != category.id) {
                            context
                                .read<NewsBloc>()
                                .add(GetNewsEvent(categoryId: category.id));
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
                        ...state.categories.map(
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
                                  categoryId: currentState.selectedCategoryId));
                            }
                          }
                          return false;
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.isLoadingMore
                              ? state.news.length + 1
                              : state.news.length,
                          itemBuilder: (context, index) {
                            if (index >= state.news.length) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                            final newsItem = state.news[index];
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
                                        width: 140,
                                        height: 110,
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
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
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
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                                maxLines: 2,
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
                                                          right: 8.0),
                                                      child: Icon(
                                                          Icons
                                                              .notifications_active,
                                                          color: Colors.red,
                                                          size: 16),
                                                    ),
                                                  if (newsItem.isPinned)
                                                    const Icon(Icons.push_pin,
                                                        size: 16,
                                                        color: Colors.blue),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
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
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        );
      case 'pending_approval':
        return const Icon(Icons.pending_actions, color: Colors.orange);
      case 'published':
        return Icon(Icons.check_circle, color: theme.colorScheme.primary);
      default:
        return const SizedBox.shrink();
    }
  }
}
