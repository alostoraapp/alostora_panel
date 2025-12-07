import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/constants/app_icons.dart';
import 'package:alostora/injection_container.dart';
import 'package:alostora/core/l10n/s.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/presentation/bloc/news_bloc.dart';
import 'package:alostora/features/news/presentation/bloc/news_event.dart';
import 'package:alostora/features/news/presentation/bloc/news_state.dart';
import 'package:alostora/core/presentation/widgets/error_view.dart';
import 'package:alostora/features/news/presentation/screens/news_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  void _navigateToEditScreen(BuildContext context, NewsEntity? news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsEditScreen(
          news: news,
          newsBloc: context.read<NewsBloc>(),
        ),
      ),
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
            return Scaffold(
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
                                  context
                                      .read<NewsBloc>()
                                      .add(const GetNewsEvent());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: theme.colorScheme.outline
                                            .withOpacity(0.5)),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
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
                                color:
                                    theme.colorScheme.outline.withOpacity(0.1)),
                          ),
                          child: InkWell(
                            onTap: () =>
                                _navigateToEditScreen(context, newsItem),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  color: theme.colorScheme
                                                      .surfaceContainerHighest,
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      color: theme.colorScheme
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
                                            newsItem.title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          if (newsItem
                                              .titleTranslations.isNotEmpty)
                                            Text(
                                              newsItem
                                                  .titleTranslations.first.text,
                                              style: TextStyle(
                                                  color: theme.textTheme
                                                      .bodyMedium?.color
                                                      ?.withOpacity(0.7),
                                                  fontSize: 14),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              if (newsItem.priority == 'urgent')
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
                ],
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
