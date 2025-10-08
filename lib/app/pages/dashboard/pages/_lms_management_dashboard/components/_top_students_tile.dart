import 'package:flutter/material.dart';
import '../../../../../../generated/l10n.dart' as lang;
import '../../../../../core/helpers/fuctions/_get_image.dart';

class TopStudentTile extends StatelessWidget {
  const TopStudentTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.progressColor,
    required this.percentValue,
  });
  final String imagePath;
  final String title;
  final String subTitle;
  final Color progressColor;
  final double percentValue;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = lang.S.of(context);
    return ListTile(
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        constraints: BoxConstraints.tight(
          const Size.square(40),
        ),
        child: AnimageWidget(
          imagePath: imagePath,
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
      ),
      title: Text(
        title,
        style: _theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "$subTitle ${_lang.courseEnroll}",
        style: _theme.textTheme.bodySmall?.copyWith(
          color: _theme.checkboxTheme.side?.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 6,
            width: 58,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                minHeight: 6,
                value: percentValue,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                backgroundColor: progressColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(width: 2),
          Text(
            "${(percentValue * 100).toString()}%",
            style: _theme.textTheme.titleSmall?.copyWith(
              color: _theme.colorScheme.onTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
