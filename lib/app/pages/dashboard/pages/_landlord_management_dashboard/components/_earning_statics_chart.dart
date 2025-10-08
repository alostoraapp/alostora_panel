import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/core.dart';
import '../../../../../widgets/dropdown_button/_dropdown_button.dart';

class EarningStaticsChart extends StatefulWidget {
  const EarningStaticsChart({super.key});

  @override
  State<EarningStaticsChart> createState() => _EarningStaticsChartState();
}

class _EarningStaticsChartState extends State<EarningStaticsChart> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final lang = l.S.of(context);
    final _mqSize = MediaQuery.of(context).size.width;

    const _freeUsersColor = AcnooAppColors.kPrimary600;
    const _subscribedUsersColor = AcnooAppColors.kWarning;

    final _values = {
      lang.Jan: 60000,
      lang.Feb: 72000,
      lang.Mar: 25000,
      lang.Apr: 67000,
      lang.May: 80000,
      lang.Jun: 38000,
      lang.Jul: 63000,
      lang.Aug: 40000,
      lang.Sept: 75000,
      lang.Oct: 36000,
      lang.Nov: 64000,
      lang.Dec: 45000,
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final _size = constraints.biggest;
        final _showCompact = _size.width < 400;

        return Column(
          children: [
            Padding(
              padding:
                  EdgeInsetsDirectional.only(start: _mqSize < 780 ? 0 : 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _theme.colorScheme.outline,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.only(end: _mqSize < 780 ? 0 : 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              lang.earningStatics,
                              style: _theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          FilterDropdownButton(),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: _mqSize < 780 ? 0 : 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20, // horizontal spacing between items
                runSpacing: 10, // vertical spacing between lines if items wrap
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        colors: const [
                          Color(0xffFFF7E0),
                          Color(0xffF2EBFF),
                        ],
                      ),
                    ),
                    child: globalRichText(
                      label: lang.currentBalance,
                      amount: '\$5.7k',
                      context: context,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize
                        .min, // important to prevent Row from expanding
                    children: [
                      SvgPicture.asset(AcnooSVGIcons.barIcon),
                      SizedBox(width: 6),
                      globalRichText(
                        label: lang.income,
                        amount: '\$2.4k',
                        context: context,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize
                        .min, // important to prevent Row from expanding
                    children: [
                      SvgPicture.asset(
                        AcnooSVGIcons.barIcon,
                        colorFilter: ColorFilter.mode(
                            _subscribedUsersColor, BlendMode.srcIn),
                      ),
                      SizedBox(width: 6),
                      globalRichText(
                        label: lang.expense,
                        amount: '\$800',
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _mqSize < 780 ? 0 : 20,
                ),
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: 80100,
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      verticalInterval: 60,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          // dashArray: [5, 3, 0],
                          strokeWidth: 1,
                          color: _theme.colorScheme.outline,
                        );
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(
                      _values.length,
                      (index) {
                        return BarChartGroupData(
                          x: index,
                          barsSpace: 0,
                          barRods: [
                            _getBarChartRodData(
                              context,
                              toY: _values.values.toList()[index].toDouble(),
                              color: _freeUsersColor,
                              showBg: index == 5,
                            ),
                            _getBarChartRodData(
                              context,
                              toY: (_values.values.toList()[index] - 15000)
                                  .toDouble(),
                              color: _subscribedUsersColor,
                              showBg: index == 5,
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
                          final _isCurrent = value.round() == 5;
                          return Transform.rotate(
                            angle: _showCompact ? (-55 * (3.1416 / 180)) : 0,
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(top: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              decoration: _isCurrent
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: _freeUsersColor,
                                      ),
                                    )
                                  : null,
                              child: Text(
                                _values.keys.toList()[value.toInt()],
                                textDirection: TextDirection.ltr,
                                style: _theme.textTheme.bodyMedium?.copyWith(
                                  color: _isCurrent
                                      ? _freeUsersColor
                                      : _theme.colorScheme.onTertiary,
                                  fontSize: _showCompact ? 12 : null,
                                  fontWeight:
                                      _isCurrent ? FontWeight.w600 : null,
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
    bool showBg = false,
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
      borderRadius: BorderRadius.zero,
      backDrawRodData: BackgroundBarChartRodData(
        show: showBg,
        toY: 80100,
        color: Color(0xff6200EA).withValues(alpha: 0.15),
        fromY: 0,
      ),
    );
  }

  Widget globalRichText(
      {required String label,
      required String amount,
      required BuildContext context,
      Color? color}) {
    final _theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        text: '$label: ',
        style: _theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: color,
        ),
        children: [
          TextSpan(
            text: amount,
            style: _theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
