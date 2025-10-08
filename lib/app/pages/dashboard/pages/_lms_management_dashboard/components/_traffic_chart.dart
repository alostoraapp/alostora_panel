// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart' as intl;

// 🌎 Project imports:
import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/static/static.dart';

class TrafficChart extends StatelessWidget {
  const TrafficChart({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;
    final _lang = l.S.of(context);

    final _totalIncomeColor = _theme.colorScheme.primary;

    final _titles = {
      1: l.S.current.direct,
      2: l.S.current.search,
      3: l.S.current.socialMedia,
      4: l.S.current.referrals,
      5: l.S.current.displayAdds,
      6: l.S.current.email,
      7: l.S.current.others,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final _size = constraints.biggest;
        return Column(
          children: [
            Wrap(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '● ',
                        style: TextStyle(
                          color: _totalIncomeColor,
                        ),
                      ),
                      TextSpan(
                        // text: "Withdraw: ",
                        text: "${_lang.totalTraffic} : ",
                        style: TextStyle(
                          color: _isDark
                              ? _theme.colorScheme.onPrimaryContainer
                              : const Color(0xff667085),
                        ),
                      ),
                      TextSpan(
                        text: " \$50,00",
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
              child: LineChart(
                LineChartData(
                  minX: 1,
                  maxX: 7,
                  minY: 0,
                  maxY: 80100,
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: _theme.colorScheme.outline,
                      dashArray: [10, 5],
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(
                    getTouchedSpotIndicator: (barData, spotIndexes) {
                      return spotIndexes
                          .map(
                            (item) => TouchedSpotIndicatorData(
                              const FlLine(
                                color: Colors.transparent,
                              ),
                              FlDotData(
                                getDotPainter: (p0, p1, p2, p3) {
                                  return FlDotCirclePainter(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                    strokeColor: p2.color ?? Colors.transparent,
                                  );
                                },
                              ),
                            ),
                          )
                          .toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      maxContentWidth: 240,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((item) {
                          final _value = intl.NumberFormat.compactCurrency(
                            decimalDigits: 4,
                            symbol: '',
                            locale: AppLocale.defaultLocale.countryCode,
                          ).format(
                            item.bar.spots[item.spotIndex].y,
                          );

                          return LineTooltipItem(
                            "",
                            _theme.textTheme.bodySmall!,
                            textAlign: TextAlign.center,
                            children: [
                              TextSpan(
                                text:
                                    '${_lang.total} ${_titles[item.spotIndex + 1]}\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              /// Text Dot Indicator [used for the replacement of a circle widget. due to the limitation of fl_chart package, LineTooltipItem class doesn't support a widget span
                              TextSpan(
                                text: " $_value",
                                style: TextStyle(
                                  color: _isDark
                                      ? _theme.colorScheme.onPrimaryContainer
                                      : const Color(0xff344054),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          );
                        }).toList();
                      },
                      tooltipBorderRadius: BorderRadius.circular(4),
                      getTooltipColor: (touchedSpot) {
                        return _isDark
                            ? _theme.colorScheme.tertiaryContainer
                            : Colors.white;
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(1, 22000),
                        FlSpot(2, 43000),
                        FlSpot(3, 30000),
                        FlSpot(4, 63000),
                        FlSpot(5, 50000),
                        FlSpot(6, 61000),
                        FlSpot(7, 70000),
                      ],
                      isCurved: true,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      color: _totalIncomeColor,
                      belowBarData: BarAreaData(
                        show: true,
                        applyCutOffY: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [100, 80],
                          tileMode: TileMode.decal,
                          colors: [
                            _totalIncomeColor.withValues(alpha: 0.075),
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: _getTitlesData(context, show: false),
                    rightTitles: _getTitlesData(context, show: false),
                    leftTitles: _getTitlesData(
                      context,
                      reservedSize: 40,
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
                          padding: const EdgeInsets.only(top: 8),
                          child: Transform.rotate(
                            angle:
                                _size.width < 470 ? (-45 * (3.1416 / 180)) : 0,
                            child: Text(
                              _titles[value.toInt()] ?? '',
                              textDirection: TextDirection.ltr,
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
