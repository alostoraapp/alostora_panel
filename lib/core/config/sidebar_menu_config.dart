import 'package:flutter/material.dart';

import '../../features/shell/domain/entities/sidebar_menu_model.dart';
import '../../core/l10n/s.dart';
import '../constants/app_icons.dart';

List<SidebarMenuModel> getSidebarMenus(BuildContext context) {
  final s = S.of(context);

  return [
    SidebarMenuModel(
      title: s.menu,
      icon: AppIcons.apps,
      route: '/dashboard', // Parent route
      children: [
        SidebarMenuModel(
          title: s.overview,
          icon: AppIcons.circle,
          route: '/dashboard/overview',
        ),
        SidebarMenuModel(
          title: s.matches,
          icon: AppIcons.tile,
          route: '/matches/tiles',
        ),
        SidebarMenuModel(
          title: 'News Categories',
          icon: AppIcons.list,
          route: '/news/categories',
        ),
        SidebarMenuModel(
          title: s.news,
          icon: AppIcons.circle,
          route: '/news',
        ),
      ],
    ),
    SidebarMenuModel(
      title: s.settings,
      icon: AppIcons.settings,
      route: '/settings',
      children: [
        SidebarMenuModel(
          title: s.competitionSelect,
          icon: AppIcons.list, // Reusing list icon or maybe circle
          route: '/settings/competition-select',
        ),
      ],
    ),
  ];
}
