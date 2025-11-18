import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/competition_entity.dart';
import '../bloc/matches_bloc.dart';
import '../bloc/matches_event.dart';
import '../bloc/matches_state.dart';
import '../widgets/match_tile.dart';

class MatchTilesScreen extends StatefulWidget {
  const MatchTilesScreen({super.key});

  @override
  State<MatchTilesScreen> createState() => _MatchTilesScreenState();
}

class _MatchTilesScreenState extends State<MatchTilesScreen> {
  final _matchesBloc = sl<MatchesBloc>();
  final _searchController = TextEditingController();
  String _ordering = 'importance';
  bool _isLive = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchMatches();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _matchesBloc.close();
    super.dispose();
  }

  void _onSearchChanged() {
    _fetchMatches();
  }

  void _fetchMatches() {
    final startTimestamp = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day).toUtc().millisecondsSinceEpoch ~/ 1000;
    final endTimestamp = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, 23, 59, 59).toUtc().millisecondsSinceEpoch ~/ 1000;

    _matchesBloc.add(GetMatches(
      search: _searchController.text.isNotEmpty ? _searchController.text : null,
      ordering: _ordering,
      isLive: _isLive,
      startTimestamp: startTimestamp,
      endTimestamp: endTimestamp,
    ));
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _fetchMatches();
    });
  }

  void _onOrderingChanged(String? newOrdering) {
    if (newOrdering != null) {
      setState(() {
        _ordering = newOrdering;
        _fetchMatches();
      });
    }
  }

  void _onLiveFilterChanged(bool isSelected) {
    setState(() {
      _isLive = isSelected;
      _fetchMatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    final timePicker = _TimePickerCard(
      isLiveSelected: _isLive,
      selectedDate: _selectedDate,
      onLiveSelected: _onLiveFilterChanged,
      onDateChanged: _onDateChanged,
    );

    final searchCard = _SearchCard(
      controller: _searchController,
      ordering: _ordering,
      onOrderingChanged: _onOrderingChanged,
    );

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: timePicker),
                const SizedBox(width: 16),
                Expanded(child: searchCard),
              ],
            )
          else
            Column(
              children: [
                timePicker,
                const SizedBox(height: 16),
                searchCard,
              ],
            ),
          const SizedBox(height: 16),
          BlocBuilder<MatchesBloc, MatchesState>(
            bloc: _matchesBloc,
            builder: (context, state) {
              if (state is MatchesLoading) {
                return _buildShimmerList();
              }
              if (state is MatchesLoaded) {
                return _buildMatchesList(context, state.competitions);
              }
              if (state is MatchesError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesList(BuildContext context, List<CompetitionEntity> competitions) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: competitions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final competition = competitions[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CompetitionHeader(
              name: competition.name,
              logoUrl: competition.logo,
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final breakpoints = ResponsiveBreakpoints.of(context);
                final int crossAxisCount = breakpoints.equals('4K') ? 3 : (breakpoints.isDesktop ? 2 : 1);
                const double itemHeight = 90.0;
                const double crossAxisSpacing = 16;

                final double itemWidth = (constraints.maxWidth - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;
                final double childAspectRatio = itemWidth > 0 ? itemWidth / itemHeight : 1.0;

                return GridView.builder(
                  itemCount: competition.matches.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return MatchTile(match: competition.matches[index]);
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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // Number of shimmer items
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CompetitionHeaderShimmer(),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final breakpoints = ResponsiveBreakpoints.of(context);
                final int crossAxisCount = breakpoints.equals('4K') ? 3 : (breakpoints.isDesktop ? 2 : 1);
                const double itemHeight = 90.0;
                const double crossAxisSpacing = 16;

                final double itemWidth = (constraints.maxWidth - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;
                final double childAspectRatio = itemWidth > 0 ? itemWidth / itemHeight : 1.0;

                return GridView.builder(
                  itemCount: 4, // Number of shimmer tiles per competition
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return const MatchTileShimmer();
                  },
                );
              },
            ),
          ],
        );
      },
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
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) return s.today;
    if (checkDate == tomorrow) return s.tomorrow;
    if (checkDate == yesterday) return s.yesterday;

    final difference = checkDate.difference(today).inDays;
    if (difference > 0) {
      return s.inXDays(difference);
    } else {
      return s.xDaysAgo(difference.abs());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final isRtl = context.read<LanguageCubit>().isRTL();
    const buttonHeight = 50.0;

    final liveButton = SizedBox(
      height: buttonHeight,
      child: isLiveSelected
          ? ElevatedButton(
              onPressed: () => onLiveSelected(false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: Text(s.liveFilter),
            )
          : OutlinedButton(
              onPressed: () => onLiveSelected(true),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: Text(s.liveFilter),
            ),
    );

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            liveButton,
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      isRtl ? AppIcons.angleSmallRight : AppIcons.angleSmallLeft,
                      colorFilter: ColorFilter.mode(theme.iconTheme.color!, BlendMode.srcIn),
                    ),
                    onPressed: () => onDateChanged(selectedDate.subtract(const Duration(days: 1))),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_getDateText(context, selectedDate), style: theme.textTheme.bodySmall),
                        Text(DateFormat('yyyy/MM/dd').format(selectedDate), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      isRtl ? AppIcons.angleSmallLeft : AppIcons.angleSmallRight,
                      colorFilter: ColorFilter.mode(theme.iconTheme.color!, BlendMode.srcIn),
                    ),
                    onPressed: () => onDateChanged(selectedDate.add(const Duration(days: 1))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: buttonHeight,
              width: 50,
              child: IconButton(
                icon: SvgPicture.asset(AppIcons.calendar, colorFilter: ColorFilter.mode(theme.colorScheme.onPrimary, BlendMode.srcIn)),
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => _showDatePicker(context, theme),
              ),
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
        child: SizedBox(
          width: 320,
          height: 380,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SfDateRangePicker(
              initialSelectedDate: selectedDate,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.single,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  onDateChanged(args.value);
                  Navigator.pop(context);
                }
              },
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: theme.textTheme.titleMedium,
                backgroundColor: theme.scaffoldBackgroundColor,
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: theme.textTheme.bodySmall,
                ),
              ),
              selectionTextStyle: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary),
              selectionColor: theme.colorScheme.primary,
              todayHighlightColor: theme.colorScheme.primary,
            ),
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
    final iconColor = theme.iconTheme.color;

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 74,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: s.search,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SvgPicture.asset(
                        AppIcons.search,
                        width: 20,
                        height: 20,
                        colorFilter: iconColor != null ? ColorFilter.mode(iconColor, BlendMode.srcIn) : null,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: DropdownButton<String>(
                  value: ordering,
                  underline: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(value: 'importance', child: Text(s.sortByImportance)),
                    DropdownMenuItem(value: 'time', child: Text(s.sortByTime)),
                  ],
                  onChanged: onOrderingChanged,
                ),
              ),
            ],
          ),
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
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SvgPicture.network(
                logoUrl,
                width: 24,
                height: 16,
                fit: BoxFit.cover,
                placeholderBuilder: (context) => const SizedBox(width: 24, height: 16),
              ),
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
        elevation: 1,
        color: isDark ? const Color(0xFF1B2131) : const Color(0xFF37373f),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
