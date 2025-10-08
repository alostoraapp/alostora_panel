import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;

import 'package:syncfusion_flutter_gauges/gauges.dart' as sfg;

import '../../../../../core/core.dart';
import '../../../../../../generated/l10n.dart' as l;

class StudentQuantityChart extends StatelessWidget {
  const StudentQuantityChart({
    super.key,
    required this.data,
  });
  final StudentQuantityChartData data;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _mqSize = MediaQuery.sizeOf(context);
    final _lang = l.S.of(context);

    final activeColor = const Color(0xFF09B96D);
    final inactiveColor = AcnooAppColors.kNeutral200;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox.square(
            dimension: 245,
            child: AspectRatio(
              aspectRatio: 1,
              child: sfg.SfRadialGauge(
                axes: [
                  sfg.RadialAxis(
                    startAngle: 130,
                    endAngle: 50,
                    minimum: 0,
                    maximum: data.totalStudent,
                    showTicks: false,
                    showLabels: false,
                    axisLineStyle: sfg.AxisLineStyle(
                      cornerStyle: sfg.CornerStyle.bothCurve,
                      thickness: 15,
                      thicknessUnit: sfg.GaugeSizeUnit.logicalPixel,
                    ),
                    pointers: [
                      sfg.RangePointer(
                        value: data.activeStudent,
                        width: 30,
                        color: activeColor,
                        pointerOffset: -7.5,
                        cornerStyle: sfg.CornerStyle.bothCurve,
                      )
                    ],
                    annotations: [
                      sfg.GaugeAnnotation(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: AcnooSVGIcons.student02.baseColor?.withValues(
                                alpha: 0.25,
                              ),
                              child: SvgPicture.asset(
                                AcnooSVGIcons.student02.svgPath,
                              ),
                            ),
                            const SizedBox.square(dimension: 16),
                            Text(
                              data.totalStudent.toStringAsFixed(0),
                              style: _theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          width: double.maxFinite,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              _buildLabel(
                label: _lang.totalStudents,
                value: data.totalStudent,
                color: inactiveColor,
              ),
              if (_mqSize.width > 480)
                SizedBox(
                  height: 24,
                  child: VerticalDivider(
                    color: _theme.colorScheme.outline,
                  ),
                ),
              _buildLabel(
                label: _lang.activeStudents,
                value: data.activeStudent,
                color: activeColor,
                alignment: TextAlign.end,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLabel({required String label, num value = 0, Color? color, TextAlign alignment = TextAlign.start}) {
    return Builder(
      builder: (context) {
        final _theme = Theme.of(context);
        return Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  margin: EdgeInsetsDirectional.only(end: 6),
                  constraints: BoxConstraints.tight(Size.square(8)),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              TextSpan(text: "$label: "),
              TextSpan(
                text: intl.NumberFormat.currency(symbol: '', decimalDigits: 0).format(
                  value,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
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

class StudentQuantityChartData {
  StudentQuantityChartData({
    required this.totalStudent,
    required this.activeStudent,
  });

  final double totalStudent;
  final double activeStudent;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is StudentQuantityChartData && runtimeType == other.runtimeType && totalStudent == other.totalStudent && activeStudent == other.activeStudent;

  @override
  int get hashCode => totalStudent.hashCode ^ activeStudent.hashCode;
}
