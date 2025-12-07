import 'package:alostora/features/news/domain/usecases/search_teams_usecase.dart';
import 'package:alostora/injection_container.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:alostora/core/config/constants.dart';
import 'package:alostora/core/l10n/s.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/domain/usecases/create_news_usecase.dart';
import 'package:alostora/features/news/domain/usecases/upload_news_image_usecase.dart';
import 'package:alostora/features/news/presentation/bloc/news_bloc.dart';
import 'package:alostora/features/news/presentation/bloc/news_event.dart';
import 'package:alostora/features/news/presentation/bloc/news_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class NewsEditScreen extends StatefulWidget {
  final NewsEntity? news;
  final NewsBloc newsBloc;

  const NewsEditScreen({
    super.key,
    this.news,
    required this.newsBloc,
  });

  @override
  State<NewsEditScreen> createState() => _NewsEditScreenState();
}

class _NewsEditScreenState extends State<NewsEditScreen>
    with TickerProviderStateMixin {
  late TextEditingController _sourceUrlController;
  late TextEditingController _relatedTeamsController;

  // Image Management
  List<dynamic> _newsImages = []; // Contains NewsImageEntity or XFile
  List<String> _deletedImageIds = [];
  int _coverIndex = 0;
  List<Map<String, dynamic>> _selectedRelatedTeams = [];

  // Upload State
  final Map<XFile, double> _uploadingImages = {};
  NewsEntity? _currentNews;

  bool _isPinned = false;
  String _selectedPriority = 'normal';
  String _status = 'draft';

  // Language management
  List<String> _languages = ['en'];
  late TabController _tabController;
  final Map<String, TextEditingController> _titleControllers = {};
  final Map<String, QuillController> _contentControllers = {};

  @override
  void initState() {
    super.initState();
    _currentNews = widget.news;
    _sourceUrlController =
        TextEditingController(text: widget.news?.sourceUrl ?? '');
    _relatedTeamsController = TextEditingController(
        text: widget.news?.relatedTeamsDetails != null
            ? widget.news!.relatedTeamsDetails.toString()
            : '');
    _isPinned = widget.news?.isPinned ?? false;
    _selectedPriority = widget.news?.priority ?? 'normal';
    _status = widget.news?.status ?? 'draft';

    // Initialize images
    if (widget.news != null) {
      _newsImages = List.from(widget.news!.images);
      // Find cover
      final index = _newsImages
          .indexWhere((img) => img is NewsImageEntity && img.order == 'cover');
      if (index != -1) {
        _coverIndex = index;
      } else if (_newsImages.isNotEmpty) {
        _coverIndex = 0;
      }
    }

    // Initialize languages and controllers
    if (widget.news != null) {
      _titleControllers['en'] = TextEditingController(text: widget.news!.title);
      _contentControllers['en'] = _createQuillController(widget.news!.content);

      // Process title translations
      for (var translation in widget.news!.titleTranslations) {
        if (!_languages.contains(translation.languageCode)) {
          _languages.add(translation.languageCode);
        }
        _titleControllers[translation.languageCode] =
            TextEditingController(text: translation.text);
      }

      // Process content translations
      for (var translation in widget.news!.contentTranslations) {
        if (!_languages.contains(translation.languageCode)) {
          _languages.add(translation.languageCode);
        }
        _contentControllers[translation.languageCode] =
            _createQuillController(translation.text);
      }
    } else {
      _titleControllers['en'] = TextEditingController();
      _contentControllers['en'] = QuillController.basic();
    }

    // Ensure controllers exist for all languages found
    for (var code in _languages) {
      if (!_titleControllers.containsKey(code)) {
        _titleControllers[code] = TextEditingController();
      }
      if (!_contentControllers.containsKey(code)) {
        _contentControllers[code] = QuillController.basic();
      }
    }

    _tabController = TabController(length: _languages.length, vsync: this);
  }

  QuillController _createQuillController(String content) {
    if (content.isEmpty) return QuillController.basic();
    try {
      final delta = HtmlToDelta().convert(content);
      return QuillController(
        document: Document.fromDelta(delta),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } catch (e) {
      // Fallback for plain text or error
      return QuillController(
        document: Document()..insert(0, content),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  void dispose() {
    _sourceUrlController.dispose();
    _relatedTeamsController.dispose();
    _tabController.dispose();
    for (var controller in _titleControllers.values) {
      controller.dispose();
    }
    for (var controller in _contentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addLanguage(String code) {
    if (!_languages.contains(code)) {
      setState(() {
        _languages.add(code);
        _titleControllers[code] = TextEditingController();
        _contentControllers[code] = QuillController.basic();
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
      _contentControllers[code]?.dispose();
      _titleControllers.remove(code);
      _contentControllers.remove(code);
      _tabController.dispose();
      _tabController = TabController(length: _languages.length, vsync: this);
    });
  }

  Future<void> _createDraft() async {
    // Basic validation
    if (_titleControllers['en']?.text.isEmpty ?? true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title first')),
      );
      return;
    }

    // Collect data for draft
    final enContent = _contentControllers['en'] != null
        ? _convertDeltaToHtml(_contentControllers['en']!.document.toDelta())
        : '';

    final newsData = {
      'title': _titleControllers['en']?.text ?? '',
      'content': enContent,
      'status': 'draft',
      'priority': _selectedPriority,
      'is_pinned': _isPinned,
    };

    // Use Bloc to create, but we need to wait for result.
    // Since Bloc is event-based, we might need to listen to state changes or use a Completer.
    // However, for simplicity in this refactor, we can trigger the event and wait for the state change in the listener,
    // OR we can use the UseCase directly here for the draft creation to get the ID immediately.
    // Using UseCase directly is cleaner for this specific "synchronous-like" requirement.

    final createNewsUseCase = sl<CreateNewsUseCase>();
    final result = await createNewsUseCase(newsData);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create draft: ${failure.message}')),
        );
      },
      (news) {
        setState(() {
          _currentNews = news;
        });
      },
    );
  }

  Future<void> _uploadImage(XFile image) async {
    if (_currentNews == null) {
      await _createDraft();
      if (_currentNews == null) return; // Failed to create draft
    }

    setState(() {
      _uploadingImages[image] = 0.0;
    });

    final uploadUseCase = sl<UploadNewsImageUseCase>();
    final result = await uploadUseCase(UploadNewsImageParams(
      id: _currentNews!.id,
      image: image,
      onSendProgress: (sent, total) {
        if (mounted) {
          setState(() {
            _uploadingImages[image] = sent / total;
          });
        }
      },
    ));

    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _uploadingImages.remove(image);
            _newsImages.remove(image); // Remove failed image
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to upload image: ${failure.message}')),
          );
        }
      },
      (newsImage) {
        if (mounted) {
          setState(() {
            _uploadingImages.remove(image);
            // Replace XFile with NewsImageEntity
            final index = _newsImages.indexOf(image);
            if (index != -1) {
              _newsImages[index] = newsImage;
            } else {
              _newsImages.add(newsImage);
            }
          });
          // Refresh news data to ensure consistency
          widget.newsBloc.add(GetNewsEvent()); // Or GetNewsById if available
        }
      },
    );
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _newsImages.addAll(images);
          if (_newsImages.length == images.length && _currentNews == null) {
            // First images added
            _coverIndex = 0;
          }
        });

        // Trigger upload for each new image
        for (var image in images) {
          _uploadImage(image);
        }
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

  void _removeImage(int index) {
    setState(() {
      final item = _newsImages[index];
      if (item is NewsImageEntity) {
        _deletedImageIds.add(item.id);
      } else if (item is XFile) {
        // Cancel upload if in progress? (Not implemented for simplicity)
        _uploadingImages.remove(item);
      }
      _newsImages.removeAt(index);

      // Adjust cover index
      if (index == _coverIndex) {
        _coverIndex = 0; // Reset to first if cover deleted
      } else if (index < _coverIndex) {
        _coverIndex--;
      }

      if (_newsImages.isEmpty) {
        _coverIndex = 0;
      } else if (_coverIndex >= _newsImages.length) {
        _coverIndex = _newsImages.length - 1;
      }
    });
  }

  void _setCover(int index) {
    setState(() {
      _coverIndex = index;
    });
  }

  Widget _buildImageGrid(ThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: _newsImages.length + 1,
      itemBuilder: (context, index) {
        if (index == _newsImages.length) {
          // Add button
          return InkWell(
            onTap: _pickImages,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.5),
                  style: BorderStyle.solid,
                ),
              ),
              child: Icon(Icons.add_photo_alternate,
                  size: 32, color: theme.colorScheme.onSurfaceVariant),
            ),
          );
        }

        final item = _newsImages[index];
        final isCover = index == _coverIndex;
        final isUploading = item is XFile && _uploadingImages.containsKey(item);
        final progress = item is XFile ? _uploadingImages[item] ?? 0.0 : 0.0;

        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  item is NewsImageEntity
                      ? Image.network(
                          item.image.startsWith('http')
                              ? item.image
                              : '${AppConstants.baseUrl}${item.image}',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image)),
                        )
                      : FutureBuilder<Uint8List>(
                          future: (item as XFile).readAsBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Image.memory(snapshot.data!,
                                  fit: BoxFit.cover);
                            }
                            return Container(color: Colors.grey[300]);
                          },
                        ),
                  if (isUploading)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Cover Indicator
            if (isCover)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Cover',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
              ),

            // Actions Overlay
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isUploading ? null : () => _setCover(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: isCover
                          ? Border.all(
                              color: theme.colorScheme.primary, width: 3)
                          : null,
                    ),
                  ),
                ),
              ),
            ),

            // Delete Button
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: () => _removeImage(index),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
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

  bool _isRtl(String code) {
    return ['ar', 'fa', 'he', 'ur'].contains(code);
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

  String _convertDeltaToHtml(dynamic delta) {
    final converter = QuillDeltaToHtmlConverter(
      delta.toJson(),
      ConverterOptions.forEmail(),
    );
    return converter.convert();
  }

  void _saveNews() {
    final s = S.of(context);

    // Collect translations
    List<Map<String, String>> titleTranslations = [];
    List<Map<String, String>> contentTranslations = [];

    _titleControllers.forEach((code, controller) {
      if (code != 'en' && controller.text.isNotEmpty) {
        titleTranslations.add({
          'language_code': code,
          'text': controller.text,
        });
      }
    });

    _contentControllers.forEach((code, controller) {
      if (code != 'en') {
        final html = _convertDeltaToHtml(controller.document.toDelta());
        if (html.isNotEmpty && html != '<p><br/></p>') {
          contentTranslations.add({
            'language_code': code,
            'text': html,
          });
        }
      }
    });

    final enContent = _contentControllers['en'] != null
        ? _convertDeltaToHtml(_contentControllers['en']!.document.toDelta())
        : '';

    // Collect Images
    List<XFile> newImages = [];
    for (var item in _newsImages) {
      if (item is XFile) {
        newImages.add(item);
      }
    }

    // Determine Cover
    // If cover is an existing image, we might need to send its ID.
    // If cover is a new image, we might need to send its index in the newImages list?
    // Or maybe we send 'cover_image_index' relative to the full list?
    // Since I don't know the backend API perfectly, I'll try to send:
    // - images: new files
    // - deleted_images: ids
    // - cover_image_id: id (if existing)
    // - cover_image_index: index in newImages (if new)

    String? coverImageId;
    int? coverImageIndexInNew;

    if (_newsImages.isNotEmpty) {
      final coverItem = _newsImages[_coverIndex];
      if (coverItem is NewsImageEntity) {
        coverImageId = coverItem.id;
      } else if (coverItem is XFile) {
        coverImageIndexInNew = newImages.indexOf(coverItem);
      }
    }

    final newsData = {
      'title': _titleControllers['en']?.text ?? '',
      'content': enContent,
      'source_url': _sourceUrlController.text,
      'status': _status,
      'priority': _selectedPriority,
      'is_pinned': _isPinned,
      'title_translations': titleTranslations,
      'content_translations': contentTranslations,
      'images': newImages,
      'deleted_image_ids': _deletedImageIds,
      'related_teams': _selectedRelatedTeams.map((t) => t['id']).toList(),
    };

    if (coverImageId != null) {
      newsData['cover_image_id'] = coverImageId;
    }
    if (coverImageIndexInNew != null) {
      newsData['cover_image_index'] = coverImageIndexInNew;
    }

    if (widget.news != null) {
      widget.newsBloc.add(UpdateNewsEvent(widget.news!.id, newsData));
    } else {
      widget.newsBloc.add(CreateNewsEvent(newsData));
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s.requestSent)),
    );
  }

  void _deleteNews() {
    if (widget.news != null) {
      widget.newsBloc.add(DeleteNewsEvent(widget.news!.id));
      Navigator.pop(context);
    }
  }

  void _approveNews() {
    final s = S.of(context);
    if (widget.news != null) {
      widget.newsBloc.add(ApproveNewsEvent(widget.news!.id, {
        'status': 'published',
        'priority': _selectedPriority,
      }));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.incidentApproved)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return BlocListener<NewsBloc, NewsState>(
      bloc: widget.newsBloc,
      listener: (context, state) {
        if (state is NewsOperationSuccess) {
          // Handled in _saveNews mostly, but good for backup
        } else if (state is NewsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.news != null ? 'Edit News' : 'Add News'),
          actions: [
            if (widget.news?.status == 'pending_approval')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FilledButton(
                  onPressed: _approveNews,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(s.approve),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FilledButton(
                onPressed: _saveNews,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(s.save),
              ),
            ),
            if (widget.news != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(s.delete),
                      content: const Text(
                          'Are you sure you want to delete this news?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(s.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteNews();
                          },
                          child: Text(s.delete,
                              style: const TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
                                    onTap: () => _removeLanguage(
                                        _languages.indexOf(code)),
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

              // Title and Content Fields (Dynamic based on tab)
              SizedBox(
                height: 500, // Increased height for editor
                child: TabBarView(
                  controller: _tabController,
                  children: _languages.map((code) {
                    final isRtl = _isRtl(code);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextField(
                            controller: _titleControllers[code],
                            textDirection:
                                isRtl ? TextDirection.rtl : TextDirection.ltr,
                            decoration: InputDecoration(
                              labelText: 'Title (${_getLanguageName(code)})',
                              hintText:
                                  'Enter title in ${_getLanguageName(code)}',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.colorScheme.outline
                                      .withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                QuillSimpleToolbar(
                                  controller: _contentControllers[code]!,
                                  config: const QuillSimpleToolbarConfig(
                                    showFontFamily: false,
                                    showFontSize: false,
                                    showSearchButton: false,
                                    showSubscript: false,
                                    showSuperscript: false,
                                  ),
                                ),
                                const Divider(height: 1),
                                Expanded(
                                  child: Directionality(
                                    textDirection: isRtl
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: QuillEditor.basic(
                                      controller: _contentControllers[code]!,
                                      config: QuillEditorConfig(
                                        padding: const EdgeInsets.all(16),
                                        placeholder:
                                            'Enter content in ${_getLanguageName(code)}...',
                                        autoFocus: false,
                                        expands: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Source URL
              TextField(
                controller: _sourceUrlController,
                decoration: InputDecoration(
                  labelText: 'Source URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 24),

              // Images Collection
              Text('Images', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              _buildImageGrid(theme),
              const SizedBox(height: 24),

              // Related Teams
              _RelatedTeamsSelector(
                initialTeams: widget.news?.relatedTeamsDetails
                        ?.map((e) => Map<String, dynamic>.from(e))
                        .toList() ??
                    [],
                onTeamsChanged: (teams) {
                  setState(() {
                    _selectedRelatedTeams = teams;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Priority Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                decoration: InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.flag),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'normal',
                    child: Text(s.highlightPriorityNormal),
                  ),
                  DropdownMenuItem(
                    value: 'important',
                    child: Text(s.highlightPriorityImportant),
                  ),
                  DropdownMenuItem(
                    value: 'urgent',
                    child: Text(s.highlightPriorityUrgent),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPriority = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),
              // Pinned Switch
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SwitchListTile(
                  title: Text(s.pinned,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  value: _isPinned,
                  onChanged: (value) {
                    setState(() {
                      _isPinned = value;
                    });
                  },
                  secondary: Icon(
                    _isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: _isPinned ? Colors.blue : Colors.grey,
                    size: 20,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  dense: true,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _RelatedTeamsSelector extends StatefulWidget {
  final List<Map<String, dynamic>> initialTeams;
  final ValueChanged<List<Map<String, dynamic>>> onTeamsChanged;

  const _RelatedTeamsSelector({
    required this.initialTeams,
    required this.onTeamsChanged,
  });

  @override
  State<_RelatedTeamsSelector> createState() => _RelatedTeamsSelectorState();
}

class _RelatedTeamsSelectorState extends State<_RelatedTeamsSelector> {
  late List<Map<String, dynamic>> _selectedTeams;
  List<Map<String, dynamic>> _availableTeams = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _debounce;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedTeams = List.from(widget.initialTeams);
    // Notify initial state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTeamsChanged(_selectedTeams);
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        // Delay hiding overlay to allow onTap to propagate
        Future.delayed(const Duration(milliseconds: 200), () {
          if (!_focusNode.hasFocus) {
            _hideOverlay();
          }
        });
      }
    });

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        _searchTeams(_searchController.text);
      } else {
        setState(() {
          _availableTeams = [];
        });
        _overlayEntry?.markNeedsBuild();
      }
    });
  }

  Future<void> _searchTeams(String query) async {
    setState(() {
      _isLoading = true;
    });
    _overlayEntry?.markNeedsBuild();

    final result = await sl<SearchTeamsUseCase>()(query);

    result.fold(
      (failure) {
        // Handle error silently or show toast
        setState(() {
          _isLoading = false;
          _availableTeams = [];
        });
      },
      (teams) {
        setState(() {
          _isLoading = false;
          _availableTeams = teams
              .where((team) =>
                  !_selectedTeams.any((selected) => selected['id'] == team.id))
              .map((team) => {
                    'id': team.id,
                    'name': team.name,
                    'short_name': team.shortName,
                    'logo': team.logo,
                  })
              .toList();
        });
      },
    );
    _overlayEntry?.markNeedsBuild();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    final spaceBelow = screenHeight - offset.dy - size.height;

    // Determine if we should show above
    // Consider keyboard height if possible, but MediaQuery.viewInsets.bottom helps
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final availableBelow = spaceBelow - bottomInset;

    final bool showAbove = availableBelow < 220; // 200 max height + buffer

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          targetAnchor: showAbove ? Alignment.topLeft : Alignment.bottomLeft,
          followerAnchor: showAbove ? Alignment.bottomLeft : Alignment.topLeft,
          offset: showAbove ? const Offset(0.0, -5.0) : const Offset(0.0, 5.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: _isLoading
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ))
                  : ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: _availableTeams.isEmpty
                          ? [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text("No teams found"),
                              )
                            ]
                          : _availableTeams.map((team) {
                              return ListTile(
                                leading: team['logo'] != null &&
                                        team['logo'].isNotEmpty
                                    ? Image.network(team['logo'],
                                        width: 24,
                                        height: 24,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.shield, size: 24))
                                    : const Icon(Icons.shield, size: 24),
                                title: Text(team['name'] ?? 'Unknown'),
                                onTap: () {
                                  _selectTeam(team);
                                },
                              );
                            }).toList(),
                    ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _selectTeam(Map<String, dynamic> team) {
    setState(() {
      _selectedTeams.add(team);
      _availableTeams.remove(team);
      _searchController.clear();
    });
    widget.onTeamsChanged(_selectedTeams);
    _hideOverlay();
    // Keep focus?
    _focusNode.requestFocus();
  }

  void _removeTeam(Map<String, dynamic> team) {
    setState(() {
      _selectedTeams.remove(team);
      _availableTeams.add(team); // Add back to available so we can re-select
    });
    widget.onTeamsChanged(_selectedTeams);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Teams',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                  color: _focusNode.hasFocus
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ..._selectedTeams.map((team) {
                  return Chip(
                    avatar: team['logo'] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(team['logo']))
                        : const CircleAvatar(
                            child: Icon(Icons.shield, size: 12)),
                    label: Text((team['short_name']?.isNotEmpty == true)
                        ? team['short_name']
                        : (team['name']?.isNotEmpty == true
                            ? team['name']
                            : 'Team')),
                    onDeleted: () => _removeTeam(team),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 80, maxWidth: 200),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search...',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
