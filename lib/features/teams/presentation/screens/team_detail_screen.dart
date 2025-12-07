import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/team_detail_entity.dart';
import '../bloc/team_detail_bloc.dart';

class TeamDetailScreen extends StatefulWidget {
  final String teamId;

  const TeamDetailScreen({super.key, required this.teamId});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen>
    with TickerProviderStateMixin {
  late TeamDetailBloc _bloc;
  late TabController _tabController;
  final List<String> _languages = ['en', 'ar'];
  final Map<String, TextEditingController> _nameControllers = {};
  final Map<String, TextEditingController> _shortNameControllers = {};
  final Map<String, TextEditingController> _displayNameControllers = {};

  @override
  void initState() {
    super.initState();
    _bloc = sl<TeamDetailBloc>()
      ..add(GetTeamDetailEvent(teamId: widget.teamId));
    _tabController = TabController(length: _languages.length, vsync: this);

    for (var lang in _languages) {
      _nameControllers[lang] = TextEditingController();
      _shortNameControllers[lang] = TextEditingController();
      _displayNameControllers[lang] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _tabController.dispose();
    for (var controller in _nameControllers.values) controller.dispose();
    for (var controller in _shortNameControllers.values) controller.dispose();
    for (var controller in _displayNameControllers.values) controller.dispose();
    super.dispose();
  }

  void _populateControllers(TeamDetailEntity team) {
    final Set<String> allLanguages = {'en', 'ar'}; // Default languages
    if (team.name != null) allLanguages.addAll(team.name!.keys);
    if (team.shortName != null) allLanguages.addAll(team.shortName!.keys);
    if (team.displayName != null) allLanguages.addAll(team.displayName!.keys);

    setState(() {
      _languages.clear();
      _languages.addAll(allLanguages);
      _tabController.dispose();
      _tabController = TabController(length: _languages.length, vsync: this);

      // Re-initialize controllers for new languages
      for (var lang in _languages) {
        if (!_nameControllers.containsKey(lang))
          _nameControllers[lang] = TextEditingController();
        if (!_shortNameControllers.containsKey(lang))
          _shortNameControllers[lang] = TextEditingController();
        if (!_displayNameControllers.containsKey(lang))
          _displayNameControllers[lang] = TextEditingController();
      }
    });

    for (var lang in _languages) {
      _nameControllers[lang]?.text = team.name?[lang] ?? '';
      _shortNameControllers[lang]?.text = team.shortName?[lang] ?? '';
      _displayNameControllers[lang]?.text = team.displayName?[lang] ?? '';
    }
  }

  void _saveTeam() {
    final Map<String, dynamic> nameMap = {};
    final Map<String, dynamic> shortNameMap = {};
    final Map<String, dynamic> displayNameMap = {};

    for (var lang in _languages) {
      if (_nameControllers[lang]?.text.isNotEmpty == true) {
        nameMap[lang] = _nameControllers[lang]!.text;
      }
      if (_shortNameControllers[lang]?.text.isNotEmpty == true) {
        shortNameMap[lang] = _shortNameControllers[lang]!.text;
      }
      if (_displayNameControllers[lang]?.text.isNotEmpty == true) {
        displayNameMap[lang] = _displayNameControllers[lang]!.text;
      }
    }

    final body = {
      if (nameMap.isNotEmpty) 'name': nameMap,
      if (shortNameMap.isNotEmpty) 'short_name': shortNameMap,
      if (displayNameMap.isNotEmpty) 'display_name': displayNameMap,
    };

    _bloc.add(UpdateTeamEvent(teamId: widget.teamId, body: body));
  }

  void _addLanguage(String lang) {
    if (!_languages.contains(lang)) {
      setState(() {
        _languages.add(lang);
        _tabController.dispose();
        _tabController = TabController(length: _languages.length, vsync: this);
        _tabController.animateTo(_languages.length - 1);

        _nameControllers[lang] = TextEditingController();
        _shortNameControllers[lang] = TextEditingController();
        _displayNameControllers[lang] = TextEditingController();
      });
    }
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final availableLanguages = ['ar', 'fa', 'fr', 'es', 'de', 'it'];
        return ListView(
          shrinkWrap: true,
          children: availableLanguages.map((code) {
            return ListTile(
              leading: Text(_getLanguageFlag(code).split(' ')[0],
                  style: const TextStyle(fontSize: 24)),
              title: Text(_getLanguageName(code)),
              onTap: () {
                Navigator.pop(context);
                _addLanguage(code);
              },
            );
          }).toList(),
        );
      },
    );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details'),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: FilledButton(
          //     onPressed: _saveTeam,
          //     style: FilledButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     child: const Text('Save'),
          //   ),
          // ),
        ],
      ),
      body: BlocConsumer<TeamDetailBloc, TeamDetailState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is TeamDetailLoaded) {
            _populateControllers(state.team);
          } else if (state is TeamDetailUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Team updated successfully')),
            );
            // Force populate to ensure UI reflects new data
            _populateControllers(state.team);
          } else if (state is TeamDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is TeamDetailUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is TeamDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TeamDetailLoaded ||
              state is TeamDetailUpdated ||
              state is TeamDetailUpdating) {
            final team = (state is TeamDetailLoaded)
                ? state.team
                : (state is TeamDetailUpdated)
                    ? state.team
                    : (state is TeamDetailUpdating &&
                            _bloc.state
                                is TeamDetailLoaded) // Optimistic? No, just keep showing loaded
                        ? (_bloc.state as TeamDetailLoaded).team
                        : null;

            if (team == null && state is TeamDetailUpdating) {
              // If we are updating but don't have the team yet (shouldn't happen if flow is correct), show loading
              return const Center(child: CircularProgressIndicator());
            }

            return _buildContent(
                team ?? (state is TeamDetailUpdated ? state.team : null));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // Helper to handle the nullable team in builder
  Widget _buildContent(TeamDetailEntity? team) {
    if (team == null) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(team),
          const SizedBox(height: 24),
          _buildLanguageTabs(),
          // No SizedBox here, padding is inside _buildEditFields
          _buildEditFields(),
          const SizedBox(height: 24),
          _buildDetailsSection(team),
        ],
      ),
    );
  }

  Widget _buildHeader(TeamDetailEntity team) {
    return Row(
      children: [
        if (team.logo != null)
          Image.network(
            team.logo!,
            width: 80,
            height: 80,
            errorBuilder: (_, __, ___) => const Icon(Icons.shield, size: 80),
          ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                team.name?['en'] ?? 'Unknown Team',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (team.foundationTime != null)
                Text('Founded: ${team.foundationTime}'),
              if (team.website != null) Text('Website: ${team.website}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageTabs() {
    return Row(
      children: [
        Expanded(
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _languages
                .map((lang) => Tab(text: _getLanguageFlag(lang)))
                .toList(),
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _showLanguagePicker,
          tooltip: 'Add Language',
        ),
      ],
    );
  }

  String _getLanguageFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸 English';
      case 'ar':
        return '🇸🇦 Arabic';
      case 'fa':
        return '🇮🇷 Persian';
      case 'fr':
        return '🇫🇷 French';
      case 'es':
        return '🇪🇸 Spanish';
      case 'de':
        return '🇩🇪 German';
      case 'it':
        return '🇮🇹 Italian';
      default:
        return code.toUpperCase();
    }
  }

  Widget _buildEditFields() {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, child) {
        final index = _tabController.index;
        // Ensure index is valid (during tab changes/rebuilds)
        if (index < 0 || index >= _languages.length) return const SizedBox();

        final lang = _languages[index];
        return Padding(
          padding: const EdgeInsets.only(
              top: 24.0), // Added top padding as requested
          child: Column(
            children: [
              TextFormField(
                controller: _nameControllers[lang],
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _shortNameControllers[lang],
                decoration: const InputDecoration(labelText: 'Short Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _displayNameControllers[lang],
                decoration: const InputDecoration(labelText: 'Display Name'),
                maxLength: 3,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailsSection(TeamDetailEntity team) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const Text('Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (team.marketValue != null)
          ListTile(
            title: const Text('Market Value'),
            subtitle:
                Text('${team.marketValue} ${team.marketValueCurrency ?? ""}'),
          ),
        if (team.country != null)
          ListTile(
            leading: team.country!.logo != null
                ? Image.network(team.country!.logo!, width: 24)
                : null,
            title: const Text('Country'),
            subtitle: Text(team.country!.name?['en'] ?? ''),
          ),
        if (team.venue != null)
          ListTile(
            title: const Text('Venue'),
            subtitle: Text(
                '${team.venue!.name?['en'] ?? ""} (${team.venue!.city ?? ""})'),
          ),
        if (team.coach != null)
          ListTile(
            leading: team.coach!.logo != null
                ? Image.network(team.coach!.logo!, width: 24)
                : null,
            title: const Text('Coach'),
            subtitle: Text(team.coach!.name?['en'] ?? ''),
          ),
        if (team.competition != null)
          ListTile(
            leading: team.competition!.logo != null
                ? Image.network(team.competition!.logo!, width: 24)
                : null,
            title: const Text('Competition'),
            subtitle: Text(team.competition!.name?['en'] ?? ''),
          ),
      ],
    );
  }
}
