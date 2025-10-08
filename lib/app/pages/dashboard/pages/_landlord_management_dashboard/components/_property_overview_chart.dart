import '../../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../generated/l10n.dart' as l;

class PropertyOverViewChart extends StatelessWidget {
  const PropertyOverViewChart({
    super.key,
  });

  List<PieChartData> get _mockList => [
        PieChartData(
          color: Color(0xffFF9F29),
          label: "${l.S.current.approved}:",
          value: 33,
          amount: '1',
          icon: AcnooSVGIcons.approvedIcon,
        ),
        PieChartData(
          color: Color(0xff2FB059),
          label: "${l.S.current.rejected}:",
          value: 33,
          amount: '3',
          icon: AcnooSVGIcons.rejectedIcon,
        ),
        PieChartData(
          color: Color(0xff6200EA),
          label: "${l.S.current.pending}:",
          value: 33,
          amount: '1',
          icon: AcnooSVGIcons.pendingIcon,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);
    final _size = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: _Painter(14, _mockList),
                size: Size.square(
                  _size >= 1240 && _size <= 1350 ? 180 : 200,
                ),
              ),
              Container(
                height: _size >= 1240 && _size <= 1350 ? 130 : 155,
                width: _size >= 1240 && _size <= 1350 ? 130 : 153,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _theme.colorScheme.primary.withValues(alpha: 0.06),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '5',
                      style: _theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      _lang.totalProperty,
                      style: _theme.textTheme.titleMedium?.copyWith(
                        color: _theme.colorScheme.onTertiary,
                      ),
                    )
                  ],
                ),
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
                    color: _data.color,
                    text: _data.label,
                    amount: _data.amount,
                    icon: _data.icon,
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
      return _PainterData(
        Paint()
          // ..shader = gradient.createShader(rect)
          ..color = e.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
        // remove padding from stroke
        ((e.value / totalValue * 100) - _padding) * _percentInRadians,
      );
    }).toList();
  }

  static const _percentInRadians = 0.062831853071796;
  static const _padding = 3.5;
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
  final Color color;
  final String text;
  final String amount;
  final SvgImageHolder icon;
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            // width: 40,
            padding: const EdgeInsets.all(7),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: icon.baseColor?.withValues(alpha: 0.1),
            ),
            child: SvgPicture.asset(
              icon.svgPath,
            ),
          ),
          const SizedBox(width: 10),
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
  final Color color;
  final String label;
  final double value;
  final String amount;
  final SvgImageHolder icon;

  const PieChartData({
    required this.color,
    required this.icon,
    required this.label,
    required this.value,
    required this.amount,
  });
}
