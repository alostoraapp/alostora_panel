// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../../../generated/l10n.dart' as l;
// 🌎 Project imports:
import '../../../../../core/theme/theme.dart';

class AttendanceInspectionChart extends StatelessWidget {
  const AttendanceInspectionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;
    final lang = l.S.of(context);

    const _employeeColor = AcnooAppColors.kInfo;
    const _studentColor = AcnooAppColors.kSuccess;

    final _values = {
      "01 ${lang.Jan}": 60000,
      "02 ${lang.Jan}": 72000,
      "03 ${lang.Jan}": 25000,
      "04 ${lang.Jan}": 67000,
      "05 ${lang.Jan}": 80000,
      "06 ${lang.Jan}": 38000,
      "07 ${lang.Jan}": 63000,
      "08 ${lang.Jan}": 40000,
      "09 ${lang.Jan}": 75000,
      "10 ${lang.Jan}": 36000,
      "11 ${lang.Jan}": 64000,
      "12 ${lang.Jan}": 45000,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final _size = constraints.biggest;
        final _showCompact = _size.width < 400;

        return Column(
          children: [
            Wrap(
              children: [
                _buildIndicator(title: lang.employee, color: _employeeColor),
                const SizedBox(width: 16),
                _buildIndicator(title: lang.student, color: _studentColor),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 80100,
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        dashArray: [5, 3, 0],
                        strokeWidth: 1,
                        color: _theme.colorScheme.outline,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      maxContentWidth: 240,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final _barRods = group.barRods;
                        final lang = l.S.of(context);

                        num _freeUsers =
                            _barRods.isNotEmpty ? _barRods.first.toY : 0;
                        num _subscribedUsers =
                            _barRods.length > 1 ? _barRods[1].toY : 0;

                        String _groupLabel = _values.keys.toList()[groupIndex];

                        return BarTooltipItem(
                          '',
                          textAlign: TextAlign.start,
                          children: [
                            TextSpan(
                              text: "$_groupLabel 2024\n",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '● ',
                                  style: TextStyle(color: _employeeColor),
                                ),
                                TextSpan(text: '${lang.free}: '),
                                TextSpan(
                                  text:
                                      "${intl.NumberFormat.compact().format(_freeUsers)}\n",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '● ',
                                  style: TextStyle(color: _studentColor),
                                ),
                                //const TextSpan(text: 'Subscribe: '),
                                TextSpan(text: '${lang.subscribe}: '),
                                TextSpan(
                                  text: intl.NumberFormat.compact()
                                      .format(_subscribedUsers),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
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
                          _getBarChartRodData(
                            context,
                            toY: _values.values.toList()[index].toDouble(),
                            color: _employeeColor,
                          ),
                          _getBarChartRodData(
                            context,
                            toY: (_values.values.toList()[index] - 15000)
                                .toDouble(),
                            color: _studentColor,
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
                      reservedSize: 34,
                      interval: 20000,
                      getTitlesWidget: (value, titleMeta) {
                        const titlesMap = {
                          0: '0',
                          20000: '20k',
                          40000: '40k',
                          60000: '60k',
                          80000: '80k',
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
                          padding: const EdgeInsetsDirectional.only(top: 8),
                          child: Transform.rotate(
                            angle: _showCompact ? (-55 * (3.1416 / 180)) : 0,
                            child: Text(
                              _values.keys.toList()[value.toInt()],
                              textDirection: TextDirection.ltr,
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                color: _theme.colorScheme.onTertiary,
                                fontSize: _showCompact ? 12 : null,
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

  BarChartRodData _getBarChartRodData(
    BuildContext context, {
    required double toY,
    Color? color,
  }) {
    final _mqSize = MediaQuery.sizeOf(context);

    return BarChartRodData(
      toY: toY,
      color: color,
      width: _mqSize.width < 375
          ? 4
          : _mqSize.width < 480
              ? 6
              : _mqSize.width < 768
                  ? 8
                  : 12,
    );
  }

  Widget _buildIndicator({Color? color, required String title}) {
    return Builder(builder: (context) {
      final _theme = Theme.of(context);
      final _isDark = _theme.brightness == Brightness.dark;

      return Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                constraints: BoxConstraints.tight(Size.square(8)),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsetsDirectional.only(end: 4),
              ),
            ),
            TextSpan(
              text: title,
              style: TextStyle(
                color: _isDark
                    ? _theme.colorScheme.onPrimaryContainer
                    : const Color(0xff667085),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
