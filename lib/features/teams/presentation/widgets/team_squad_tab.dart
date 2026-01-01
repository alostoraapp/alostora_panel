import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/app_icons.dart';

import '../../domain/entities/squad_entity.dart';
import '../bloc/team_detail_bloc.dart';
import 'team_detail_widgets.dart';

class TeamSquadTab extends StatefulWidget {
  final String teamId;

  const TeamSquadTab({super.key, required this.teamId});

  @override
  State<TeamSquadTab> createState() => _TeamSquadTabState();
}

class _TeamSquadTabState extends State<TeamSquadTab> {
  @override
  void initState() {
    super.initState();
    context.read<TeamDetailBloc>().add(GetSquadEvent(teamId: widget.teamId));
  }

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamDetailBloc, TeamDetailState>(
      builder: (context, state) {
        if (state is TeamDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TeamSquadLoaded) {
          return _buildSquadList(state.squad);
        } else if (state is TeamDetailError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        // Fallback for when state is TeamDetailLoaded but we want to show squad
        if (state is TeamDetailLoaded ||
            state is TeamDetailUpdated ||
            state is TeamDetailUpdating) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSquadList(List<SquadMemberEntity> squad) {
    // Filter squad based on search query
    final filteredSquad = squad.where((member) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();

      // Check shirt number
      if (member.shirtNumber.toString().contains(query)) return true;

      // Check names (name, short_name, display_name) in all languages
      bool checkLocalized(Map<String, String>? localizedMap) {
        if (localizedMap == null) return false;
        return localizedMap.values
            .any((value) => value.toLowerCase().contains(query));
      }

      if (checkLocalized(member.player.name)) return true;
      if (checkLocalized(member.player.shortName)) return true;
      if (checkLocalized(member.player.displayName)) return true;

      return false;
    }).toList();

    if (squad.isEmpty) {
      return const Center(child: Text('No players found.'));
    }

    // Map position codes to full names
    final positionNames = {
      'G': 'Goalkeeper',
      'D': 'Defender',
      'M': 'Midfielder',
      'F': 'Forward',
      'U': 'Unknown',
    };

    // Group by position
    final Map<String, List<SquadMemberEntity>> groupedSquad = {};
    for (var member in filteredSquad) {
      final position = member.position;
      if (!groupedSquad.containsKey(position)) {
        groupedSquad[position] = [];
      }
      groupedSquad[position]!.add(member);
    }

    // Define order based on codes
    final order = ['G', 'D', 'M', 'F', 'U'];
    final sortedKeys = groupedSquad.keys.toList()
      ..sort((a, b) {
        final indexA = order.indexOf(a);
        final indexB = order.indexOf(b);
        if (indexA != -1 && indexB != -1) return indexA.compareTo(indexB);
        if (indexA != -1) return -1;
        if (indexB != -1) return 1;
        return a.compareTo(b);
      });

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search players...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: filteredSquad.isEmpty
              ? const Center(child: Text('No players match your search.'))
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: sortedKeys.map((code) {
                      final title = positionNames[code] ?? code;
                      return PositionSection(
                        title: title,
                        players: groupedSquad[code]!,
                        onEdit: (member) => _showEditPlayerDialog(member),
                      );
                    }).toList(),
                  ),
                ),
        ),
      ],
    );
  }

  void _showEditPlayerDialog(SquadMemberEntity member) {
    final bloc = context.read<TeamDetailBloc>();
    showDialog(
      context: context,
      builder: (context) => PlayerEditDialog(
        member: member,
        onSave: (data) {
          // Structure data for API:
          // {
          //   "player": { "name": ..., "short_name": ..., "display_name": ... },
          //   "shirt_number": ...,
          //   "position": ...,
          //   "team_id": ...,
          //   "member_id": ...
          // }

          final playerData = <String, dynamic>{};

          if (data.containsKey('name')) {
            final nameMap = Map<String, dynamic>.from(data['name']);
            if (nameMap.isNotEmpty && !mapEquals(nameMap, member.player.name)) {
              playerData['name'] = nameMap;
            }
          }

          if (data.containsKey('short_name')) {
            final shortNameMap = Map<String, dynamic>.from(data['short_name']);
            if (shortNameMap.isNotEmpty &&
                !mapEquals(shortNameMap, member.player.shortName)) {
              playerData['short_name'] = shortNameMap;
            }
          }

          if (data.containsKey('display_name')) {
            final displayNameMap =
                Map<String, dynamic>.from(data['display_name']);
            if (displayNameMap.isNotEmpty &&
                !mapEquals(displayNameMap, member.player.displayName)) {
              playerData['display_name'] = displayNameMap;
            }
          }

          if (playerData.isEmpty) return;

          final updateData = <String, dynamic>{
            'player': playerData,
            'team_id': widget.teamId,
            'member_id': member.id,
          };

          bloc.add(UpdatePlayerEvent(
            teamId: widget.teamId,
            playerId: member.player.id,
            body: updateData,
          ));
        },
      ),
    );
  }
}

