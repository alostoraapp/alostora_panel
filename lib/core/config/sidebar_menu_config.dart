import 'package:flutter/material.dart';

import '../../features/shell/domain/entities/sidebar_menu_model.dart';
import '../../core/l10n/s.dart';
import '../constants/app_icons.dart';

List<SidebarMenuModel> getSidebarMenus(BuildContext context) {
  final s = S.of(context);

  return [
    SidebarMenuModel(
      title: s.dashboard,
      icon: AppIcons.analyse,
      route: '/dashboard', // Parent route
      children: [
        SidebarMenuModel(
          title: s.overview,
          icon: AppIcons.circle,
          route: '/dashboard/overview',
        ),
      ],
    ),
    SidebarMenuModel(
      title: s.matches,
      icon: AppIcons.football,
      route: '/matches', // Parent route
      children: [
        SidebarMenuModel(
          title: s.matchesTiles,
          icon: AppIcons.tile,
          route: '/matches/tiles',
        ),
        SidebarMenuModel(
          title: s.matchesList,
          icon: AppIcons.list,
          route: '/matches/list',
        ),
      ],
    ),
  ];
}
