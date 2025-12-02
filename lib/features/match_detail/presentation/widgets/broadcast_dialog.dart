import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/l10n/s.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/broadcast_entity.dart';
import '../../domain/entities/tv_channel_entity.dart';
import '../../domain/usecases/search_tv_channels_usecase.dart';
import '../bloc/match_broadcasts/match_broadcasts_bloc.dart';
import '../bloc/match_broadcasts/match_broadcasts_event.dart';

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
  final SearchTvChannelsUseCase _searchTvChannelsUseCase = sl();
  final TextEditingController _tvChannelSearchController =
      TextEditingController();
  List<TvChannelEntity> _tvChannelOptions = [];
  bool _isLoadingChannels = false;

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
    if (_selectedTvChannel != null) {
      _tvChannelSearchController.text = _selectedTvChannel!.name;
    }
    _tvChannelSearchController.addListener(_onSearchChanged);
    _loadTvChannels();
  }

  Timer? _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Only search if the text is different from the selected channel name
      // This prevents re-searching when selecting an item
      if (_selectedTvChannel == null ||
          _tvChannelSearchController.text != _selectedTvChannel!.name) {
        _loadTvChannels(_tvChannelSearchController.text);
      }
    });
  }

  Future<void> _loadTvChannels([String query = '']) async {
    setState(() {
      _isLoadingChannels = true;
    });
    final result = await _searchTvChannelsUseCase(
        SearchTvChannelsParams(query: query, page: 1));
    result.fold(
      (failure) => null, // Handle error if needed
      (channels) {
        setState(() {
          _tvChannelOptions = channels.take(5).toList();
          _isLoadingChannels = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _urlController.dispose();
    _tvChannelSearchController.removeListener(_onSearchChanged);
    _tvChannelSearchController.dispose();
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
        'tv_channel_id': _selectedTvChannel!.id,
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

  void _delete() {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.deleteBroadcast),
        content: Text(s.deleteBroadcastConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () {
              widget.matchBroadcastsBloc.add(DeleteBroadcastEvent(
                matchId: widget.matchId,
                broadcastId: widget.broadcast!.id,
              ));
              Navigator.pop(context); // Close confirmation dialog
              Navigator.pop(context); // Close edit dialog
            },
            child: Text(s.delete),
          ),
        ],
      ),
    );
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
              LayoutBuilder(
                builder: (context, constraints) {
                  return DropdownMenu<TvChannelEntity>(
                    width: constraints.maxWidth,
                    controller: _tvChannelSearchController,
                    enableFilter:
                        false, // Disable local filtering to use backend results
                    requestFocusOnTap: true,
                    trailingIcon: _isLoadingChannels
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : null,
                    leadingIcon: const Icon(Icons.search),
                    label: Text(s.tvChannel),
                    inputDecorationTheme: const InputDecorationTheme(
                      border: OutlineInputBorder(),
                    ),
                    initialSelection: _selectedTvChannel,
                    onSelected: (TvChannelEntity? channel) {
                      setState(() {
                        _selectedTvChannel = channel;
                      });
                    },
                    dropdownMenuEntries: _tvChannelOptions
                        .map<DropdownMenuEntry<TvChannelEntity>>(
                            (TvChannelEntity channel) {
                      return DropdownMenuEntry<TvChannelEntity>(
                        value: channel,
                        label: channel.name,
                        leadingIcon: channel.logo.isNotEmpty
                            ? Image.network(
                                channel.logo,
                                width: 24,
                                height: 24,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.tv, size: 24),
                              )
                            : const Icon(Icons.tv, size: 24),
                      );
                    }).toList(),
                  );
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.broadcast != null)
                    TextButton.icon(
                      onPressed: _delete,
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: Text(
                        s.delete,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
