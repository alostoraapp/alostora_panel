import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../../../generated/l10n.dart' as l;
// 🌎 Project imports:
import '../../../../../core/static/static.dart';
import '../../../../../core/theme/theme.dart';

class DeliveryCategoryChart extends StatefulWidget {
  const DeliveryCategoryChart({super.key});

  @override
  State<DeliveryCategoryChart> createState() => _DeliveryCategoryChartState();
}

class _DeliveryCategoryChartState extends State<DeliveryCategoryChart>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  Map<String, String>? vehiclesInfo;
  Map<String, String> _getVehiclesInfo(BuildContext context) {
    return {
      l.S.current.bike:
          'assets/images/widget_images/delivery_dashboard_icons/bike.svg',
      l.S.current.bicycle:
          'assets/images/widget_images/delivery_dashboard_icons/bicycle.svg',
      l.S.current.car:
          'assets/images/widget_images/delivery_dashboard_icons/car.svg',
    };
  }

  final Map<int, List<FlSpot>> lineChartData = {
    0: [
      FlSpot(1, 20000),
      FlSpot(2, 60000),
      FlSpot(3, 30000),
      FlSpot(4, 35000),
      FlSpot(5, 20000),
      FlSpot(6, 30000),
      FlSpot(7, 20500),
      FlSpot(8, 62000),
      FlSpot(9, 32000),
      FlSpot(10, 35000),
      FlSpot(11, 20000),
      FlSpot(12, 0),
    ],
    1: [
      FlSpot(1, 15000),
      FlSpot(2, 55000),
      FlSpot(3, 25000),
      FlSpot(4, 30000),
      FlSpot(5, 18000),
      FlSpot(6, 27000),
      FlSpot(7, 19000),
      FlSpot(8, 60000),
      FlSpot(9, 30000),
      FlSpot(10, 34000),
      FlSpot(11, 18000),
      FlSpot(12, 0),
    ],
    2: [
      FlSpot(1, 10000),
      FlSpot(2, 50000),
      FlSpot(3, 20000),
      FlSpot(4, 28000),
      FlSpot(5, 15000),
      FlSpot(6, 25000),
      FlSpot(7, 18000),
      FlSpot(8, 58000),
      FlSpot(9, 29000),
      FlSpot(10, 32000),
      FlSpot(11, 16000),
      FlSpot(12, 0),
    ],
  };
  late final TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: _getVehiclesInfo(context).length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesInfo = _getVehiclesInfo(context);
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;
    final lang = l.S.of(context);
    final _mqSize = MediaQuery.sizeOf(context);

    final _withdrawColor = _theme.colorScheme.primary;
    final _titles = {
      1: lang.Jan,
      2: lang.Feb,
      3: lang.Mar,
      4: lang.Apr,
      5: lang.May,
      6: lang.Jun,
      7: lang.Jul,
      8: lang.Aug,
      9: lang.Sept,
      10: lang.Oct,
      11: lang.Nov,
      12: lang.Dec,
    };

    return LayoutBuilder(
      builder: (_, constraints) {
        final _size = constraints.biggest;
        final _lang = l.S.of(context);
        return Column(
          children: [
            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              indicatorColor: _theme.colorScheme.primary,
              tabs: vehiclesInfo.entries.map((entry) {
                final index = vehiclesInfo.keys.toList().indexOf(entry.key);
                final isSelected = selectedIndex == index;
                return Tab(
                  icon: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: SvgPicture.asset(
                            entry.value,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? _theme.colorScheme.primary
                                  : _theme.colorScheme.onTertiary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: " ${entry.key}",
                          style: _theme.textTheme.titleSmall?.copyWith(
                            color: isSelected
                                ? _theme.colorScheme.primary
                                : _theme.colorScheme.onTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${_lang.total} ',
                  ),
                  TextSpan(
                    text: "2,450 ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: _lang.delivers,
                  ),
                ],
              ),
              style: _theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Flexible(
              child: LineChart(
                LineChartData(
                  minX: 1,
                  maxX: 12,
                  minY: 0,
                  maxY: 80100,
                  gridData: FlGridData(
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: _theme.colorScheme.outline,
                      dashArray: [10, 5],
                    ),
                    getDrawingVerticalLine: (value) {
                      if (value / value.toInt() != 1) {
                        return FlLine(color: Colors.transparent);
                      }

                      return FlLine(
                        strokeWidth: (_size.width / 12) * 0.40,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.3, 0.7],
                          colors: [
                            _theme.colorScheme.outline.withValues(
                              alpha: 0.12,
                            ),
                            if (value.toInt() - 1 == selectedIndex)
                              _theme.colorScheme.primary.withValues(
                                alpha: 0.2,
                              )
                            else
                              _theme.colorScheme.outline.withValues(
                                alpha: 0.2,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(
                    getTouchedSpotIndicator: (barData, spotIndexes) {
                      return spotIndexes.map(
                        (item) {
                          selectedIndex = item;
                          return TouchedSpotIndicatorData(
                            const FlLine(color: Colors.transparent),
                            FlDotData(
                              getDotPainter: (p0, p1, p2, p3) {
                                return FlDotCirclePainter(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                  strokeColor: p2.color ?? Colors.transparent,
                                );
                              },
                            ),
                          );
                        },
                      ).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      maxContentWidth: 240,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((item) {
                          final _value = NumberFormat.compactCurrency(
                            decimalDigits: 4,
                            symbol: '',
                            locale: AppLocale.defaultLocale.countryCode,
                          ).format(
                            item.bar.spots[item.spotIndex].y,
                          );

                          return LineTooltipItem(
                            "",
                            _theme.textTheme.bodySmall!,
                            textAlign: TextAlign.start,
                            children: [
                              TextSpan(
                                text: ' ${_titles[item.spotIndex + 1]} 2024\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              /// Text Dot Indicator [used for the replacement of a circle widget. due to the limitation of fl_chart package, LineTooltipItem class doesn't support a widget span]
                              TextSpan(
                                text: '● ',
                                style: TextStyle(
                                  color: item.bar.color,
                                ),
                              ),
                              TextSpan(
                                //text: "Withdraw:",
                                text: "${lang.withdraw}:",
                                style: TextStyle(
                                  color: _isDark
                                      ? _theme.colorScheme.onPrimaryContainer
                                      : const Color(
                                          0xff667085,
                                        ),
                                ),
                              ),
                              TextSpan(
                                text: " $_value",
                                style: TextStyle(
                                  color: _isDark
                                      ? _theme.colorScheme.onPrimaryContainer
                                      : const Color(
                                          0xff344054,
                                        ),
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
                      shadow: Shadow(
                        color: _isDark
                            ? AcnooAppColors.kNeutral900.withValues(
                                alpha: 0.8,
                              )
                            : _theme.colorScheme.onPrimaryContainer.withValues(
                                alpha: 0.2,
                              ),
                        offset: Offset(
                          0,
                          30,
                        ),
                        blurRadius: 8,
                      ),
                      spots: lineChartData[selectedIndex] ?? [],
                      isCurved: true,
                      barWidth: 6,
                      dotData: const FlDotData(
                        show: false,
                      ),
                      color: _withdrawColor,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: _getTitlesData(
                      context,
                      show: false,
                    ),
                    rightTitles: _getTitlesData(
                      context,
                      show: false,
                    ),
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
