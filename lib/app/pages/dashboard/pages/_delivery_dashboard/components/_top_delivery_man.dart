// 🐦 Flutter imports:
// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart' as l;
// 🌎 Project imports:
import '../../../../../core/theme/theme.dart';

class TopDeliveryManComponents extends StatefulWidget {
  const TopDeliveryManComponents({super.key});

  @override
  State<StatefulWidget> createState() => TopDeliveryManComponentsState();
}

class TopDeliveryManComponentsState extends State<TopDeliveryManComponents> {
  int? touchedIndex;
  BarChartGroupData makeGroupData(
    BuildContext context,
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;

    final effectiveBarColor = barColor ?? AcnooAppColors.kNeutral400;
    final effectiveColor = isTouched ? _theme.primaryColor : effectiveBarColor;
    final barBg = _isDark ? AcnooAppColors.kDark3 : AcnooAppColors.kPrimary50;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: effectiveColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: _theme.colorScheme.secondary, width: 40)
              : BorderSide.none,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 80,
            color: barBg,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(BuildContext context) {
    final yValues = [23, 45, 42, 23, 22, 62, 59, 42, 32, 22, 71, 28];

    return List.generate(yValues.length, (i) {
      return makeGroupData(context, i, yValues[i].toDouble(),
          isTouched: i == touchedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = l.S.of(context);
    final _theme = Theme.of(context);
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

    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${lang.total} ',
              ),
              TextSpan(
                text: "2,450 ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: lang.delivers,
              ),
            ],
          ),
          style: _theme.textTheme.bodyLarge,
        ),
        SizedBox(height: 10),
        Expanded(
          child: BarChart(
            BarChartData(
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
                        angle: _mqSize.width < 480 ? (-45 * (3.1416 / 180)) : 0,
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
              borderData: FlBorderData(
                show: false,
                border: Border.all(
                  color: const Color(0xff37434d),
                ),
              ),
              barGroups: showingGroups(context),
              barTouchData: BarTouchData(
                touchCallback: (event, response) {
                  if (response != null && response.spot != null) {
                    setState(() {
                      touchedIndex = response.spot!.touchedBarGroupIndex;
                    });
                  } else {
                    setState(() {
                      touchedIndex = null;
                    });
                  }
                },
              ),
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
            ),
            // swapAnimationDuration: animDuration,
          ),
        ),
      ],
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
