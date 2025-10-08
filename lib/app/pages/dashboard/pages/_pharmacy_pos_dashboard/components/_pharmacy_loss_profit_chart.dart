import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../../generated/l10n.dart' as l;

class PharmacyLossProfitChart extends StatelessWidget {
  const PharmacyLossProfitChart({super.key});

  @override
  Widget build(BuildContext context) {
    final _mqSize = MediaQuery.of(context).size.width;
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;
    final _lang = l.S.of(context);

    const _profitColor1 = Color(0xff2BB2FE);
    const _profitColor2 = Color(0xff22CAAD);
    const _lossColor1 = Color(0xffF86624);
    const _lossColor2 = Color(0xffF9C80E);

    final _values = {
      _lang.Jan: 60000,
      _lang.Feb: 72000,
      _lang.Mar: 25000,
      _lang.Apr: 67000,
      _lang.May: 80000,
      _lang.Jun: 38000,
      _lang.Jul: 63000,
      _lang.Aug: 40000,
      _lang.Sept: 75000,
      _lang.Oct: 36000,
      _lang.Nov: 64000,
      _lang.Dec: 45000,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final _size = constraints.biggest;
        final _showCompact = _size.width < 400;

        return Column(
          children: [
            _mqSize > 768
                ? Text('')
                : Column(
                    children: [
                      Wrap(
                        children: [
                          BuildIndicator(
                            title: '${_lang.profit}: ',
                            color: [_profitColor1, _profitColor2],
                            amount: '1.5k',
                          ),
                          const SizedBox(width: 16),
                          BuildIndicator(
                            title: '${_lang.loss}: ',
                            color: [_lossColor1, _lossColor2],
                            amount: '\$800',
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
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
                        String _groupLabel = _values.keys.toList()[groupIndex];
                        return BarTooltipItem(
                          '',
                          textAlign: TextAlign.start,
                          children: [
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
                                  style: TextStyle(color: _profitColor1),
                                ),
                                TextSpan(text: '${_lang.profit}: '),
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
                                  style: TextStyle(color: _lossColor1),
                                ),
                                //const TextSpan(text: 'Subscribe: '),
                                TextSpan(text: '${_lang.loss}: '),
                                TextSpan(
                                    text: '\$300',
                                    style:
                                        _theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    )),
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
                            colors: [_profitColor2, _profitColor1],
                          ),
                          _getBarChartRodData(context,
                              toY: (_values.values.toList()[index] - 15000)
                                  .toDouble(),
                              colors: [_lossColor2, _lossColor1]),
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
    required List<Color> colors,
  }) {
    final _mqSize = MediaQuery.sizeOf(context);

    return BarChartRodData(
      toY: toY,
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      width: _mqSize.width < 375
          ? 4
          : _mqSize.width < 480
              ? 6
              : _mqSize.width < 768
                  ? 8
                  : 12,
    );
  }
}

class BuildIndicator extends StatelessWidget {
  const BuildIndicator({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
  });

  final List<Color> color;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
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
                  gradient: LinearGradient(
                    colors: color,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsetsDirectional.only(end: 4),
              ),
            ),
            TextSpan(
              text: '$title: ',
              style: TextStyle(
                color: _isDark
                    ? _theme.colorScheme.onPrimaryContainer
                    : const Color(0xff667085),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: amount,
              style: _theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
