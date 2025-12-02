import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/s.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/tv_channel_entity.dart';
import '../../domain/usecases/search_tv_channels_usecase.dart';

class TvChannelSearchDropdown extends StatefulWidget {
  final TvChannelEntity? initialSelection;
  final ValueChanged<TvChannelEntity?> onSelected;

  const TvChannelSearchDropdown({
    super.key,
    this.initialSelection,
    required this.onSelected,
  });

  @override
  State<TvChannelSearchDropdown> createState() =>
      _TvChannelSearchDropdownState();
}

class _TvChannelSearchDropdownState extends State<TvChannelSearchDropdown> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final LayerLink _layerLink = LayerLink();
  final SearchTvChannelsUseCase _searchTvChannelsUseCase = sl();

  OverlayEntry? _overlayEntry;
  List<TvChannelEntity> _options = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  Timer? _debounce;
  String _lastQuery = '';

  // Unique ID to group the TextField and the Overlay together
  final String _tapRegionGroupId = "TvChannelSearchGroup";

  @override
  void initState() {
    super.initState();
    if (widget.initialSelection != null) {
      _controller.text = widget.initialSelection!.name;
    }
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _hideOverlay();
    _focusNode.removeListener(_onFocusChanged);
    _controller.removeListener(_onSearchChanged);
    _scrollController.removeListener(_onScroll);
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _showOverlay();
      if (_options.isEmpty && !_isLoading) {
        _loadChannels();
      }
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _controller.text;
      // If the text matches the selected item, don't search
      if (widget.initialSelection != null &&
          query == widget.initialSelection!.name) {
        return;
      }
      if (query != _lastQuery) {
        _page = 1;
        _options.clear();
        _hasMore = true;
        _lastQuery = query;
        _loadChannels();
      } else if (_options.isEmpty && !_isLoading) {
        // If query is same but options are empty (e.g. reopened), reload
        _loadChannels();
      }
    });
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9) {
      _loadChannels();
    }
  }

  Future<void> _loadChannels() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    // Update overlay if it exists to show loading indicator
    _overlayEntry?.markNeedsBuild();

    final result = await _searchTvChannelsUseCase(
        SearchTvChannelsParams(query: _lastQuery, page: _page));

    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _overlayEntry?.markNeedsBuild();
        }
      },
      (channels) {
        if (mounted) {
          setState(() {
            if (channels.isEmpty) {
              _hasMore = false;
            } else {
              _options.addAll(channels);
              _page++;
              // If we received fewer items than a typical page (e.g., 10), assume no more
              if (channels.length < 10) {
                _hasMore = false;
              }
            }
            _isLoading = false;
          });
          _overlayEntry?.markNeedsBuild();
        }
      },
    );
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final RenderBox renderBox =
            this.context.findRenderObject() as RenderBox;
        final size = renderBox.size;
        final offset = renderBox.localToGlobal(Offset.zero);
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height;
        final paddingBottom = mediaQuery.viewInsets.bottom;

        const double maxDropdownHeight = 300.0;
        final double spaceBelow =
            screenHeight - paddingBottom - (offset.dy + size.height);
        final double spaceAbove = offset.dy;

        bool showAbove = false;
        if (spaceBelow < maxDropdownHeight && spaceAbove > spaceBelow) {
          showAbove = true;
        }

        final double visibleMaxHeight = showAbove
            ? (spaceAbove - 10).clamp(50.0, maxDropdownHeight).toDouble()
            : (spaceBelow - 10).clamp(50.0, maxDropdownHeight).toDouble();

        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: showAbove ? Alignment.topLeft : Alignment.bottomLeft,
            followerAnchor:
                showAbove ? Alignment.bottomLeft : Alignment.topLeft,
            offset:
                showAbove ? const Offset(0.0, -5.0) : const Offset(0.0, 5.0),
            child: TapRegion(
              groupId: _tapRegionGroupId,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: visibleMaxHeight),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: _buildListView(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildListView() {
    if (_isLoading && _options.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_options.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(S.of(context).noResultsFound),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: _options.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _options.length) {
          if (_hasMore) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }

        final channel = _options[index];
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: channel.logo,
            width: 30,
            height: 30,
            placeholder: (context, url) => const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.tv),
          ),
          title: Text(channel.name),
          onTap: () {
            _controller.text = channel.name;
            widget.onSelected(channel);
            _hideOverlay();
            _focusNode.unfocus();
          },
        );
      },
    );
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TapRegion(
        groupId: _tapRegionGroupId,
        onTapOutside: (event) {
          _hideOverlay();
          _focusNode.unfocus();
        },
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: S.of(context).tvChannel,
            border: const OutlineInputBorder(),
            suffixIcon: _isLoading && _options.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      if (_overlayEntry == null) {
                        _focusNode.requestFocus();
                      } else {
                        _hideOverlay();
                        _focusNode.unfocus();
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
