import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../core/presentation/widgets/error_view.dart';
import '../../../matches/domain/entities/competition_entity.dart';
import '../../../matches/presentation/bloc/matches_bloc.dart';
import '../../../matches/presentation/bloc/matches_event.dart';
import '../../../matches/presentation/bloc/matches_state.dart';
import '../../../matches/presentation/widgets/match_tile.dart';

class MatchSelectionScreen extends StatefulWidget {
  const MatchSelectionScreen({super.key});

  @override
  State<MatchSelectionScreen> createState() => _MatchSelectionScreenState();
}

class _MatchSelectionScreenState extends State<MatchSelectionScreen> {
  final _searchController = TextEditingController();
  String _ordering = 'importance';
  bool _isLive = false;

  @override
  void initState() {
    super.initState();
    final matchesBloc = context.read<MatchesBloc>();
    if (matchesBloc.state is MatchesInitial) {
      matchesBloc.add(const GetMatches());
    }
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _fetchMatches();
  }

  void _fetchMatches() {
    context.read<MatchesBloc>().add(GetMatches(
          search:
              _searchController.text.isNotEmpty ? _searchController.text : null,
          ordering: _ordering,
          isLive: _isLive,
        ));
  }

  void _onDateChanged(DateTime newDate) {
    context.read<MatchesBloc>().add(ChangeDate(newDate));
  }

  void _onOrderingChanged(String? newOrdering) {
    if (newOrdering != null && _ordering != newOrdering) {
      setState(() {
        _ordering = newOrdering;
      });
      _fetchMatches();
    }
  }

