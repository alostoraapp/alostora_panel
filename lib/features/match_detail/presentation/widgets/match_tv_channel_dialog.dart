import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/tv_channel_entity.dart';
import '../bloc/match_tv_channels/match_tv_channels_bloc.dart';
import '../bloc/match_tv_channels/match_tv_channels_event.dart';
import '../bloc/match_tv_channels/match_tv_channels_state.dart';
import 'tv_channel_dropdown.dart';

class MatchTvChannelDialog extends StatefulWidget {
  final String matchId;

  const MatchTvChannelDialog({
    super.key,
    required this.matchId,
  });

  @override
  State<MatchTvChannelDialog> createState() => _MatchTvChannelDialogState();
}

class _MatchTvChannelDialogState extends State<MatchTvChannelDialog> {
  TvChannelEntity? _selectedTvChannel;

  void _save() {
    if (_selectedTvChannel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).pleaseSelectTvChannel)),
      );
      return;
    }

    context.read<MatchTvChannelsBloc>().add(
          AddTvChannelToMatchEvent(
            matchId: widget.matchId,
            tvChannelId: _selectedTvChannel!.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MatchTvChannelsBloc, MatchTvChannelsState>(
      listener: (context, state) {
        if (state is MatchTvChannelsOperationSuccess) {
          Navigator.of(context).pop();
        } else if (state is MatchTvChannelsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AlertDialog(
        title: Text(S
            .of(context)
            .addBroadcast), // Reusing addBroadcast or addMedia? Let's check S.
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TvChannelSearchDropdown(
                onSelected: (channel) {
                  setState(() {
                    _selectedTvChannel = channel;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: _save,
            child: Text(S.of(context).save),
          ),
        ],
      ),
    );
  }
}
