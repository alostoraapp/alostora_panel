// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart' as intl;

// 🌎 Project imports:
import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/theme/theme.dart';

class OverallRevenueChart extends StatelessWidget {
  const OverallRevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;
    final _locale = Localizations.localeOf(context);
    final lang = l.S.of(context);
    final _mqSize = MediaQuery.of(context).size;

    final _titles = {
      0: lang.Jan,
      1: lang.Feb,
      2: lang.Mar,
      3: lang.Apr,
      4: lang.May,
      5: lang.Jun,
      6: lang.Jul,
      7: lang.Aug,
      8: lang.Sept,
      9: lang.Oct,
      10: lang.Nov,
      11: lang.Dec,
    };

    const _totalWithdrawColor = AcnooAppColors.kSuccess;

    final _values = {
      01: 60,
      03: 72,
      06: 25,
      10: 67,
      13: 80,
      16: 38,
      19: 63,
      22: 40,
      25: 75,
      27: 36,
      30: 64,
      31: 45,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Wrap(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: '● ',
                        style: TextStyle(color: _totalWithdrawColor),
                      ),
                      TextSpan(
                        // text: "Withdraw: ",
                        text: "${lang.totalIncome}: ",
                        style: TextStyle(
                          color: _isDark
                              ? _theme.colorScheme.onPrimaryContainer
                              : const Color(0xff667085),
                        ),
                      ),
                      TextSpan(
                        text: " \$900",
                        style: TextStyle(
                          color: _isDark
                              ? _theme.colorScheme.onPrimaryContainer
                              : const Color(0xff344054),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 81,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false, // Remove vertical grid lines
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: AcnooAppColors.kNeutral300,
                        strokeWidth: 1,
                        dashArray: [3, 3], // Add dash array for dotted line
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      maxContentWidth: 240,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final _date = (
                          groupIndex <= 0
                              ? _values.keys.toList()[groupIndex]
                              : _values.keys.toList()[groupIndex - 1],
                          _values.keys.toList()[groupIndex],
                        );

                        final _value = intl.NumberFormat.simpleCurrency(
                          decimalDigits: 0,
                          locale: _locale.countryCode,
                        ).format(rod.toY);

                        return BarTooltipItem(
                          "${_date.$1}-${_date.$2} ${lang.Jun} 2024\n${l.S.current.withdraw}: $_value",
                          _theme.textTheme.bodyMedium!,
                        );
                      },
                      tooltipBorderRadius: BorderRadius.circular(4),
                      getTooltipColor: (touchedSpot) {
                        return _isDark
                            ? _theme.colorScheme.tertiaryContainer
                            : Colors.white;
                      },
                    ),
                  ),
                  barGroups: List.generate(
                    _values.length,
                    (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: _values.values.toList()[index].toDouble(),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff69FEA0),
                                Color(0xff16A34A),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles: _getTitlesData(context, show: false),
                    rightTitles: _getTitlesData(context, show: false),
                    leftTitles: _getTitlesData(
                      context,
                      reservedSize: 40,
                      interval: 20,
                      getTitlesWidget: (value, titleMeta) {
                        const titlesMap = {
                          0: '0',
                          20: '20k',
                          40: '40k',
                          60: '60k',
                          80: '80k',
                        };
                        return Text(
                          titlesMap[value.toInt()] ?? '',
                          style: _theme.textTheme.bodyMedium?.copyWith(
                            color: _theme.colorScheme.onTertiary,
                          ),
                        );
                      },
                    ),
                    bottomTitles: _getTitlesData(
                      context,
                      interval: 1,
                      reservedSize: 28,
                      getTitlesWidget: (value, titleMeta) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          child: Transform.rotate(
                            angle: _mqSize.width < 480
                                ? (-45 * (3.1416 / 180))
                                : 0,
                            child: Text(
                              _titles[value.toInt()] ?? '',
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                color: _theme.colorScheme.onTertiary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  AxisTitles _getTitlesData(
    BuildContext context, {
    bool show = true,
    Widget Function(double value, TitleMeta titleMeta)? getTitlesWidget,
    double reservedSize = 22,
    double? interval,
  }) {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: show,
        getTitlesWidget: getTitlesWidget ?? defaultGetTitle,
        reservedSize: reservedSize,
        interval: interval,
      ),
    );
  }
}
