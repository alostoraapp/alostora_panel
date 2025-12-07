import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/constants/app_icons.dart';
import 'package:alostora/injection_container.dart';
import 'package:alostora/core/l10n/s.dart';
import 'package:alostora/core/presentation/widgets/error_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alostora/features/match_detail/domain/entities/highlight_entity.dart';
import 'package:alostora/features/match_detail/presentation/bloc/match_highlights/match_highlights_bloc.dart';
import 'package:alostora/features/match_detail/presentation/bloc/match_highlights/match_highlights_event.dart';
import 'package:alostora/features/match_detail/presentation/bloc/match_highlights/match_highlights_state.dart';
import 'package:alostora/features/match_detail/presentation/screens/highlight_edit_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HighlightsTab extends StatelessWidget {
  final String matchId;

  const HighlightsTab({super.key, required this.matchId});

  void _navigateToEditScreen(BuildContext context, HighlightEntity? highlight) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HighlightEditScreen(
          matchId: matchId,
          highlight: highlight,
          matchHighlightsBloc: context.read<MatchHighlightsBloc>(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return BlocProvider(
      create: (context) =>
          sl<MatchHighlightsBloc>()..add(GetMatchHighlightsEvent(matchId)),
      child: BlocBuilder<MatchHighlightsBloc, MatchHighlightsState>(
        builder: (context, state) {
          if (state is MatchHighlightsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchHighlightsError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context
                  .read<MatchHighlightsBloc>()
                  .add(GetMatchHighlightsEvent(matchId)),
            );
          } else if (state is MatchHighlightsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.highlights,
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
                                    .read<MatchHighlightsBloc>()
                                    .add(GetMatchHighlightsEvent(matchId));
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
                    itemCount: state.highlights.length,
                    itemBuilder: (context, index) {
                      final highlight = state.highlights[index];
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
                              _navigateToEditScreen(context, highlight),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Cover Image with Video Time Overlay
                                SizedBox(
                                  width: 140,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      highlight.cover != null
                                          ? Image.network(
                                              highlight.cover!
                                                      .startsWith('http')
                                                  ? highlight.cover!
                                                  : '${AppConstants.baseUrl}${highlight.cover}',
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                    Icons.broken_image),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                              ),
                                              child: const Icon(Icons.videocam),
                                            ),
                                      if (highlight.videoTime != null)
                                        Positioned(
                                          bottom: 4,
                                          right: 4,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              _formatDuration(
                                                  highlight.videoTime!),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
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
                                          highlight.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        if (highlight
                                            .titleTranslations.isNotEmpty)
                                          Text(
                                            highlight
                                                .titleTranslations.first.text,
                                            style: TextStyle(
                                                color: theme
                                                    .textTheme.bodyMedium?.color
                                                    ?.withOpacity(0.7),
                                                fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme
                                                    .primaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                _getHighlightTypeLabel(
                                                    context, highlight.type),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: theme.colorScheme
                                                      .onPrimaryContainer,
                                                ),
                                              ),
                                            ),
                                            if (highlight.priority == 'urgent')
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Icon(
                                                    Icons.notifications_active,
                                                    color: Colors.red,
                                                    size: 16),
                                              ),
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
                                        context, highlight.status),
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
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _getHighlightTypeLabel(BuildContext context, String type) {
    final s = S.of(context);
    switch (type) {
      case 'summary':
        return s.highlightTypeSummary;
      case 'goals':
        return s.highlightTypeGoals;
      case 'full_match':
        return s.highlightTypeFullMatch;
      case 'penalties':
        return s.highlightTypePenalties;
      case 'celebration':
        return s.highlightTypeCelebration;
      case 'other':
        return s.highlightTypeOther;
      default:
        return type;
    }
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

  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
