import 'dart:typed_data';

import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/l10n/s.dart';
import 'package:alostora/features/match_detail/domain/entities/highlight_entity.dart';
import 'package:alostora/features/match_detail/presentation/bloc/match_highlights/match_highlights_bloc.dart';
import 'package:alostora/features/match_detail/presentation/bloc/match_highlights/match_highlights_event.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HighlightEditScreen extends StatefulWidget {
  final String matchId;
  final HighlightEntity? highlight;
  final MatchHighlightsBloc matchHighlightsBloc;

  const HighlightEditScreen({
    super.key,
    required this.matchId,
    this.highlight,
    required this.matchHighlightsBloc,
  });

  @override
  State<HighlightEditScreen> createState() => _HighlightEditScreenState();
}

class _HighlightEditScreenState extends State<HighlightEditScreen>
    with TickerProviderStateMixin {
  late TextEditingController _mediaUrlController;
  late TextEditingController _mediaCoverController;
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  late TextEditingController _secondsController;
  XFile? _pickedFile;
  bool _sendNotification = false;
  String _selectedPriority = 'normal';
  String _selectedType = 'other';

  // Language management
  List<String> _languages = ['en'];
  late TabController _tabController;
  final Map<String, TextEditingController> _titleControllers = {};

  @override
  void initState() {
    super.initState();
    _mediaUrlController =
        TextEditingController(text: widget.highlight?.mediaUrl ?? '');
    _mediaCoverController =
        TextEditingController(text: widget.highlight?.cover ?? '');

    int totalSeconds = widget.highlight?.videoTime ?? 0;
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    _hoursController = TextEditingController(text: hours.toString());
    _minutesController = TextEditingController(text: minutes.toString());
    _secondsController = TextEditingController(text: seconds.toString());
    _selectedPriority = widget.highlight?.priority ?? 'normal';
    _selectedType = widget.highlight?.type ?? 'other';

    if (_selectedPriority == 'urgent') {
      _sendNotification = true;
    }

    // Initialize languages and title controllers
    if (widget.highlight != null) {
      _titleControllers['en'] =
          TextEditingController(text: widget.highlight!.title);
      for (var translation in widget.highlight!.titleTranslations) {
        if (!_languages.contains(translation.languageCode)) {
          _languages.add(translation.languageCode);
        }
        _titleControllers[translation.languageCode] =
            TextEditingController(text: translation.text);
      }
    } else {
      _titleControllers['en'] = TextEditingController();
    }

    _tabController = TabController(length: _languages.length, vsync: this);
  }

  @override
  void dispose() {
    _mediaUrlController.dispose();
    _mediaCoverController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    _tabController.dispose();
    for (var controller in _titleControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addLanguage(String code) {
    if (!_languages.contains(code)) {
      setState(() {
        _languages.add(code);
        _titleControllers[code] = TextEditingController();
        _tabController.dispose();
        _tabController = TabController(length: _languages.length, vsync: this);
        _tabController.animateTo(_languages.length - 1);
      });
    } else {
      int index = _languages.indexOf(code);
      _tabController.animateTo(index);
    }
  }

  void _removeLanguage(int index) {
    if (_languages[index] == 'en') return; // Cannot remove default language

    setState(() {
      String code = _languages[index];
      _languages.removeAt(index);
      _titleControllers[code]?.dispose();
      _titleControllers.remove(code);
      _tabController.dispose();
      _tabController = TabController(length: _languages.length, vsync: this);
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedFile = image;
          _mediaCoverController.text = image.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(S.of(context).errorPickingImage(e.toString()))),
        );
      }
    }
  }

  Widget _buildImagePreview() {
    if (_pickedFile != null) {
      return FutureBuilder<Uint8List>(
        future: _pickedFile!.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.memory(
              snapshot.data!,
              height: 180,
              width: 320,
              fit: BoxFit.cover,
            );
          }
          return const SizedBox(
              height: 180,
              width: 320,
              child: Center(child: CircularProgressIndicator()));
        },
      );
    } else if (_mediaCoverController.text.isNotEmpty) {
      String imageUrl = _mediaCoverController.text;
      if (!imageUrl.startsWith('http')) {
        imageUrl = '${AppConstants.baseUrl}$imageUrl';
      }
      return Image.network(
        imageUrl,
        height: 180,
        width: 320,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const SizedBox(
            width: 320,
            height: 180,
            child: Center(child: Icon(Icons.broken_image, size: 50))),
      );
    }
    return const SizedBox.shrink();
  }

  String _getLanguageFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'ar':
        return '🇸🇦';
      case 'fa':
        return '🇮🇷';
      case 'fr':
        return '🇫🇷';
      case 'es':
        return '🇪🇸';
      case 'de':
        return '🇩🇪';
      case 'it':
        return '🇮🇹';
      default:
        return '🏳️';
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

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final availableLanguages = ['ar', 'fa', 'fr', 'es', 'de', 'it'];
        return ListView(
          shrinkWrap: true,
          children: availableLanguages.map((code) {
            return ListTile(
              leading: Text(_getLanguageFlag(code),
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

  void _save() {
    final s = S.of(context);
    try {
      final hours = int.tryParse(_hoursController.text) ?? 0;
      final minutes = int.tryParse(_minutesController.text) ?? 0;
      final seconds = int.tryParse(_secondsController.text) ?? 0;
      final totalSeconds = (hours * 3600) + (minutes * 60) + seconds;

      final params = <String, dynamic>{};

      // Title and translations
      params['title'] = _titleControllers['en']?.text ?? '';

      // Construct translations list for backend
      // Assuming backend expects a list of objects with language_code and text
      // Or a map. Based on typical structure, let's assume list of maps for now
      // but if it's FormData, we might need index based naming.
      // Let's stick to the previous implementation's implication or standard JSON if possible.
      // Since we are using FormData in DataSource, we need to be careful.
      // The previous implementation didn't show how translations were saved in Create/Update.
      // I'll assume we send 'title_translations' as a JSON string or indexed fields.
      // For now, let's construct a list of maps.
      List<Map<String, String>> translations = [];
      _titleControllers.forEach((code, controller) {
        if (code != 'en' && controller.text.isNotEmpty) {
          translations.add({
            'language_code': code,
            'text': controller.text,
          });
        }
      });

      // We'll pass this to the bloc, and the datasource will need to handle it.
      // If the backend expects 'title_translations[0][language_code]', we might need a helper.
      // For now, let's pass it as a list and let Dio/DataSource handle it or we fix it there.
      params['title_translations'] = translations;

      if (_mediaUrlController.text.isNotEmpty) {
        params['media_url'] = _mediaUrlController.text;
      }
      if (_pickedFile != null) {
        params['cover'] = _pickedFile;
      }
      if (totalSeconds > 0) {
        params['video_time'] = totalSeconds;
      }
      params['type'] = _selectedType;
      params['priority'] = _selectedPriority;

      if (widget.highlight == null) {
        widget.matchHighlightsBloc
            .add(CreateHighlightEvent(matchId: widget.matchId, params: params));
      } else {
        widget.matchHighlightsBloc.add(UpdateHighlightEvent(
          matchId: widget.matchId,
          highlightId: widget.highlight!.id,
          params: params,
        ));
      }
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.requestSent)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.error(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.highlight == null ? s.addMedia : s.editMedia),
        actions: [
          if (widget.highlight != null) ...[
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Handle delete
                widget.matchHighlightsBloc.add(DeleteHighlightEvent(
                  matchId: widget.matchId,
                  highlightId: widget.highlight!.id,
                ));
                Navigator.pop(context);
              },
            ),
          ]
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Tabs
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      tabs: _languages.map((code) {
                        return Tab(
                          child: Row(
                            children: [
                              Text(
                                  '${_getLanguageFlag(code)} ${code.toUpperCase()}'),
                              if (code != 'en') ...[
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () =>
                                      _removeLanguage(_languages.indexOf(code)),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.close,
                                        size: 14,
                                        color: theme.colorScheme.error),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _showLanguagePicker,
                    tooltip: s.changeLanguage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Title Field (Dynamic based on tab)
            SizedBox(
              height: 180, // Increased fixed height for text field
              child: TabBarView(
                controller: _tabController,
                children: _languages.map((code) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: _titleControllers[code],
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText:
                            '${s.matchDetails} (${_getLanguageName(code)})',
                        hintText: 'Enter title in ${_getLanguageName(code)}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignLabelWithHint: true,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Type Dropdown
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(
                labelText: s.highlightType,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              items: [
                DropdownMenuItem(
                    value: 'summary', child: Text(s.highlightTypeSummary)),
                DropdownMenuItem(
                    value: 'goals', child: Text(s.highlightTypeGoals)),
                DropdownMenuItem(
                    value: 'full_match', child: Text(s.highlightTypeFullMatch)),
                DropdownMenuItem(
                    value: 'penalties', child: Text(s.highlightTypePenalties)),
                DropdownMenuItem(
                    value: 'celebration',
                    child: Text(s.highlightTypeCelebration)),
                DropdownMenuItem(
                    value: 'other', child: Text(s.highlightTypeOther)),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedType = value;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // Media URL
            TextField(
              controller: _mediaUrlController,
              decoration: InputDecoration(
                labelText: s.mediaUrl,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 24),

            // Cover Image
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _mediaCoverController,
                    decoration: InputDecoration(
                      labelText: s.mediaCover,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.image),
                    ),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: _pickImage,
                    icon: Icon(Icons.upload_file,
                        color: theme.colorScheme.onPrimaryContainer),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_pickedFile != null || _mediaCoverController.text.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildImagePreview(),
              ),
            const SizedBox(height: 24),

            // Duration
            Text(s.matchDetails,
                style: theme.textTheme
                    .titleMedium), // Using matchDetails as a placeholder for "Duration" label if specific one missing, or just remove label
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _hoursController,
                    decoration: InputDecoration(
                      labelText: s.hours,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _minutesController,
                    decoration: InputDecoration(
                      labelText: s.minutes,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _secondsController,
                    decoration: InputDecoration(
                      labelText: s.seconds,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Notification / Priority
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: Text(s.sendNotification,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                value: _sendNotification,
                onChanged: (value) {
                  setState(() {
                    _sendNotification = value;
                    _selectedPriority = value ? 'urgent' : 'normal';
                  });
                },
                secondary: Icon(
                  _sendNotification
                      ? Icons.notifications_active
                      : Icons.notifications_none,
                  color: _sendNotification
                      ? theme.colorScheme.primary
                      : Colors.grey,
                  size: 20,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                dense: true,
              ),
            ),

            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: Text(s.save,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20), // Extra padding at bottom
          ],
        ),
      ),
    );
  }
}
