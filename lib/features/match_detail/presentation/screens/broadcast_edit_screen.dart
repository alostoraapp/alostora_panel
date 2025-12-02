import 'package:flutter/material.dart';

import '../../domain/entities/broadcast_entity.dart';
import '../../domain/entities/tv_channel_entity.dart';
import '../bloc/match_broadcasts/match_broadcasts_bloc.dart';
import '../bloc/match_broadcasts/match_broadcasts_event.dart';
import '../widgets/tv_channel_search_delegate.dart';

class BroadcastEditScreen extends StatefulWidget {
  final String matchId;
  final BroadcastEntity? broadcast;
  final MatchBroadcastsBloc matchBroadcastsBloc;

  const BroadcastEditScreen({
    super.key,
    required this.matchId,
    this.broadcast,
    required this.matchBroadcastsBloc,
  });

  @override
  State<BroadcastEditScreen> createState() => _BroadcastEditScreenState();
}

class _BroadcastEditScreenState extends State<BroadcastEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _platformNameController;
  late TextEditingController _urlController;
  TvChannelEntity? _selectedTvChannel;

  @override
  void initState() {
    super.initState();
    _platformNameController =
        TextEditingController(text: widget.broadcast?.platformName ?? '');
    _urlController = TextEditingController(text: widget.broadcast?.url ?? '');
    _selectedTvChannel = widget.broadcast?.tvChannel;
  }

  @override
  void dispose() {
    _platformNameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      if (_selectedTvChannel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a TV Channel')),
        );
        return;
      }

      final params = {
        'platform_name': _platformNameController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.broadcast == null ? 'Add Broadcast' : 'Edit Broadcast'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _platformNameController,
                decoration: const InputDecoration(labelText: 'Platform Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter platform name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_selectedTvChannel?.name ?? 'Select TV Channel'),
                subtitle: _selectedTvChannel != null
                    ? Text(_selectedTvChannel!.country.name)
                    : null,
                leading: _selectedTvChannel?.logo.isNotEmpty == true
                    ? Image.network(
                        _selectedTvChannel!.logo,
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.tv),
                      )
                    : const Icon(Icons.tv),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  final result = await showSearch<TvChannelEntity?>(
                    context: context,
                    delegate: TvChannelSearchDelegate(),
                  );
                  if (result != null) {
                    setState(() {
                      _selectedTvChannel = result;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