class PositionSection extends StatefulWidget {
  final String title;
  final List<SquadMemberEntity> players;
  final Function(SquadMemberEntity) onEdit;

  const PositionSection({
    super.key,
    required this.title,
    required this.players,
    required this.onEdit,
  });

  @override
  State<PositionSection> createState() => _PositionSectionState();
}

class _PositionSectionState extends State<PositionSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _heightFactor =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _toggle,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.players.length}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Spacer(),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _heightFactor,
          axisAlignment: -1.0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: SquadResponsiveGrid(
              children: widget.players
                  .map((member) =>
                      PlayerCard(member: member, onEdit: widget.onEdit))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class SquadResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  const SquadResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = 1;
        if (width > 2500) {
          crossAxisCount = 4;
        } else if (width > 900) {
          crossAxisCount = 3;
        }

        // Calculate item width
        final totalSpacing = (crossAxisCount - 1) * spacing;
        final itemWidth = (width - totalSpacing) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}

class PlayerCard extends StatelessWidget {
  final SquadMemberEntity member;
  final Function(SquadMemberEntity) onEdit;

  const PlayerCard({
    super.key,
    required this.member,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onEdit(member),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Image and Number
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(0.5),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: member.player.logo != null
                            ? NetworkImage(member.player.logo!)
                            : null,
                        child: member.player.logo == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${member.shirtNumber}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.player.name?['en'] ?? 'Unknown',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // IconButton removed as per user request
                ],
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabeledValue(label: 'Name', values: member.player.name),
                  LabeledValue(
                      label: 'Short Name', values: member.player.shortName),
                  LabeledValue(
                      label: 'Display Name', values: member.player.displayName),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerEditDialog extends StatefulWidget {
  final SquadMemberEntity member;
  final Function(Map<String, dynamic>) onSave;

  const PlayerEditDialog({
    super.key,
    required this.member,
    required this.onSave,
  });

  @override
  State<PlayerEditDialog> createState() => _PlayerEditDialogState();
}

class _PlayerEditDialogState extends State<PlayerEditDialog>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _languages = [];
  final Map<String, TextEditingController> _nameControllers = {};
  final Map<String, TextEditingController> _shortNameControllers = {};
  final Map<String, TextEditingController> _displayNameControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeLanguages();
    _tabController = TabController(length: _languages.length, vsync: this);
  }

  void _initializeLanguages() {
    final nameKeys = widget.member.player.name?.keys.toList() ?? [];
    final shortNameKeys = widget.member.player.shortName?.keys.toList() ?? [];
    final displayNameKeys =
        widget.member.player.displayName?.keys.toList() ?? [];

    final allKeys = {...nameKeys, ...shortNameKeys, ...displayNameKeys};
    if (allKeys.isEmpty) {
      _languages.add('en');
    } else {
      _languages.addAll(allKeys);
      if (!_languages.contains('en')) _languages.add('en');
    }

    for (var lang in _languages) {
      _nameControllers[lang] =
          TextEditingController(text: widget.member.player.name?[lang] ?? '');
      _shortNameControllers[lang] = TextEditingController(
          text: widget.member.player.shortName?[lang] ?? '');
      _displayNameControllers[lang] = TextEditingController(
          text: widget.member.player.displayName?[lang] ?? '');
    }
  }

