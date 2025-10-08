import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart' as l;

class TodayPieChart extends StatelessWidget {
  const TodayPieChart({
    super.key,
  });

  List<PieChartData> get _mockList => [
        PieChartData(
          colors: [
            Color(0xff883DCF),
            Color(0xffCFB1EC),
          ],
          label: "${l.S.current.sales}:",
          value: 40,
          amount: '\$20,000',
        ),
        PieChartData(
          colors: [
            Color(0xff2BB2FE),
            Color(0xffAAE0FF),
          ],
          label: "${l.S.current.purchase}:",
          value: 30,
          amount: '\$13,000',
        ),
        PieChartData(
          colors: [
            Color(0xffF9C80E),
            Color(0xffFDE99F),
          ],
          label: "${l.S.current.income}:",
          value: 20,
          amount: '\$7000',
        ),
        PieChartData(
          colors: [
            Color(0xffEB3D4D),
            Color(0xffF7B1B8),
          ],
          label: "${l.S.current.expense}:",
          value: 10,
          amount: '\$1300',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);
    return Column(
      children: [
        SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: _Painter(14, _mockList),
              size: const Size.square(220),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$5,700',
                  style: _theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  _lang.todayReport,
                  style: _theme.textTheme.titleLarge?.copyWith(
                    color: _theme.colorScheme.onTertiary,
                  ),
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: List.generate(
              _mockList.length,
              (index) {
                final _data = _mockList[index];
                return Indicator(
                  color: _data.colors,
                  text: _data.label,
                  amount: _data.amount,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _PainterData {
  const _PainterData(this.paint, this.radians);

  final Paint paint;
  final double radians;
}

class _Painter extends CustomPainter {
  _Painter(double strokeWidth, List<PieChartData> data) {
    final totalValue = data.fold(0.0, (sum, item) => sum + item.value);

    dataList = data.map((e) {
      final rect = Rect.fromCircle(center: Offset(114, 114), radius: 114);
      final gradient = LinearGradient(
        colors: e.colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

      return _PainterData(
        Paint()
          ..shader = gradient.createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
        // remove padding from stroke
        ((e.value / totalValue * 100) - _padding) * _percentInRadians,
      );
    }).toList();
  }

  static const _percentInRadians = 0.062831853071796;
  static const _padding = 2.3;
  static const _paddingInRadians = _percentInRadians * _padding;
  static const _startAngle = -1.570796 + _paddingInRadians / 2;

  late final List<_PainterData> dataList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    double startAngle = _startAngle;

    for (final data in dataList) {
      final path = Path()..addArc(rect, startAngle, data.radians);

      startAngle += data.radians + _paddingInRadians;

      canvas.drawPath(path, data.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class Indicator extends StatelessWidget {
  final List<Color> color;
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints.tight(Size.square(12)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: color,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: _theme.textTheme.bodyLarge,
          ),
          Spacer(),
          Text(
            amount,
            style: _theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

class PieChartData {
  final List<Color> colors;
  final String label;
  final double value;
  final String amount;

  const PieChartData({
    required this.colors,
    required this.label,
    required this.value,
    required this.amount,
  });
}
