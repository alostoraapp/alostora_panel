import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/static/static.dart';

class EarningSummaryWidget extends StatelessWidget {
  const EarningSummaryWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.amount,
    required this.percentage,
  });
  final SvgImageHolder imagePath;
  final String title;
  final String amount;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    final _isLow = (percentage <= 25) && (percentage >= 20);
    final _trailingColor =
        _isLow ? AcnooAppColors.kError : AcnooAppColors.kSuccess;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -2, horizontal: -2),
      leading: SizedBox.square(
        dimension: 40,
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: imagePath.baseColor?.withValues(
              alpha: 0.1,
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(imagePath.svgPath),
        ),
      ),
      title: Text(
        title,
        style: _theme.textTheme.bodyMedium?.copyWith(
          color: _theme.colorScheme.onTertiary,
        ),
      ),
      subtitle: Text(
        amount,
        style: _theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Container(
        constraints: BoxConstraints.loose(Size(100, 30)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: _trailingColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text.rich(
          TextSpan(
            text: '$percentage% ',
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  _isLow ? MdiIcons.arrowBottomRight : MdiIcons.arrowTopRight,
                  size: 16,
                  color: _trailingColor,
                ),
              ),
            ],
          ),
          style: _theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: _trailingColor,
          ),
        ),
      ),
    );
  }
}
