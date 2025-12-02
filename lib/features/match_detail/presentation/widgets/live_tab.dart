import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/l10n/s.dart';
import '../../../../injection_container.dart';
import '../bloc/match_broadcasts/match_broadcasts_bloc.dart';
import '../bloc/match_broadcasts/match_broadcasts_event.dart';
import '../bloc/match_broadcasts/match_broadcasts_state.dart';
import 'broadcast_dialog.dart';

class LiveTab extends StatefulWidget {
  final String matchId;

  const LiveTab({super.key, required this.matchId});

  @override
  State<LiveTab> createState() => _LiveTabState();
}

class _LiveTabState extends State<LiveTab> {
  late MatchBroadcastsBloc _bloc;

  String _getPlatformName(AppLocalizations s, String key) {
    final choices = {
      'youtube': s.platformYouTube,
      'x': s.platformX,
      'facebook': s.platformFacebook,
      'official': s.platformOfficial,
      'other': s.platformOther,
    };
    return choices[key] ?? key;
  }

  @override
  void initState() {
    super.initState();
    _bloc = sl<MatchBroadcastsBloc>();
    _bloc.add(GetBroadcastsEvent(matchId: widget.matchId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<MatchBroadcastsBloc, MatchBroadcastsState>(
        builder: (context, state) {
          if (state is MatchBroadcastsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchBroadcastsError) {
            return Center(child: Text(state.message));
          } else if (state is MatchBroadcastsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.live,
                        style: theme.textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 38.0,
                            height: 38.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _bloc.add(GetBroadcastsEvent(
                                    matchId: widget.matchId));
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
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => BroadcastDialog(
                                    matchId: widget.matchId,
                                    matchBroadcastsBloc: _bloc,
                                  ),
                                );
                              },
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
                    itemCount: state.broadcasts.length,
                    itemBuilder: (context, index) {
                      final broadcast = state.broadcasts[index];
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => BroadcastDialog(
                                matchId: widget.matchId,
                                broadcast: broadcast,
                                matchBroadcastsBloc: _bloc,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: broadcast.tvChannel.logo,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 25,
                                    backgroundImage: imageProvider,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.tv),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        broadcast.tvChannel.name,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _getPlatformName(
                                            s, broadcast.platformName),
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        broadcast.url,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurface
                                              .withOpacity(0.6),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(s.deleteBroadcast),
                                        content:
                                            Text(s.deleteBroadcastConfirmation),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(s.cancel),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _bloc.add(DeleteBroadcastEvent(
                                                matchId: widget.matchId,
                                                broadcastId: broadcast.id,
                                              ));
                                              Navigator.pop(context);
                                            },
                                            child: Text(s.delete),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
}
