import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/theme/theme.dart';

class DeliveryTracking extends StatelessWidget {
  const DeliveryTracking({
    super.key,
    required this.senderName,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverAddress,
  });

  final String senderName, senderAddress, receiverName, receiverAddress;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);

    Widget buildTimelineTile({
      required bool isFirst,
      required bool isLast,
      required String title,
      required String name,
      required String address,
      required String assetPath,
      required Color titleColor,
    }) {
      return TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        alignment: TimelineAlign.start,
        lineXY: 0.2,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicator: CustomDottedBorder(
            color: _theme.colorScheme.outline,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(assetPath),
            ),
          ),
        ),
        beforeLineStyle: LineStyle(
          thickness: 1,
          color: _theme.colorScheme.outline,
        ),
        afterLineStyle: LineStyle(
          thickness: 1,
          color: _theme.colorScheme.outline,
        ),
        endChild: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                title,
                style: _theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
              Text(
                name,
                style: _theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                address,
                style: _theme.textTheme.bodyMedium?.copyWith(
                  color: _theme.colorScheme.onTertiary,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        buildTimelineTile(
          isFirst: true,
          isLast: false,
          title: _lang.sender,
          name: senderName,
          address: senderAddress,
          assetPath: 'assets/images/widget_images/delivery_dashboard_icons/sender.svg',
          titleColor: const Color(0xff007AFF),
        ),
        buildTimelineTile(
          isFirst: false,
          isLast: true,
          title: _lang.receiver,
          name: receiverName,
          address: receiverAddress,
          assetPath: 'assets/images/widget_images/delivery_dashboard_icons/location.svg',
          titleColor: AcnooAppColors.kSuccess,
        ),
      ],
    );
  }
}

//custom dotted border
class CustomDottedBorder extends StatelessWidget {
  final Widget child;
  final Color color;

  const CustomDottedBorder({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _theme.colorScheme.primaryContainer, // Set the background color here
          ),
        ),
        CustomPaint(
          painter: DottedBorderPainter(color: color),
          child: ClipOval(child: child),
        ),
      ],
    );
  }
}

//for custom dotted widget
class DottedBorderPainter extends CustomPainter {
  final Color color;

  DottedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final double dashWidth = 4, dashSpace = 4;
    final path = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    final PathMetrics metrics = path.computeMetrics();
    for (PathMetric metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
