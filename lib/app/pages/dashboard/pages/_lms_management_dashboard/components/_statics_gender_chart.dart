import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart' as l;

class StaticsGenderChart extends StatefulWidget {
  const StaticsGenderChart({super.key});

  @override
  State<StaticsGenderChart> createState() => _StaticsGenderChartState();
}

class _StaticsGenderChartState extends State<StaticsGenderChart> {
  Map<String, String>? _genderCount;

  Map<String, String> _getGenderCount(BuildContext context) {
    final _lang = l.S.of(context);
    return {
      "${_lang.male}: ": "20,000",
      "${_lang.female}: ": "15,000",
      "${_lang.others}: ": "3,000",
    };
  }

  @override
  Widget build(BuildContext context) {
    final _genderCount = _getGenderCount(context);
    final _theme = Theme.of(context);
    return Column(
      children: [
        CustomPaint(
          size: Size(213, 238),
          painter: CircleChartPainter(),
        ),
        Wrap(
          spacing: 16,
          alignment: WrapAlignment.center,
          children: _genderCount.entries.map(
            (entry) {
              return Text.rich(
                TextSpan(
                  text: entry.key,
                  children: [
                    TextSpan(
                      text: entry.value,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                style: _theme.textTheme.bodyLarge,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

class CircleChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Draw the largest circle
    paint.color = Color(0xff7500FD);
    canvas.drawCircle(
      Offset(
        size.width * 0.6,
        size.height * 0.4,
      ), // Center position
      size.width * 0.4, // Radius
      paint,
    );

    // Draw the medium circle
    paint.color = Color(0xffF134EE);
    canvas.drawCircle(
      Offset(
        size.width * 0.85,
        size.height * 0.7,
      ), // Center position
      size.width * 0.3, // Radius
      paint,
    );

    // Draw the smallest circle
    paint.color = Color(0xffFD7F0B);
    canvas.drawCircle(
      Offset(
        size.width * 0.3,
        size.height * 0.7,
      ), // Center position
      size.width * 0.2, // Radius
      paint,
    );

    // Draw the percentages
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    _drawText(
      canvas,
      "50%",
      size.width * 0.6,
      size.height * 0.4,
      size.width * 0.4,
      textPainter,
    );
    _drawText(
      canvas,
      "30%",
      size.width * 0.8,
      size.height * 0.7,
      size.width * 0.3,
      textPainter,
    );
    _drawText(
      canvas,
      "20%",
      size.width * 0.3,
      size.height * 0.7,
      size.width * 0.2,
      textPainter,
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    double x,
    double y,
    double radius,
    TextPainter textPainter,
  ) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.white,
        fontSize: radius * 0.3,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    final offset = Offset(
      x - textPainter.width / 2,
      y - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
