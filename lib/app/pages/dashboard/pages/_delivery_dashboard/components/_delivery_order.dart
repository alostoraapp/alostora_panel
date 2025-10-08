import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/static/static.dart';

class DeliveryOrderWidget extends StatefulWidget {
  const DeliveryOrderWidget({super.key, required this.imagePath, required this.title, required this.subTitle});
  final SvgImageHolder imagePath;
  final String title;
  final String subTitle;

  @override
  State<DeliveryOrderWidget> createState() => _DeliveryOrderWidgetState();
}

class _DeliveryOrderWidgetState extends State<DeliveryOrderWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _theme.colorScheme.primaryContainer,
        ),
        color: widget.imagePath.baseColor?.withValues(
          alpha: 0.1,
        ),
        gradient: LinearGradient(
          colors: [
            _theme.colorScheme.primaryContainer,
            widget.imagePath.baseColor!.withValues(
              alpha: 0.5,
            ),
          ],
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsetsDirectional.zero,
        visualDensity: VisualDensity(
          horizontal: -4,
        ),
        leading: Container(
          height: 70,
          width: 65,
          padding: EdgeInsetsDirectional.all(5),
          decoration: BoxDecoration(
            color: widget.imagePath.baseColor?.withValues(
              alpha: 0.2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SvgPicture.asset(
            widget.imagePath.svgPath,
          ),
        ),
        title: Text(
          widget.title,
          style: _theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          widget.subTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: _theme.textTheme.bodyLarge?.copyWith(
            color: _theme.colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}
