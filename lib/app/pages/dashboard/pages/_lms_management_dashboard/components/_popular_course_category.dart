import 'package:flutter/material.dart';
import '../../../../../core/helpers/fuctions/_get_image.dart';
import '../../../../../../generated/l10n.dart' as l;

class PopularCourseCategory extends StatelessWidget {
  const PopularCourseCategory({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.totalCourse,
    required this.leadingColor,
  });
  final String imagePath;
  final Color leadingColor;
  final String title;
  final String subTitle;
  final double totalCourse;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);
    return ListTile(
      leading: Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(
          color: leadingColor,
          shape: BoxShape.circle,
        ),
        constraints: BoxConstraints.tight(
          const Size.square(40),
        ),
        child: AnimageWidget(
          imagePath: imagePath,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          height: 20,
          width: 20,
        ),
      ),
      title: Text(
        title,
        style: _theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: _theme.textTheme.bodySmall?.copyWith(
          color: _theme.checkboxTheme.side?.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Text(
        "${totalCourse.toString()}+ ${_lang.courses}",
        style: _theme.textTheme.titleSmall?.copyWith(
          color: _theme.colorScheme.onTertiary,
        ),
      ),
    );
  }
}
