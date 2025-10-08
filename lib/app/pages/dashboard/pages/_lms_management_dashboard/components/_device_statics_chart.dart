// 🐦 Flutter imports:
// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../../../generated/l10n.dart' as l;

class DeviceStaticsPieChart extends StatefulWidget {
  const DeviceStaticsPieChart({super.key});

  @override
  State<DeviceStaticsPieChart> createState() => _DeviceStaticsPieChartState();
}

class _DeviceStaticsPieChartState extends State<DeviceStaticsPieChart> {
  int touchedIndex = -1;
  List<PiChartData>? _mockList;
  List<PiChartData> _getChartList(BuildContext context) {
    final _lang = l.S.of(context);
    return [
      PiChartData(
        color: Colors.blue,
        label: _lang.desktopVisitors,
        value: 25,
        amount: '750',
      ),
      PiChartData(
        color: Colors.green,
        label: _lang.mobileVisitors,
        value: 35,
        amount: '857',
      ),
      PiChartData(
        color: Colors.yellow,
        label: _lang.tabletVisitors,
        value: 40,
        amount: '375',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _mockList = _getChartList(context);
    final _mqSize = MediaQuery.sizeOf(context);
    final _theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final _size = constraints.biggest;

        final _chartRadius = responsiveValue<double>(
          context,
          xs: _size.height * (_mqSize.width < 420 ? 0.20 : 0.325),
          md: _size.height * (_mqSize.width < 768 ? 0.45 : 0.35),
          lg: _size.height * (_mqSize.width < 1600 ? 0.45 : 0.375),
        );

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: responsiveValue(
                  context,
                  xs: CrossAxisAlignment.start,
                  md: _mqSize.width < 768
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  lg: CrossAxisAlignment.start,
                ),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ..._mockList.map(
                    (item) {
                      return Indicator(
                        color: item.color,
                        text: item.label,
                        amount: item.amount,
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 0,
                    sections: List.generate(
                      _mockList.length,
                      (index) {
                        final _data = _mockList[index];

                        return PieChartSectionData(
                          color: _data.color,
                          radius: _chartRadius,
                          badgeWidget: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints.tight(
                              Size.square(_chartRadius * 0.45),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _theme.colorScheme.primaryContainer,
                            ),
                            child: Text(
                              "${_data.value.toStringAsFixed(0)}%",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: (_chartRadius * 0.175).clamp(10, 14),
                              ),
                            ),
                          ),
                          badgePositionPercentageOffset: 1,
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
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final String amount;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: color,
          ),
        ),
        Text(
          text,
          style: _theme.textTheme.bodyLarge?.copyWith(
            color: _theme.colorScheme.onTertiary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          amount,
          style: _theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}

class PiChartData {
  final Color color;
  final String label;
  final double value;
  final String amount;

  const PiChartData({
    required this.color,
    required this.label,
    required this.value,
    required this.amount,
  });
}
