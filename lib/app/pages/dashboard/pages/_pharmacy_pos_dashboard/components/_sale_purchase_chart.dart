// 🐦 Flutter imports:
import 'package:flutter/material.dart';
// 🌎 Project imports:
import '_pharmacy_loss_profit_chart.dart';
// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../../../generated/l10n.dart' as l;

class SalePurchaseChart extends StatelessWidget {
  const SalePurchaseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;
    final _lang = l.S.of(context);
    final _mqSize = MediaQuery.sizeOf(context);

    final _xTitles = {
      1: _lang.Jan,
      2: _lang.Feb,
      3: _lang.Mar,
      4: _lang.Apr,
      5: _lang.May,
      6: _lang.Jun,
      7: _lang.Jul,
      8: _lang.Aug,
      9: _lang.Sept,
      10: _lang.Oct,
      11: _lang.Nov,
      12: _lang.Dec,
    };

    const _purchaseColor = Color(0xff2BB2FE);
    const _salesColor = Color(0xffF86624);
    const _remainingColor = Color(0xff2BB2FE);

    return Column(
      children: [
        _mqSize.width > 768
            ? Text('')
            : Column(
                children: [
                  Wrap(
                    children: [
                      BuildIndicator(
                        title: '${_lang.profit}: ',
                        color: [_purchaseColor, _purchaseColor],
                        amount: '\$800',
                      ),
                      const SizedBox(width: 16),
                      BuildIndicator(
                        title: '${_lang.loss}: ',
                        color: [_salesColor, _salesColor],
                        amount: '1.5k',
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                ],
              ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LineChart(
              LineChartData(
                minX: 1,
                maxX: 12,
                minY: 0,
                maxY: 60100,
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
                            const FlLine(color: Colors.transparent),
                            FlDotData(
                              getDotPainter: (p0, p1, p2, p3) {
                                return FlDotCirclePainter(
                                  color: p2.color ?? Colors.transparent,
                                  strokeWidth: 2.5,
                                  strokeColor: Colors.white,
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
                        int groupIndex = item.spotIndex;
                        String _groupLabel =
                            _xTitles.values.toList()[groupIndex];
                        return LineTooltipItem(
                          '',
                          _theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                          children: [
                            // if (item.barIndex == 0)
                            //   TextSpan(
                            //     text: "${_xTitles[item.barIndex + 1]} ${NumberFormat.currency(decimalDigits: 0, customPattern: '', symbol: '').format(DateTime.now().year)}\n",
                            //   ),
                            TextSpan(
                              text: "$_groupLabel 2025\n",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '● ',
                                  style: TextStyle(color: _purchaseColor),
                                ),
                                TextSpan(text: '${_lang.purchase}: '),
                                TextSpan(
                                  text: "\$1.2k\n",
                                  style: _theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '● ',
                                  style: TextStyle(color: _salesColor),
                                ),
                                TextSpan(text: '${_lang.sales}: '),
                                TextSpan(
                                    text: '\$300',
                                    style:
                                        _theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            )
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
                      FlSpot(1, 22000), // Jan
                      FlSpot(2, 31000), // Feb
                      FlSpot(3, 45000), // Mar - peak
                      FlSpot(4, 39000), // Apr
                      FlSpot(5, 27000), // May - dip
                      FlSpot(6, 32000), // Jun
                      FlSpot(7, 17000), // Jul - lowest point
                      FlSpot(8, 26000), // Aug
                      FlSpot(9, 29000), // Sep
                      FlSpot(10, 21000), // Oct
                      FlSpot(11, 25000), // Nov
                      FlSpot(12, 20000), // Dec
                    ],
                    isCurved: true,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    color: _salesColor,
                    belowBarData: BarAreaData(
                      show: true,
                      applyCutOffY: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [100, 80],
                        tileMode: TileMode.decal,
                        colors: [
                          _salesColor.withValues(alpha: 0.075),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                  LineChartBarData(
                    spots: const [
                      FlSpot(1, 14000), // Jan
                      FlSpot(2, 19000), // Feb
                      FlSpot(3, 25000), // Mar - slight peak
                      FlSpot(4, 23000), // Apr
                      FlSpot(5, 15000), // May
                      FlSpot(6, 12000), // Jun - dip
                      FlSpot(7, 30000), // Jul - high peak
                      FlSpot(8, 36000), // Aug
                      FlSpot(9, 34000), // Sep
                      FlSpot(10, 28000), // Oct
                      FlSpot(11, 27000), // Nov
                      FlSpot(12, 19000), // Dec
                    ],
                    isCurved: true,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    color: _remainingColor,
                    belowBarData: BarAreaData(
                      show: true,
                      applyCutOffY: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [100, 80],
                        tileMode: TileMode.decal,
                        colors: [
                          _remainingColor.withValues(alpha: 0.15),
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
                        padding: const EdgeInsetsDirectional.only(
                          top: 8,
                          end: 24,
                        ),
                        child: Transform.rotate(
                          angle:
                              _mqSize.width < 480 ? (-45 * (3.1416 / 180)) : 0,
                          child: Text(
                            _xTitles[value.toInt()] ?? '',
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

  String _getFormattedNumber(num value) {
    return intl.NumberFormat.simpleCurrency().format(value);
  }

  Widget _buildIndicator({
    Color? color,
    required String title,
    required num value,
  }) {
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
              ),
            ),
            TextSpan(
              text: " $title: ",
              style: TextStyle(
                color: _isDark
                    ? _theme.colorScheme.onPrimaryContainer
                    : const Color(0xff667085),
              ),
            ),
            TextSpan(
              text: value.toString(),
              style: TextStyle(
                color: _isDark
                    ? _theme.colorScheme.onPrimaryContainer
                    : const Color(0xff344054),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
