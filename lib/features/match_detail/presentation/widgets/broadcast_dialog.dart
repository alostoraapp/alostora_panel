import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/broadcast_entity.dart';
import '../../domain/entities/tv_channel_entity.dart';
import '../bloc/match_broadcasts/match_broadcasts_bloc.dart';
import '../bloc/match_broadcasts/match_broadcasts_event.dart';
import 'tv_channel_dropdown.dart';

class BroadcastDialog extends StatefulWidget {
  final String matchId;
  final BroadcastEntity? broadcast;
  final MatchBroadcastsBloc matchBroadcastsBloc;

  const BroadcastDialog({
    super.key,
    required this.matchId,
    this.broadcast,
    required this.matchBroadcastsBloc,
  });

  @override
  State<BroadcastDialog> createState() => _BroadcastDialogState();
}

class _BroadcastDialogState extends State<BroadcastDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _urlController;
  String? _selectedPlatform;
  TvChannelEntity? _selectedTvChannel;

  Map<String, String> _getPlatformChoices(AppLocalizations s) {
    return {
      'youtube': s.platformYouTube,
      'x': s.platformX,
      'facebook': s.platformFacebook,
      'official': s.platformOfficial,
      'other': s.platformOther,
    };
  }

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.broadcast?.url ?? '');
    _selectedPlatform = widget.broadcast?.platformName;
    _selectedTvChannel = widget.broadcast?.tvChannel;
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _save() {
    final s = S.of(context);
    if (_formKey.currentState!.validate()) {
      if (_selectedTvChannel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.pleaseSelectTvChannel)),
        );
        return;
      }
      if (_selectedPlatform == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.pleaseSelectPlatform)),
        );
        return;
      }

      final params = {
        'platform_name': _selectedPlatform,
        'url': _urlController.text,
        'tv_channel': _selectedTvChannel!.id,
      };

      if (widget.broadcast == null) {
        widget.matchBroadcastsBloc.add(CreateBroadcastEvent(
          matchId: widget.matchId,
          params: params,
        ));
      } else {
        widget.matchBroadcastsBloc.add(UpdateBroadcastEvent(
          matchId: widget.matchId,
          broadcastId: widget.broadcast!.id,
          params: params,
        ));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final platformChoices = _getPlatformChoices(s);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.broadcast == null ? s.addBroadcast : s.editBroadcast,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),

              // Platform Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPlatform,
                decoration: InputDecoration(
                  labelText: s.platform,
                  border: const OutlineInputBorder(),
                ),
                items: platformChoices.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPlatform = value;
                  });
                },
                validator: (value) =>
                    value == null ? s.pleaseSelectPlatform : null,
              ),
              const SizedBox(height: 16),

              // TV Channel Searchable Dropdown
              TvChannelSearchDropdown(
                initialSelection: _selectedTvChannel,
                onSelected: (TvChannelEntity? channel) {
                  setState(() {
                    _selectedTvChannel = channel;
                  });
                },
              ),
              const SizedBox(height: 16),

              // URL Field
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: s.url,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return s.pleaseEnterUrl;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(s.cancel),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _save,
                    child: Text(s.save),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
