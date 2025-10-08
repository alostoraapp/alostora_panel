import 'package:flutter/material.dart';
import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/helpers/fuctions/_get_image.dart';

class PopularInstructionTile extends StatelessWidget {
  const PopularInstructionTile({
    super.key,
    required this.imagePath,
    required this.name,
    required this.instructorDetails,
    required this.course,
  });
  final String imagePath;
  final String name;
  final String instructorDetails;
  final int course;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);
    return ListTile(
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        constraints: BoxConstraints.tight(const Size.square(40)),
        child: AnimageWidget(
          imagePath: imagePath,
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
      ),
      title: Text(
        name,
        style: _theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        instructorDetails,
        style: _theme.textTheme.bodySmall?.copyWith(
          color: _theme.checkboxTheme.side?.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(4),
          color: _theme.colorScheme.primary.withValues(
            alpha: 0.2,
          ),
        ),
        child: Text.rich(
          TextSpan(
            text: _lang.course,
            style: _theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: _theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
