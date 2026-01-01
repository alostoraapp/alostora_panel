import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/app_icons.dart';
import '../../domain/entities/competition_detail_entity.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onTap;
  final IconData? icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.children,
    this.onTap,
    this.icon,
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
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
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
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  if (onTap != null) ...[
                    const Spacer(),
                    Icon(
                      Icons.edit,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabeledValue extends StatelessWidget {
  final String label;
  final Map<String, String>? values;
  final String? singleValue;
  final String? logoUrl;

  const LabeledValue({
    super.key,
    required this.label,
    this.values,
    this.singleValue,
    this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              if (logoUrl != null) ...[
                const SizedBox(width: 8),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(logoUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: _buildValues(context),
          ),
        ],
      ),
    );
  }

  Widget _buildValues(BuildContext context) {
    final theme = Theme.of(context);
    final valueStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
    );

    if (singleValue != null) {
      return Text(singleValue!, style: valueStyle);
    } else if (values != null && values!.isNotEmpty) {
      final sortedEntries = values!.entries.toList()
        ..sort((a, b) {
          if (a.key == 'en') return -1;
          if (b.key == 'en') return 1;
          if (a.key == 'ar') return -1;
          if (b.key == 'ar') return 1;
          return a.key.compareTo(b.key);
        });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sortedEntries.map((e) {
          final flagPath = _getFlagPath(e.key);
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (flagPath != null)
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAlias,
                    child: SvgPicture.asset(
                      flagPath,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Text(e.key.toUpperCase(),
                      style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 10),
                Text(e.value, style: valueStyle),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return Text('-', style: valueStyle?.copyWith(color: Colors.grey));
    }
  }

  String? _getFlagPath(String code) {
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
}

class EditCompetitionDialog extends StatefulWidget {
  final CompetitionDetailEntity competition;
  final Function(Map<String, dynamic> body) onSave;

  const EditCompetitionDialog({
    super.key,
    required this.competition,
    required this.onSave,
  });

  @override
  State<EditCompetitionDialog> createState() => _EditCompetitionDialogState();
}

class _EditCompetitionDialogState extends State<EditCompetitionDialog>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _languages = ['en', 'ar'];
  final Map<String, TextEditingController> _nameControllers = {};
  final Map<String, TextEditingController> _shortNameControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeLanguages();
    _tabController = TabController(length: _languages.length, vsync: this);
    _initializeControllers();
  }

  void _initializeLanguages() {
    final Set<String> allLanguages = {'en', 'ar'};
    if (widget.competition.name != null) {
      allLanguages.addAll(widget.competition.name!.keys);
    }
    if (widget.competition.shortName != null) {
      allLanguages.addAll(widget.competition.shortName!.keys);
    }
    _languages.clear();
    _languages.addAll(allLanguages);
  }

  void _initializeControllers() {
    for (var lang in _languages) {
      _nameControllers[lang] =
          TextEditingController(text: widget.competition.name?[lang] ?? '');
      _shortNameControllers[lang] = TextEditingController(
          text: widget.competition.shortName?[lang] ?? '');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (var controller in _nameControllers.values) controller.dispose();
    for (var controller in _shortNameControllers.values) controller.dispose();
    super.dispose();
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
      });
    }
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
                  Text('Edit Competition Info',
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
                      _buildLanguageTabs(),
                      const SizedBox(height: 24),
                      _buildForm(),
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
                      final Map<String, dynamic> nameMap = {};
                      final Map<String, dynamic> shortNameMap = {};

                      // Helpers to ensure we compare apples to apples
                      // Filter out empty strings from original maps because our form maps only include non-empty values
                      Map<String, dynamic> getCleanOriginal(
                          Map<String, String>? original) {
                        if (original == null) return {};
                        return Map.fromEntries(original.entries
                            .where((e) => e.value.trim().isNotEmpty));
                      }

                      for (var lang in _languages) {
                        if (_nameControllers[lang]?.text.isNotEmpty == true) {
                          nameMap[lang] = _nameControllers[lang]!.text;
                        }
                        if (_shortNameControllers[lang]?.text.isNotEmpty ==
                            true) {
                          shortNameMap[lang] =
                              _shortNameControllers[lang]!.text;
                        }
                      }

                      final body = <String, dynamic>{};

                      final cleanOriginalName =
                          getCleanOriginal(widget.competition.name);
                      if (nameMap.isNotEmpty &&
                          !mapEquals(nameMap, cleanOriginalName)) {
                        body['name'] = nameMap;
                      }

                      final cleanOriginalShortName =
                          getCleanOriginal(widget.competition.shortName);
                      if (shortNameMap.isNotEmpty &&
                          !mapEquals(shortNameMap, cleanOriginalShortName)) {
                        body['short_name'] = shortNameMap;
                      }

                      if (body.isEmpty) return;

                      widget.onSave(body);
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

  Widget _buildLanguageTabs() {
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
          onSelected: _addLanguage,
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

  Widget _buildForm() {
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
          ],
        );
      },
    );
  }
}
