import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../core/presentation/cubit/theme_cubit.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/shell_bloc.dart';
import '../../../../core/constants/app_icons.dart';

class Topbar extends StatelessWidget implements PreferredSizeWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = IconTheme.of(context).color;
    final isDark = theme.brightness == Brightness.dark;
    final s = AppLocalizations.of(context)!;
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return AppBar(
      title: Row(
        children: [
          if (isDesktop)
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  AppIcons.menuBurger,
                  colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
                ),
                onPressed: () => context.read<ShellBloc>().add(ToggleSidebar()),
              ),
            ),
          // The breadcrumb is now in the AppShell, so we can add a Spacer or other widgets here.
          const Spacer(),
        ],
      ),
      titleSpacing: 0,
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            isDark ? AppIcons.sun : AppIcons.moon,
            colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
          ),
          tooltip: s.changeTheme,
          onPressed: () => context.read<ThemeCubit>().toggleThemeMode(),
        ),
        IconButton(
          icon: SvgPicture.asset(
            AppIcons.language,
            colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
          ),
          tooltip: s.changeLanguage,
          onPressed: () => context.read<LanguageCubit>().toggleLanguage(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PopupMenuButton(
            tooltip: 'Profile',
            icon: CircleAvatar(
              child: SvgPicture.asset(
                AppIcons.user,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.signOutAlt,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8),
                    Text(s.logout),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
