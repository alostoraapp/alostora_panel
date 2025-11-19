import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/s.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/competition_search_entity.dart';
import '../bloc/search_competitions/search_competitions_bloc.dart';
import '../bloc/search_competitions/search_competitions_event.dart';
import '../bloc/search_competitions/search_competitions_state.dart';

class CompetitionSearchDropdown extends StatefulWidget {
  final ValueChanged<CompetitionSearchEntity> onSelected;

  const CompetitionSearchDropdown({super.key, required this.onSelected});

  @override
  State<CompetitionSearchDropdown> createState() => _CompetitionSearchDropdownState();
}

class _CompetitionSearchDropdownState extends State<CompetitionSearchDropdown> {
  final SearchCompetitionsBloc _bloc = sl<SearchCompetitionsBloc>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  CompetitionSearchEntity? _selectedCompetition;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _hideOverlay();
    _focusNode.removeListener(_onFocusChanged);
    _controller.removeListener(_onTextChanged);
    _scrollController.removeListener(_onScroll);
    _focusNode.dispose();
    _controller.dispose();
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _showOverlay();
      if (_controller.text.isEmpty && _selectedCompetition == null) {
         _bloc.add(const SearchCompetitionsQueryChanged('')); // Trigger initial load or empty state
      }
    } else {
      // Delay hiding to allow tap on item
      Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted && !_focusNode.hasFocus) {
              _hideOverlay();
          }
      });
    }
  }

  void _onTextChanged() {
    if (_focusNode.hasFocus) {
      _bloc.add(SearchCompetitionsQueryChanged(_controller.text));
      if (_overlayEntry == null) {
          _showOverlay();
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      _bloc.add(const LoadMoreCompetitions());
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final RenderBox renderBox = this.context.findRenderObject() as RenderBox;
        final size = renderBox.size;
        final offset = renderBox.localToGlobal(Offset.zero);
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height;
        final paddingBottom = mediaQuery.viewInsets.bottom;

        const double maxDropdownHeight = 300.0;
        final double spaceBelow = screenHeight - paddingBottom - (offset.dy + size.height);
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
            followerAnchor: showAbove ? Alignment.bottomLeft : Alignment.topLeft,
            offset: showAbove ? const Offset(0.0, -5.0) : const Offset(0.0, 5.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: visibleMaxHeight),
                child: BlocBuilder<SearchCompetitionsBloc, SearchCompetitionsState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state.status == SearchCompetitionsStatus.loading && state.competitions.isEmpty) {
                      return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()));
                    }

                    if (state.status == SearchCompetitionsStatus.failure && state.competitions.isEmpty) {
                       return Padding(
                         padding: const EdgeInsets.all(16.0),
                         child: Text(state.errorMessage ?? 'Error'),
                       );
                    }

                    if (state.competitions.isEmpty && state.query.isNotEmpty && state.status != SearchCompetitionsStatus.loading) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(S.of(context).noResultsFound),
                        );
                    }
                    
                    if (state.competitions.isEmpty && state.query.isEmpty) {
                         return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(S.of(context).typeToSearch),
                        );
                    }


                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: state.hasReachedMax ? state.competitions.length : state.competitions.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.competitions.length) {
                          return const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(strokeWidth: 2)));
                        }

                        final competition = state.competitions[index];
                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: competition.logo,
                            width: 32,
                            height: 32,
                            placeholder: (context, url) => const CircleAvatar(radius: 16, backgroundColor: Colors.grey),
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                          ),
                          title: Text(competition.name),
                          onTap: () {
                            setState(() {
                              _selectedCompetition = competition;
                              _controller.text = competition.name;
                            });
                            widget.onSelected(competition);
                            _hideOverlay();
                            _focusNode.unfocus();
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: S.of(context).searchCompetition,
          border: const OutlineInputBorder(),
          prefixIcon: _selectedCompetition != null 
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                    imageUrl: _selectedCompetition!.logo,
                    width: 24,
                    height: 24,
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
              )
              : const Icon(Icons.search),
           suffixIcon: _selectedCompetition != null || _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _selectedCompetition = null;
                    });
                     _bloc.add(const SearchCompetitionsQueryChanged(''));
                  },
                )
              : null,
        ),
      ),
    );
  }
}
