// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../../../generated/l10n.dart' as l;

class EarningOverviewChart extends StatefulWidget {
  const EarningOverviewChart({super.key});

  @override
  State<EarningOverviewChart> createState() => _EarningOverviewChartState();
}

class _EarningOverviewChartState extends State<EarningOverviewChart> {
  int touchedIndex = -1;
  List<PiChartData>? _mockList;
  List<PiChartData> _getChartList(BuildContext context) {
    final _lang = l.S.of(context);
    return [
      PiChartData(
        color: AcnooAppColors.kSuccess,
        label: _lang.desktopVisitors,
        value: 65,
        amount: '750',
      ),
      PiChartData(
        color: AcnooAppColors.kError,
        label: _lang.mobileVisitors,
        value: 35,
        amount: '857',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final lang = l.S.of(context);

    final _mockList = _getChartList(context);
    final _theme = Theme.of(context);
    final _mqSize = MediaQuery.sizeOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final _chartRadius = 60.0;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 250,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: _chartRadius,
                  startDegreeOffset: -60,
                  sections: List.generate(
                    _mockList.length,
                    (index) {
                      final _data = _mockList[index];

                      return PieChartSectionData(
                        color: _data.color,
                        radius: _chartRadius,
                        value: _data.value,
                        title: '',
                        badgeWidget: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints.tight(
                            Size.square(_chartRadius * 0.75),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _theme.colorScheme.primaryContainer,
                          ),
                          child: Text(
                            "${_data.value.toStringAsFixed(0)}%",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: (_chartRadius * 0.225).clamp(10, 16),
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
            const SizedBox.square(dimension: 20),
            SizedBox(
              height: 30,
              width: double.maxFinite,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                children: [
                  _buildLabel(
                    label: lang.income,
                    value: 10500,
                    color: AcnooAppColors.kSuccess,
                  ),
                  if (_mqSize.width > 440) const SizedBox.square(dimension: 24),
                  _buildLabel(
                    label: lang.expense,
                    value: 5700,
                    color: AcnooAppColors.kError,
                    alignment: TextAlign.end,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildLabel({
    required String label,
    num value = 0,
    Color? color,
    TextAlign alignment = TextAlign.start,
  }) {
    return Builder(
      builder: (context) {
        final _theme = Theme.of(context);
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '● ', style: TextStyle(color: color)),
              TextSpan(
                text: "$label: ",
                children: [
                  TextSpan(
                    text: NumberFormat.compactSimpleCurrency(decimalDigits: 0)
                        .format(
                      value,
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          textAlign: alignment,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _theme.textTheme.bodyLarge?.copyWith(
            color: _theme.checkboxTheme.side?.color,
          ),
        );
      },
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
