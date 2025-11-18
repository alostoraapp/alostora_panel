import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../widgets/match_tile.dart';

class MatchTilesScreen extends StatefulWidget {
  const MatchTilesScreen({super.key});

  @override
  State<MatchTilesScreen> createState() => _MatchTilesScreenState();
}

class _MatchTilesScreenState extends State<MatchTilesScreen> {
  bool _isLiveSelected = true;
  DateTime _selectedDate = DateTime.now();

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _TimePickerCard(
            isLiveSelected: _isLiveSelected,
            selectedDate: _selectedDate,
            onLiveSelected: (isSelected) {
              setState(() => _isLiveSelected = isSelected);
            },
            onDateChanged: _onDateChanged,
          ),
          const SizedBox(height: 16),
          _buildMatchesList(context),
        ],
      ),
    );
  }

  Widget _buildMatchesList(BuildContext context) {
    final List<Widget> matches = List.generate(4, (index) {
      return const MatchTile(
        homeTeam: 'Barcelona',
        awayTeam: 'Sevilla',
        score: '0 - 0',
        status: "23'",
        homeTeamLogo: 'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png',
        awayTeamLogo: 'https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Sevilla_FC_logo.svg/1200px-Sevilla_FC_logo.svg.png',
      );
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoints = ResponsiveBreakpoints.of(context);
        final int crossAxisCount = breakpoints.equals('4K') ? 3 : (breakpoints.isDesktop ? 2 : 1);
        const double itemHeight = 110.0;
        const double crossAxisSpacing = 16;

        final double itemWidth = (constraints.maxWidth - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;

        final double childAspectRatio = itemWidth > 0 ? itemWidth / itemHeight : 1.0;

        return GridView.builder(
          itemCount: matches.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio, 
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return matches[index];
          },
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
              ),
              child: Text(s.live),
            )
          : OutlinedButton(
              onPressed: () => onLiveSelected(true),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(s.live),
            ),
    );

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 3, child: liveButton),
            const SizedBox(width: 16),
            Flexible(
              flex: 5,
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
            const SizedBox(width: 16),
            Flexible(
              flex: 2,
              child: SizedBox(
                height: buttonHeight,
                child: IconButton(
                  icon: SvgPicture.asset(AppIcons.calendar, colorFilter: ColorFilter.mode(theme.colorScheme.onPrimary, BlendMode.srcIn)),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    fixedSize: const Size(50, 50)
                  ),
                  onPressed: () => _showDatePicker(context, theme),
                ),
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
