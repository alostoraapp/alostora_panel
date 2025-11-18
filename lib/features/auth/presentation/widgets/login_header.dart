import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/presentation/cubit/theme_cubit.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../core/constants/app_icons.dart';

class LoginHeader extends StatelessWidget implements PreferredSizeWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final iconColor = IconTheme.of(context).color;
    final isDark = theme.brightness == Brightness.dark;
    final smallLogoAsset = isDark
        ? 'assets/images/logo/logo_dark_small.png'
        : 'assets/images/logo/logo_light_small.png';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  smallLogoAsset,
                  height: 36,
                  width: 36,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      s.appName,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  isDark ? AppIcons.sun : AppIcons.moon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
                ),
                tooltip: s.changeTheme,
                onPressed: () => context.read<ThemeCubit>().toggleThemeMode(),
              ),
              PopupMenuButton<Locale>(
                onSelected: (locale) {
                  context.read<LanguageCubit>().setLanguage(locale);
                },
                tooltip: s.changeLanguage,
                icon: SvgPicture.asset(
                  AppIcons.language,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
                ),
                itemBuilder: (context) {
                  return L10n.all.map((locale) {
                    final flag = L10n.getFlag(locale.languageCode);
                    return PopupMenuItem(
                      value: locale,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            flag,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 10),
                          Text(locale.languageCode.toUpperCase()),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
