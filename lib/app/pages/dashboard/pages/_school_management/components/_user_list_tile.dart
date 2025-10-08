import 'package:flutter/material.dart';

import '../../../../../core/helpers/helpers.dart';
import '../../../../../../generated/l10n.dart' as l;

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.data});
  final UserListTileData data;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(vertical: -4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: getImageType(
          data.imagePath,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(data.fullName ?? "N/A"),
      titleTextStyle: _theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      subtitle: Text("${_lang.clas} ${data.subtitle ?? "N/A"}"),
      subtitleTextStyle: _theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: _theme.checkboxTheme.side?.color,
      ),
      trailing: data.trailingData == null
          ? null
          : Text(
              data.trailingData!,
              style: _theme.textTheme.bodyMedium,
            ),
    );
  }
}

class UserListTileData {
  final String? imagePath;
  final String? fullName;
  final String? subtitle;
  final String? trailingData;

  const UserListTileData({
    this.imagePath,
    this.fullName,
    this.subtitle,
    this.trailingData,
  });
}