  void _onLiveFilterChanged(bool isSelected) {
    if (_isLive != isSelected) {
      setState(() {
        _isLive = isSelected;
      });
      _fetchMatches();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MatchesBloc, MatchesState>(
      builder: (context, state) {
        final selectedDate = state.selectedDate ?? DateTime.now();

        final timePicker = _TimePickerCard(
          isLiveSelected: _isLive,
          selectedDate: selectedDate,
          onLiveSelected: _onLiveFilterChanged,
          onDateChanged: _onDateChanged,
        );

        final searchCard = _SearchCard(
          controller: _searchController,
          ordering: _ordering,
          onOrderingChanged: _onOrderingChanged,
        );

        final refreshButton = Card(
          elevation: 2,
          shadowColor: Colors.black12,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: _fetchMatches,
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 64,
              child: Center(
                child: Icon(
                  Icons.refresh,
                  size: 24,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Select Related Match'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  final bool useWideLayout = constraints.maxWidth > 700;
                  if (useWideLayout) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: timePicker),
                        const SizedBox(width: 16),
                        Expanded(child: searchCard),
                        const SizedBox(width: 16),
                        refreshButton,
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        timePicker,
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: searchCard),
                            const SizedBox(width: 8),
                            refreshButton,
                          ],
                        ),
                      ],
                    );
                  }
                }),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => _fetchMatches(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: state is MatchesLoading
                        ? _buildShimmerList()
                        : state is MatchesLoaded
                            ? _buildMatchesList(context, state.competitions)
                            : state is MatchesError
                                ? ErrorView(
                                    message: state.message,
                                    onRetry: _fetchMatches,
                                  )
                                : _buildShimmerList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMatchesList(
      BuildContext context, List<CompetitionEntity> competitions) {
    if (competitions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(S.of(context).noMatchesFound,
              style: Theme.of(context).textTheme.titleMedium),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 32),
      itemCount: competitions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final competition = competitions[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CompetitionHeader(
              name: competition.shortName,
              logoUrl: competition.logo,
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final double availableWidth = constraints.maxWidth;
                final int crossAxisCount =
                    (availableWidth / 400).floor().clamp(1, 3);

                const double itemHeight = 110.0;
                const double crossAxisSpacing = 16;

                final double itemWidth = (availableWidth -
                        (crossAxisSpacing * (crossAxisCount - 1))) /
                    crossAxisCount;
                final double childAspectRatio =
                    itemWidth > 0 ? itemWidth / itemHeight : 1.0;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: competition.matches.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, idx) {
                    final match = competition.matches[idx];
                    return MatchTile(
                      match: match,
                      onTap: () => Navigator.pop(context, match),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _CompetitionHeaderShimmer(),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final double availableWidth = constraints.maxWidth;
              final int crossAxisCount =
                  (availableWidth / 400).floor().clamp(1, 3);

              const double itemHeight = 110.0;
              const double crossAxisSpacing = 16;

              final double itemWidth =
                  (availableWidth - (crossAxisSpacing * (crossAxisCount - 1))) /
                      crossAxisCount;
              final double childAspectRatio =
                  itemWidth > 0 ? itemWidth / itemHeight : 1.0;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: crossAxisCount * 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, idx) => const MatchTileShimmer(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimePickerCard extends StatelessWidget {
  final bool isLiveSelected;
  final DateTime selectedDate;
  final ValueChanged<bool> onLiveSelected;
  final ValueChanged<DateTime> onDateChanged;

  const _TimePickerCard({
    required this.isLiveSelected,
    required this.selectedDate,
    required this.onLiveSelected,
    required this.onDateChanged,
  });

  String _getDateText(BuildContext context, DateTime date) {
    final s = S.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (DateUtils.isSameDay(date, today)) return s.today;
    if (DateUtils.isSameDay(date, today.add(const Duration(days: 1))))
      return s.tomorrow;
    if (DateUtils.isSameDay(date, today.subtract(const Duration(days: 1))))
      return s.yesterday;
    return DateFormat('yyyy/MM/dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final isRtl = context.read<LanguageCubit>().isRTL();

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            SizedBox(
              height: 40,
              child: isLiveSelected
                  ? ElevatedButton(
                      onPressed: () => onLiveSelected(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(s.liveFilter),
                    )
                  : OutlinedButton(
                      onPressed: () => onLiveSelected(true),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(s.liveFilter),
                    ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    isRtl ? AppIcons.angleSmallRight : AppIcons.angleSmallLeft,
                    colorFilter: ColorFilter.mode(
                        theme.iconTheme.color!, BlendMode.srcIn),
                  ),
                  onPressed: () => onDateChanged(
                      selectedDate.subtract(const Duration(days: 1))),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_getDateText(context, selectedDate),
                        style: theme.textTheme.bodySmall),
                    Text(DateFormat('MM/dd').format(selectedDate),
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    isRtl ? AppIcons.angleSmallLeft : AppIcons.angleSmallRight,
                    colorFilter: ColorFilter.mode(
                        theme.iconTheme.color!, BlendMode.srcIn),
                  ),
                  onPressed: () =>
                      onDateChanged(selectedDate.add(const Duration(days: 1))),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: SvgPicture.asset(AppIcons.calendar,
                  colorFilter: ColorFilter.mode(
                      theme.colorScheme.onPrimary, BlendMode.srcIn)),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _showDatePicker(context, theme),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 350,
          height: 400,
          padding: const EdgeInsets.all(16),
          child: SfDateRangePicker(
            initialSelectedDate: selectedDate,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.single,
            onSelectionChanged: (args) {
              if (args.value is DateTime) {
                onDateChanged(args.value);
                Navigator.pop(context);
              }
            },
            headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: theme.textTheme.titleMedium,
            ),
            selectionColor: theme.colorScheme.primary,
            todayHighlightColor: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  final TextEditingController controller;
  final String ordering;
  final ValueChanged<String?> onOrderingChanged;

  const _SearchCard({
    required this.controller,
    required this.ordering,
    required this.onOrderingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            SvgPicture.asset(AppIcons.search,
                width: 20,
                height: 20,
                colorFilter:
                    ColorFilter.mode(theme.hintColor, BlendMode.srcIn)),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: s.search,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: theme.hintColor),
                ),
              ),
            ),
            DropdownButton<String>(
              value: ordering,
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(
                    value: 'importance', child: Text(s.sortByImportance)),
                DropdownMenuItem(value: 'time', child: Text(s.sortByTime)),
              ],
              onChanged: onOrderingChanged,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompetitionHeader extends StatelessWidget {
  final String logoUrl;
  final String name;

  const _CompetitionHeader({required this.logoUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 1,
      color: isDark ? const Color(0xFF1B2131) : const Color(0xFF37373f),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: logoUrl,
              width: 24,
              height: 24,
              placeholder: (_, __) =>
                  const CircularProgressIndicator(strokeWidth: 2),
              errorWidget: (_, __, ___) => const Icon(Icons.sports_soccer,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompetitionHeaderShimmer extends StatelessWidget {
  const _CompetitionHeaderShimmer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Card(
        color: isDark ? const Color(0xFF1B2131) : const Color(0xFF37373f),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.zero,
        child: Container(height: 48),
      ),
    );
  }
}
