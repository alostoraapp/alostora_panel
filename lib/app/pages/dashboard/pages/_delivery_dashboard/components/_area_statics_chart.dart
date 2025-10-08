// 🐦 Flutter imports:
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/theme/theme.dart';

class AreaStatisticsPiChart extends StatefulWidget {
  const AreaStatisticsPiChart({super.key});

  @override
  State<AreaStatisticsPiChart> createState() => _AreaStatisticsPiChartState();
}

class _AreaStatisticsPiChartState extends State<AreaStatisticsPiChart> {
  int touchedIndex = 0;

  late List<PieData> _mockList;
  int? _selectedIndex;

  List<PieData> _getLocalizedMockList(BuildContext context) {
    final _lang = l.S.of(context);
    return [
      PieData(
        color: Color(0xff7500FD),
        label: _lang.centralArea,
        percentage: "20",
        value: 20,
      ),
      PieData(
        color: Color(0xff00B243),
        label: _lang.deliveryMan,
        percentage: "40",
        value: 40,
      ),
      PieData(
        color: Color(0xffFA7A09),
        label: _lang.southArea,
        percentage: "10",
        value: 10,
      ),
      PieData(
        color: Color(0xff7CD3FF),
        label: _lang.easternArea,
        percentage: "30",
        value: 30,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _mockList = _getLocalizedMockList(context);
    final _mqSize = MediaQuery.sizeOf(context);
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final _size = constraints.biggest;

        final _chartRadius = responsiveValue<double>(
          context,
          xs: _size.height *
              (_mqSize.width < 375
                  ? 0.115
                  : _mqSize.width < 420
                      ? 0.135
                      : 0.175),
          md: _size.height * (_mqSize.width < 992 ? 0.20 : 0.220),
          lg: _size.height * (_mqSize.width < 1400 ? 0.20 : 0.20),
        );
        final _chartMobile = _mqSize.width > 420;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 6,
              fit: FlexFit.loose,
              child: SizedBox.square(
                dimension: _chartRadius + 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      data: _mockList
                          .map((data) => PieChartData(
                                data.color,
                                data.value,
                                double.parse(
                                  data.percentage,
                                ),
                              ))
                          .toList(),
                      radius: 100,
                      strokeWidth: 30,
                      gapWidth: 4,
                      selectedIndex: _selectedIndex, // Highlight the selected index
                    ),
                    CustomPaint(
                      size: Size(
                        _chartMobile ? 100 : 80,
                        _chartMobile ? 100 : 80,
                      ), // Dotted border inside the chart
                      painter: DottedCirclePainter(),
                    ),
                    // Center text
                    Container(
                      width: _chartMobile ? 80 : 60,
                      height: _chartMobile ? 80 : 60,
                      padding: EdgeInsetsDirectional.all(5),
                      decoration: BoxDecoration(
                        color: _theme.colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _theme.colorScheme.shadow.withValues(
                              alpha: 0.16,
                            ),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: '875\n',
                            children: [
                              TextSpan(
                                text: _lang.totalOrders,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _theme.colorScheme.onTertiary,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: _theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: _chartRadius * 0.5,
            ),
            Flexible(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  _mockList.length,
                  (index) {
                    final _data = _mockList[index];
                    return Indicator(
                      color: _data.color,
                      text: _data.label,
                      percentage: _data.percentage,
                    );
                  },
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
  final String percentage;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints.tight(const Size.square(12)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text.rich(
              TextSpan(
                text: "$text:",
                style: TextStyle(
                  color: _theme.colorScheme.onTertiary,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: " $percentage%",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              style: _theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

// Dotted border painter
class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AcnooAppColors.kNeutral400
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    const double dashWidth = 2.0;
    const double dashSpace = 6.0;

    final double circumference = 2 * pi * radius;

    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();

    final double angleBetweenDashes = 2 * pi / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = i * angleBetweenDashes;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle, // Start angle of the dash
        dashWidth / radius, // Sweep angle of the dash
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

//Pie chart
class PieChart extends StatefulWidget {
  const PieChart({
    required this.data,
    required this.radius,
    required this.strokeWidth,
    this.gapWidth = 10,
    this.selectedIndex,
    super.key,
  });

  final List<PieChartData> data;
  final double radius;
  final double strokeWidth;
  final double gapWidth;
  final int? selectedIndex;

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  void _onTap(int index) {
    setState(() {
      selectedIndex = selectedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        final size = context.size;
        final center = Offset(size!.width / 2, size.height / 2);
        // final radius = widget.radius;
        final angle = (details.localPosition - center).direction;
        double startAngle = -pi / 2;

        for (int i = 0; i < widget.data.length; i++) {
          final item = widget.data[i];
          final sweepAngle = 2 * pi * (item.percent / 100) - widget.gapWidth / size.width;

          if (angle >= startAngle && angle <= startAngle + sweepAngle) {
            _onTap(i);
            break;
          }

          startAngle += sweepAngle + widget.gapWidth / size.width;
        }
      },
      child: CustomPaint(
        painter: _PieChartPainter(
          widget.strokeWidth,
          widget.gapWidth,
          widget.data,
          selectedIndex,
        ),
        size: Size.square(
          widget.radius * 2,
        ),
      ),
    );
  }
}

// PieChartPainter

class _PieChartPainter extends CustomPainter {
  _PieChartPainter(
    this.strokeWidth,
    this.gapWidth,
    this.data,
    this.selectedIndex,
  );

  final double strokeWidth;
  final double gapWidth;
  final List<PieChartData> data;
  final int? selectedIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    double startAngle = -pi / 2;

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final isSelected = selectedIndex == i;

      final paint = Paint()
        ..color = isSelected
            ? item.color // Highlight selected item
            : item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? strokeWidth + 5 : strokeWidth
        ..strokeCap = StrokeCap.butt; // Rounded corners

      final sweepAngle = 2 * pi * (item.percent / 100) - gapWidth / size.width;

      // Draw the pie slice
      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      // Display value inside the pie chart slice
      if (isSelected) {
        final angle = startAngle + sweepAngle / 2;
        final textPainter = TextPainter(
          textAlign: TextAlign.center, // Align text in the center
          text: TextSpan(
            text: '${item.value}%', // Display percentage
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout(
            minWidth: 0,
            maxWidth: size.width,
          );
        // Calculate the position to place the text in the center of the pie slice
        final radius = size.width / 1.9 - 10; // Adjust for padding
        final offset = Offset(
          size.width / 2 + radius * cos(angle), // X position
          size.height / 2 + radius * sin(angle), // Y position
        );

        // Center the text based on its width and height
        final textOffset = Offset(
          offset.dx - textPainter.width / 10,
          offset.dy - textPainter.height / 10,
        );
        textPainter.paint(canvas, textOffset);
      }
      startAngle += sweepAngle + gapWidth / size.width;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PieData {
  final Color color;
  final String label;
  late final double value;
  final String percentage;

  PieData({
    required this.color,
    required this.label,
    required this.value,
    required this.percentage,
  });
}

class PieChartData {
  const PieChartData(this.color, this.percent, this.value);

  final Color color;
  final double percent;
  final double value;
}
