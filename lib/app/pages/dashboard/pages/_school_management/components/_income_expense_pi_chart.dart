// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../../../generated/l10n.dart' as l;

class IncomeExpensePiChart extends StatefulWidget {
  const IncomeExpensePiChart({super.key});

  @override
  State<IncomeExpensePiChart> createState() => _IncomeExpensePiChartState();
}

class _IncomeExpensePiChartState extends State<IncomeExpensePiChart> {
  int touchedIndex = -1;
  List<PiChartData>? _mockList;
  List<PiChartData> _getChartList(BuildContext context) {
    final _lang = l.S.of(context);
    return [
      PiChartData(
        color: AcnooAppColors.kInfo,
        label: _lang.mobileVisitors,
        value: 65,
        amount: '857',
      ),
      PiChartData(
        color: AcnooAppColors.kError,
        label: _lang.desktopVisitors,
        value: 35,
        amount: '750',
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
        final _chartRadius = 50.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 220,
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
                    value: 50000,
                    color: AcnooAppColors.kInfo,
                  ),
                  if (_mqSize.width > 440)
                    SizedBox(
                      height: 24,
                      child: VerticalDivider(
                        color: _theme.colorScheme.outline,
                      ),
                    ),
                  _buildLabel(
                    label: lang.expense,
                    value: 50000,
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

  Widget _buildLabel(
      {required String label,
      num value = 0,
      Color? color,
      TextAlign alignment = TextAlign.start}) {
    return Builder(
      builder: (context) {
        final _theme = Theme.of(context);
        return Text.rich(
          TextSpan(
            text: "$label: ",
            children: [
              TextSpan(
                text: NumberFormat.simpleCurrency(decimalDigits: 0).format(
                  value,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          textAlign: alignment,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _theme.textTheme.bodyLarge?.copyWith(
            fontSize: 18,
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
