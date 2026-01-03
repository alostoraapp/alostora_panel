import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/team_detail_entity.dart';
import '../bloc/team_detail_bloc.dart';
import '../widgets/team_detail_widgets.dart';
import '../widgets/team_squad_tab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/config/app_colors.dart';

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
  late TabController _mainTabController;
  final List<String> _languages = ['en', 'ar'];
  final Map<String, TextEditingController> _nameControllers = {};
  final Map<String, TextEditingController> _shortNameControllers = {};
  final Map<String, TextEditingController> _displayNameControllers = {};
  final Map<String, TextEditingController> _venueNameControllers = {};
  final Map<String, TextEditingController> _venueShortNameControllers = {};
  final Map<String, TextEditingController> _venueCityControllers = {};
  final TextEditingController _venueCapacityController =
      TextEditingController();
  final Map<String, TextEditingController> _coachNameControllers = {};
  final Map<String, TextEditingController> _coachShortNameControllers = {};

  String? _currentVenueId;
  String? _currentCoachId;

  @override
  void initState() {
    super.initState();
    _bloc = sl<TeamDetailBloc>()
      ..add(GetTeamDetailEvent(teamId: widget.teamId));
    _tabController = TabController(length: _languages.length, vsync: this);
    _mainTabController = TabController(length: 2, vsync: this);
    _initializeControllers();
  }

  void _initializeControllers() {
    for (var lang in _languages) {
      _nameControllers[lang] = TextEditingController();
      _shortNameControllers[lang] = TextEditingController();
      _displayNameControllers[lang] = TextEditingController();
      _venueNameControllers[lang] = TextEditingController();
      _venueShortNameControllers[lang] = TextEditingController();
      _venueCityControllers[lang] = TextEditingController();
      _coachNameControllers[lang] = TextEditingController();
      _coachShortNameControllers[lang] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _tabController.dispose();
    for (var controller in _nameControllers.values) controller.dispose();
    for (var controller in _shortNameControllers.values) controller.dispose();
    for (var controller in _displayNameControllers.values) controller.dispose();
    for (var controller in _venueNameControllers.values) controller.dispose();
    for (var controller in _venueShortNameControllers.values)
      controller.dispose();
    for (var controller in _venueCityControllers.values) controller.dispose();
    _venueCapacityController.dispose();
    for (var controller in _coachNameControllers.values) controller.dispose();
    for (var controller in _coachShortNameControllers.values)
      controller.dispose();
    super.dispose();
  }

  void _populateControllers(TeamDetailEntity team) {
    _currentVenueId = team.venue?.id;
    _currentCoachId = team.coach?.id;

    final Set<String> allLanguages = {'en', 'ar'}; // Default languages
    if (team.name != null) allLanguages.addAll(team.name!.keys);
    if (team.shortName != null) allLanguages.addAll(team.shortName!.keys);
    if (team.displayName != null) allLanguages.addAll(team.displayName!.keys);
    if (team.venue?.name != null) allLanguages.addAll(team.venue!.name!.keys);
    if (team.venue?.shortName != null)
      allLanguages.addAll(team.venue!.shortName!.keys);
    if (team.venue?.city != null) allLanguages.addAll(team.venue!.city!.keys);
    if (team.coach?.name != null) allLanguages.addAll(team.coach!.name!.keys);
    if (team.coach?.shortName != null)
      allLanguages.addAll(team.coach!.shortName!.keys);

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
        if (!_venueNameControllers.containsKey(lang))
          _venueNameControllers[lang] = TextEditingController();
        if (!_venueShortNameControllers.containsKey(lang))
          _venueShortNameControllers[lang] = TextEditingController();
        if (!_venueCityControllers.containsKey(lang))
          _venueCityControllers[lang] = TextEditingController();
        if (!_coachNameControllers.containsKey(lang))
          _coachNameControllers[lang] = TextEditingController();
        if (!_coachShortNameControllers.containsKey(lang))
          _coachShortNameControllers[lang] = TextEditingController();
      }
    });

    _venueCapacityController.text = team.venue?.capacity?.toString() ?? '';

    for (var lang in _languages) {
      _nameControllers[lang]?.text = team.name?[lang] ?? '';
      _shortNameControllers[lang]?.text = team.shortName?[lang] ?? '';
      _displayNameControllers[lang]?.text = team.displayName?[lang] ?? '';
      _venueNameControllers[lang]?.text = team.venue?.name?[lang] ?? '';
      _venueShortNameControllers[lang]?.text =
          team.venue?.shortName?[lang] ?? '';
      _venueCityControllers[lang]?.text = team.venue?.city?[lang] ?? '';
      _coachNameControllers[lang]?.text = team.coach?.name?[lang] ?? '';
      _coachShortNameControllers[lang]?.text =
          team.coach?.shortName?[lang] ?? '';
    }
  }

  TeamDetailEntity? get _currentTeam {
    final state = _bloc.state;
    if (state is TeamDetailLoaded) return state.team;
    if (state is TeamDetailUpdated) return state.team;
    if (state is TeamSquadLoaded) return state.team;
    if (state is TeamDetailUpdating) return state.team;
    if (state is TeamPlayerUpdated) return state.team;
    return null;
  }

  // Helper to ensure we compare apples to apples
  // Filter out empty strings from original maps because our form maps only include non-empty values
  Map<String, dynamic> _getCleanOriginal(Map<String, String>? original) {
    if (original == null) return {};
    return Map.fromEntries(
        original.entries.where((e) => e.value.trim().isNotEmpty));
  }

  void _saveTeam() {
    final team = _currentTeam;
    if (team == null) return;

    final Map<String, dynamic> nameMap = {};
    final Map<String, dynamic> shortNameMap = {};
    final Map<String, dynamic> displayNameMap = {};
    final Map<String, dynamic> venueNameMap = {};
    final Map<String, dynamic> venueShortNameMap = {};
    final Map<String, dynamic> venueCityMap = {};
    final Map<String, dynamic> coachNameMap = {};
    final Map<String, dynamic> coachShortNameMap = {};

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
      if (_venueNameControllers[lang]?.text.isNotEmpty == true) {
        venueNameMap[lang] = _venueNameControllers[lang]!.text;
      }
      if (_venueShortNameControllers[lang]?.text.isNotEmpty == true) {
        venueShortNameMap[lang] = _venueShortNameControllers[lang]!.text;
      }
      if (_venueCityControllers[lang]?.text.isNotEmpty == true) {
        venueCityMap[lang] = _venueCityControllers[lang]!.text;
      }
      if (_coachNameControllers[lang]?.text.isNotEmpty == true) {
        coachNameMap[lang] = _coachNameControllers[lang]!.text;
      }
      if (_coachShortNameControllers[lang]?.text.isNotEmpty == true) {
        coachShortNameMap[lang] = _coachShortNameControllers[lang]!.text;
      }
    }

    final int? capacity = int.tryParse(_venueCapacityController.text);

    final body = <String, dynamic>{};

    if (nameMap.isNotEmpty &&
        !mapEquals(nameMap, _getCleanOriginal(team.name))) {
      body['name'] = nameMap;
    }
    if (shortNameMap.isNotEmpty &&
        !mapEquals(shortNameMap, _getCleanOriginal(team.shortName))) {
      body['short_name'] = shortNameMap;
    }
    if (displayNameMap.isNotEmpty &&
        !mapEquals(displayNameMap, _getCleanOriginal(team.displayName))) {
      body['display_name'] = displayNameMap;
    }

    // Venue Logic (for combined update)
    final venueBody = <String, dynamic>{};
    if (venueNameMap.isNotEmpty &&
        !mapEquals(venueNameMap, _getCleanOriginal(team.venue?.name))) {
      venueBody['name'] = venueNameMap;
    }
    if (venueShortNameMap.isNotEmpty &&
        !mapEquals(
            venueShortNameMap, _getCleanOriginal(team.venue?.shortName))) {
      venueBody['short_name'] = venueShortNameMap;
    }
    if (venueCityMap.isNotEmpty &&
        !mapEquals(venueCityMap, _getCleanOriginal(team.venue?.city))) {
      venueBody['city'] = venueCityMap;
    }
    if (capacity != null && capacity != team.venue?.capacity) {
      venueBody['capacity'] = capacity;
    }
    if (venueBody.isNotEmpty) {
      body['venue'] = venueBody;
    }

    // Coach Logic (for combined update)
    final coachBody = <String, dynamic>{};
    if (coachNameMap.isNotEmpty &&
        !mapEquals(coachNameMap, _getCleanOriginal(team.coach?.name))) {
      coachBody['name'] = coachNameMap;
    }
    if (coachShortNameMap.isNotEmpty &&
        !mapEquals(
            coachShortNameMap, _getCleanOriginal(team.coach?.shortName))) {
      coachBody['short_name'] = coachShortNameMap;
    }
    if (coachBody.isNotEmpty) {
      body['coach'] = coachBody;
    }

    if (body.isEmpty) return;

    _bloc.add(UpdateTeamEvent(teamId: widget.teamId, body: body));
  }

  void _saveCoach() {
    final team = _currentTeam;
    if (team == null) return;

    final Map<String, dynamic> coachNameMap = {};
    final Map<String, dynamic> coachShortNameMap = {};

    for (var lang in _languages) {
      if (_coachNameControllers[lang]?.text.isNotEmpty == true) {
        coachNameMap[lang] = _coachNameControllers[lang]!.text;
      }
      if (_coachShortNameControllers[lang]?.text.isNotEmpty == true) {
        coachShortNameMap[lang] = _coachShortNameControllers[lang]!.text;
      }
    }

    final body = <String, dynamic>{};
    if (coachNameMap.isNotEmpty &&
        !mapEquals(coachNameMap, _getCleanOriginal(team.coach?.name))) {
      body['name'] = coachNameMap;
    }
    if (coachShortNameMap.isNotEmpty &&
        !mapEquals(
            coachShortNameMap, _getCleanOriginal(team.coach?.shortName))) {
      body['short_name'] = coachShortNameMap;
    }

    if (body.isEmpty) return;

    if (_currentCoachId != null) {
      _bloc.add(UpdateCoachEvent(
        teamId: widget.teamId,
        coachId: _currentCoachId!,
        body: body,
      ));
    }
  }

  void _saveVenue() {
    final team = _currentTeam;
    if (team == null) return;

    final Map<String, dynamic> venueNameMap = {};
    final Map<String, dynamic> venueShortNameMap = {};
    final Map<String, dynamic> venueCityMap = {};

    for (var lang in _languages) {
      if (_venueNameControllers[lang]?.text.isNotEmpty == true) {
        venueNameMap[lang] = _venueNameControllers[lang]!.text;
      }
      if (_venueShortNameControllers[lang]?.text.isNotEmpty == true) {
        venueShortNameMap[lang] = _venueShortNameControllers[lang]!.text;
      }
      if (_venueCityControllers[lang]?.text.isNotEmpty == true) {
        venueCityMap[lang] = _venueCityControllers[lang]!.text;
      }
    }

    final int? capacity = int.tryParse(_venueCapacityController.text);

    final body = <String, dynamic>{};
    if (venueNameMap.isNotEmpty &&
        !mapEquals(venueNameMap, _getCleanOriginal(team.venue?.name))) {
      body['name'] = venueNameMap;
    }
    if (venueShortNameMap.isNotEmpty &&
        !mapEquals(
            venueShortNameMap, _getCleanOriginal(team.venue?.shortName))) {
      body['short_name'] = venueShortNameMap;
    }
    if (venueCityMap.isNotEmpty &&
        !mapEquals(venueCityMap, _getCleanOriginal(team.venue?.city))) {
      body['city'] = venueCityMap;
    }
    if (capacity != null && capacity != team.venue?.capacity) {
      body['capacity'] = capacity;
    }

    if (body.isEmpty) return;

    if (_currentVenueId != null) {
      _bloc.add(UpdateVenueEvent(
        teamId: widget.teamId,
        venueId: _currentVenueId!,
        body: body,
      ));
    }
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
        _venueNameControllers[lang] = TextEditingController();
        _venueShortNameControllers[lang] = TextEditingController();
        _venueCityControllers[lang] = TextEditingController();
        _coachNameControllers[lang] = TextEditingController();
        _coachShortNameControllers[lang] = TextEditingController();
      });
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
    return BlocConsumer<TeamDetailBloc, TeamDetailState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is TeamDetailLoaded) {
          _populateControllers(state.team);
        } else if (state is TeamDetailUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Team updated successfully')),
          );
          _populateControllers(state.team);
          Navigator.of(context, rootNavigator: true).pop(); // Close dialog
        } else if (state is TeamCoachUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Coach updated successfully')),
          );
          Navigator.of(context, rootNavigator: true).pop(); // Close dialog
        } else if (state is TeamVenueUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Venue updated successfully')),
          );
          Navigator.of(context, rootNavigator: true).pop(); // Close dialog
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
        TeamDetailEntity? team;
        if (state is TeamDetailLoaded) {
          team = state.team;
        } else if (state is TeamDetailUpdated) {
          team = state.team;
        } else if (state is TeamSquadLoaded) {
          team = state.team;
        } else if (state is TeamDetailUpdating) {
          team = state.team;
        } else if (state is TeamPlayerUpdated) {
          team = state.team;
        }

        final title = team?.name?['en'] ?? 'Team Details';

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                if (team?.logo != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(
                      team!.logo!,
                      width: 32,
                      height: 32,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.shield, size: 32),
                    ),
                  ),
                Text(title),
              ],
            ),
          ),
          body: Builder(builder: (context) {
            if (state is TeamDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (team == null && state is TeamDetailUpdating) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                TabBar(
                  controller: _mainTabController,
                  splashBorderRadius: BorderRadius.circular(12),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppColors.kPrimary600,
                  indicatorWeight: 2.0,
                  dividerColor: Theme.of(context).colorScheme.outline,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onTertiary,
                  tabs: const [
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Details'),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Squad'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocProvider.value(
                    value: _bloc,
                    child: TabBarView(
                      controller: _mainTabController,
                      children: [
                        _buildContent(team),
                        TeamSquadTab(teamId: widget.teamId),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildLanguageTabs([StateSetter? setStateDialog]) {
    return Row(
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
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.antiAlias,
                        child: SvgPicture.asset(flagPath, fit: BoxFit.cover),
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
          onSelected: (lang) {
            _addLanguage(lang);
            if (setStateDialog != null) {
              setStateDialog(() {});
            }
          },
          itemBuilder: (context) {
            final availableLanguages = ['ar', 'fa', 'fr', 'es', 'de', 'it'];
            return availableLanguages.map((code) {
              final flagPath = _getLanguageFlagPath(code);
              return PopupMenuItem<String>(
                value: code,
                child: ListTile(
                  leading: flagPath != null
                      ? Container(
                          width: 32,
                          height: 32,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.antiAlias,
                          child: SvgPicture.asset(flagPath, fit: BoxFit.cover),
                        )
                      : Text(code.toUpperCase(),
                          style: const TextStyle(fontSize: 24)),
                  title: Text(_getLanguageName(code)),
                ),
              );
            }).toList();
          },
        ),
      ],
    );
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

  Widget _buildContent(TeamDetailEntity? team) {
    if (team == null) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: ResponsiveGrid(
        children: [
          _buildTeamInfoCard(team),
          _buildVenueInfoCard(team),
          _buildCoachInfoCard(team),
          _buildDetailsCard(team),
        ],
      ),
    );
  }

  Widget _buildTeamInfoCard(TeamDetailEntity team) {
    return InfoCard(
      title: 'Team Info',
      icon: Icons.info_outline,
      onTap: () => _showEditDialog(
          'Edit Team Info', () => _buildTeamEditContent(), _saveTeam),
      children: [
        LabeledValue(label: 'Name', values: team.name),
        LabeledValue(label: 'Short Name', values: team.shortName),
        LabeledValue(label: 'Display Name', values: team.displayName),
        LabeledValue(
            label: 'Founded', singleValue: team.foundationTime?.toString()),
        LabeledValue(label: 'Website', singleValue: team.website),
      ],
    );
  }

  Widget _buildVenueInfoCard(TeamDetailEntity team) {
    return InfoCard(
      title: 'Venue Info',
      icon: Icons.stadium,
      onTap: () => _showEditDialog(
          'Edit Venue Info', () => _buildVenueEditContent(), _saveVenue),
      children: [
        LabeledValue(label: 'Name', values: team.venue?.name),
        LabeledValue(label: 'Short Name', values: team.venue?.shortName),
        LabeledValue(label: 'City', values: team.venue?.city),
        LabeledValue(
            label: 'Capacity', singleValue: team.venue?.capacity?.toString()),
      ],
    );
  }

  Widget _buildCoachInfoCard(TeamDetailEntity team) {
    return InfoCard(
      title: 'Coach Info',
      icon: Icons.person,
      onTap: () => _showEditDialog(
          'Edit Coach Info', () => _buildCoachEditContent(), _saveCoach),
      children: [
        LabeledValue(
          label: 'Name',
          values: team.coach?.name,
          logoUrl: team.coach?.logo,
        ),
        LabeledValue(label: 'Short Name', values: team.coach?.shortName),
      ],
    );
  }

  Widget _buildDetailsCard(TeamDetailEntity team) {
    return InfoCard(
      title: 'Details',
      icon: Icons.analytics,
      // No edit for these yet as they are read-only or handled elsewhere?
      // User didn't ask to edit these specifically, but let's keep them read-only for now.
      children: [
        LabeledValue(
            label: 'Market Value',
            singleValue:
                '${team.marketValue ?? "-"} ${team.marketValueCurrency ?? ""}'),
        LabeledValue(
          label: 'Country',
          singleValue: team.country?.name?['en'],
          logoUrl: team.country?.logo,
        ),
        LabeledValue(
          label: 'Competition',
          singleValue: team.competition?.name?['en'],
          logoUrl: team.competition?.logo,
        ),
      ],
    );
  }

  void _showEditDialog(
      String title, Widget Function() contentBuilder, VoidCallback onSave) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 600, maxHeight: 800),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .outlineVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title,
                              style: Theme.of(context).textTheme.titleLarge),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              _buildLanguageTabs(setStateDialog),
                              const SizedBox(height: 24),
                              contentBuilder(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        border: Border(
                          top: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .outlineVariant
                                .withValues(alpha: 0.5),
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
                            onPressed: onSave,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTeamEditContent() {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, child) {
        final index = _tabController.index;
        if (index < 0 || index >= _languages.length) return const SizedBox();
        final lang = _languages[index];
        return Column(
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
            if (lang == 'en') ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _displayNameControllers[lang],
                decoration: const InputDecoration(labelText: 'Display Name'),
                maxLength: 3,
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildVenueEditContent() {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, child) {
        final index = _tabController.index;
        if (index < 0 || index >= _languages.length) return const SizedBox();
        final lang = _languages[index];
        return Column(
          children: [
            TextFormField(
              controller: _venueNameControllers[lang],
              decoration: const InputDecoration(labelText: 'Venue Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _venueShortNameControllers[lang],
              decoration: const InputDecoration(labelText: 'Venue Short Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _venueCityControllers[lang],
              decoration: const InputDecoration(labelText: 'Venue City'),
            ),
            const SizedBox(height: 16),
            // Capacity is shared across languages, but shown here for convenience
            TextFormField(
              controller: _venueCapacityController,
              decoration: const InputDecoration(labelText: 'Venue Capacity'),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCoachEditContent() {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, child) {
        final index = _tabController.index;
        if (index < 0 || index >= _languages.length) return const SizedBox();
        final lang = _languages[index];
        return Column(
          children: [
            TextFormField(
              controller: _coachNameControllers[lang],
              decoration: const InputDecoration(labelText: 'Coach Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _coachShortNameControllers[lang],
              decoration: const InputDecoration(labelText: 'Coach Short Name'),
            ),
          ],
        );
      },
    );
  }
}