  void _addLanguage(String lang) {
    if (!_languages.contains(lang)) {
      setState(() {
        _languages.add(lang);
        _nameControllers[lang] = TextEditingController();
        _shortNameControllers[lang] = TextEditingController();
        _displayNameControllers[lang] = TextEditingController();
        _tabController.dispose();
        _tabController = TabController(length: _languages.length, vsync: this);
        _tabController.animateTo(_languages.length - 1);
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _nameControllers.values) {
      controller.dispose();
    }
    for (var controller in _shortNameControllers.values) {
      controller.dispose();
    }
    for (var controller in _displayNameControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _getLanguageFlagPath(String code) {
    switch (code) {
      case 'en':
        return AppIcons.flagUK;
      case 'ar':
        return AppIcons.flagSA;
      case 'fa':
        return AppIcons.flagIR;
      case 'fr':
        return AppIcons.flagFR;
      case 'es':
        return AppIcons.flagES;
      case 'de':
        return AppIcons.flagDE;
      case 'it':
        return AppIcons.flagIT;
      default:
        return null;
    }
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      case 'fa':
        return 'فارسی';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      case 'de':
        return 'Deutsch';
      case 'it':
        return 'Italiano';
      default:
        return code.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(0.5),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit Player Info',
                      style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Language Tabs
                      Row(
                        children: [
                          Expanded(
                            child: TabBar(
                              controller: _tabController,
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              tabs: _languages.map((lang) {
                                final flagPath = _getLanguageFlagPath(lang);
                                return Tab(
                                  child: flagPath != null
                                      ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle),
                                          clipBehavior: Clip.antiAlias,
                                          child: SvgPicture.asset(flagPath,
                                              fit: BoxFit.cover),
                                        )
                                      : Text(lang.toUpperCase()),
                                );
                              }).toList(),
                              labelColor: Theme.of(context).colorScheme.primary,
                              unselectedLabelColor: Colors.grey,
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.add),
                            tooltip: 'Add Language',
                            onSelected: _addLanguage,
                            itemBuilder: (context) {
                              final availableLanguages = [
                                'ar',
                                'fa',
                                'fr',
                                'es',
                                'de',
                                'it'
                              ];
                              return availableLanguages.map((code) {
                                final flagPath = _getLanguageFlagPath(code);
                                return PopupMenuItem<String>(
                                  value: code,
                                  child: ListTile(
                                    leading: flagPath != null
                                        ? Container(
                                            width: 32,
                                            height: 32,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle),
                                            clipBehavior: Clip.antiAlias,
                                            child: SvgPicture.asset(flagPath,
                                                fit: BoxFit.cover),
                                          )
                                        : Text(code.toUpperCase(),
                                            style:
                                                const TextStyle(fontSize: 24)),
                                    title: Text(_getLanguageName(code)),
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Fields
                      AnimatedBuilder(
                        animation: _tabController,
                        builder: (context, child) {
                          final index = _tabController.index;
                          if (index < 0 || index >= _languages.length) {
                            return const SizedBox();
                          }
                          final lang = _languages[index];
                          return Column(
                            children: [
                              TextFormField(
                                controller: _nameControllers[lang],
                                decoration:
                                    const InputDecoration(labelText: 'Name'),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _shortNameControllers[lang],
                                decoration: const InputDecoration(
                                    labelText: 'Short Name'),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _displayNameControllers[lang],
                                decoration: const InputDecoration(
                                    labelText: 'Display Name'),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(0.5),
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      final Map<String, dynamic> data = {
                        'name': {},
                        'short_name': {},
                        'display_name': {},
                      };

                      for (var lang in _languages) {
                        if (_nameControllers[lang]?.text.isNotEmpty == true) {
                          data['name'][lang] = _nameControllers[lang]!.text;
                        }
                        if (_shortNameControllers[lang]?.text.isNotEmpty ==
                            true) {
                          data['short_name'][lang] =
                              _shortNameControllers[lang]!.text;
                        }
                        if (_displayNameControllers[lang]?.text.isNotEmpty ==
                            true) {
                          data['display_name'][lang] =
                              _displayNameControllers[lang]!.text;
                        }
                      }

                      widget.onSave(data);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
