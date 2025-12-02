import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../../../injection_container.dart';
import '../bloc/match_tv_channels/match_tv_channels_bloc.dart';
import '../bloc/match_tv_channels/match_tv_channels_event.dart';
import '../bloc/match_tv_channels/match_tv_channels_state.dart';
import 'match_tv_channel_dialog.dart';

class TvChannelsTab extends StatefulWidget {
  final String matchId;

  const TvChannelsTab({super.key, required this.matchId});

  @override
  State<TvChannelsTab> createState() => _TvChannelsTabState();
}

class _TvChannelsTabState extends State<TvChannelsTab> {
  late MatchTvChannelsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = sl<MatchTvChannelsBloc>();
    _bloc.add(GetMatchTvChannelsEvent(matchId: widget.matchId));
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
      child: BlocBuilder<MatchTvChannelsBloc, MatchTvChannelsState>(
        builder: (context, state) {
          if (state is MatchTvChannelsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchTvChannelsError) {
            return Center(child: Text(state.message));
          } else if (state is MatchTvChannelsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.tvChannels,
                        style: theme.textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 38.0,
                            height: 38.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _bloc.add(GetMatchTvChannelsEvent(
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
                                  builder: (context) => BlocProvider.value(
                                    value: _bloc,
                                    child: MatchTvChannelDialog(
                                      matchId: widget.matchId,
                                    ),
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
                    itemCount: state.tvChannels.length,
                    itemBuilder: (context, index) {
                      final matchTvChannel = state.tvChannels[index];
                      final channel = matchTvChannel.tvChannel;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                              color:
                                  theme.colorScheme.outline.withOpacity(0.1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: channel.logo,
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
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      channel.name,
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        if (channel.country != null) ...[
                                          CachedNetworkImage(
                                            imageUrl: channel.country!.logo,
                                            width: 16,
                                            height: 12,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const SizedBox.shrink(),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            channel.country!.name,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ],
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
                                      title: Text(s.deleteTvChannel),
                                      content:
                                          Text(s.deleteTvChannelConfirmation),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(s.cancel),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _bloc.add(
                                                DeleteTvChannelFromMatchEvent(
                                              matchId: widget.matchId,
                                              itemId: matchTvChannel.id,
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
