import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/sidebar_menu_config.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/sidebar_menu_model.dart';
import '../bloc/shell_bloc.dart';

class Sidebar extends StatelessWidget {
  final bool isDrawer;
  const Sidebar({super.key, this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final blocIsExpanded = context.watch<ShellBloc>().state.isSidebarExpanded;
    // In drawer mode, the sidebar is always expanded.
    final isExpanded = isDrawer ? true : blocIsExpanded;

    final menus = getSidebarMenus(context);
    final s = S.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final smallLogoAsset =
        isDark ? 'assets/images/logo/logo_dark_small.png' : 'assets/images/logo/logo_light_small.png';

    // The main content of the sidebar
    final sidebarContent = SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: ClipRRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Center(
                      child: Image.asset(smallLogoAsset, height: 24),
                    ),
                  ),
                  if (isExpanded)
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: isExpanded ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          s.appName,
                          style: theme.textTheme.titleLarge,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return _SidebarMenuItem(menu: menu, isExpanded: isExpanded);
              },
            ),
          ),
        ],
      ),
    );

    // If it's a drawer, don't use AnimatedContainer to avoid layout issues.
    if (isDrawer) {
      return Container(
        color: theme.drawerTheme.backgroundColor,
        child: sidebarContent,
      );
    }

    // For desktop, use AnimatedContainer for collapsible effect.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: isExpanded ? 250 : 80,
      color: theme.drawerTheme.backgroundColor,
      child: sidebarContent,
    );
  }
}

class _SidebarMenuItem extends StatelessWidget {
  final SidebarMenuModel menu;
  final bool isExpanded;

  const _SidebarMenuItem({required this.menu, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final location = GoRouterState.of(context).uri.toString();
    final hasChildren = menu.children.isNotEmpty;

    final bool isSelected;
    if (hasChildren) {
      isSelected = menu.children.any((submenu) => location.startsWith(submenu.route ?? '--'));
    } else {
      isSelected = location.startsWith(menu.route ?? '--');
    }

    final selectedColor = theme.primaryColor;
    final unselectedColor = theme.iconTheme.color;
    final iconColor = isSelected ? selectedColor : unselectedColor;
    final textColor = isSelected ? selectedColor : null;
    final colorFilter = iconColor != null ? ColorFilter.mode(iconColor, BlendMode.srcIn) : null;
    final textStyle = TextStyle(color: textColor, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal);

    if (hasChildren) {
      // Menu item with children (ExpansionTile)
      if (!isExpanded) {
        return Tooltip(
          message: menu.title,
          child: Container(
            height: 56,
            width: double.infinity,
            alignment: Alignment.center,
            child: SvgPicture.asset(menu.icon, colorFilter: colorFilter),
          ),
        );
      }
      return ExpansionTile(
        leading: SvgPicture.asset(menu.icon, colorFilter: colorFilter),
        title: Text(menu.title, style: textStyle),
        initiallyExpanded: isSelected,
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        childrenPadding: const EdgeInsets.only(left: 16),
        shape: const Border(),
        collapsedShape: const Border(),
        children: menu.children.map((submenu) => _SidebarSubMenuItem(submenu: submenu)).toList(),
      );
    }

    // Single menu item
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // Increased padding
      child: Material(
        color: isSelected ? selectedColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            if (menu.route != null) {
              context.go(menu.route!); 
              if (Scaffold.of(context).isDrawerOpen) {
                Navigator.of(context).pop();
              }
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Tooltip(
            message: isExpanded ? '' : menu.title,
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  Container(
                    width: isExpanded ? 56 : (80 - 32), // 80 (sidebar) - 32 (list padding)
                    alignment: Alignment.center,
                    child: SvgPicture.asset(menu.icon, colorFilter: colorFilter),
                  ),
                  if (isExpanded)
                    Expanded(
                      child: Text(
                        menu.title,
                        style: textStyle,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarSubMenuItem extends StatelessWidget {
  final SidebarMenuModel submenu;

  const _SidebarSubMenuItem({required this.submenu});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final location = GoRouterState.of(context).uri.toString();
    final isSelected = location == submenu.route;
    final selectedColor = theme.primaryColor;

    return ListTile(
      leading: SvgPicture.asset(
        isSelected ? AppIcons.circle : AppIcons.circleOutlined,
        width: 12,
        height: 12,
        colorFilter: ColorFilter.mode(
          isSelected ? selectedColor : theme.unselectedWidgetColor,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        submenu.title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isSelected ? selectedColor : null,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      onTap: () {
        if (submenu.route != null) {
          context.go(submenu.route!); 
          if (Scaffold.of(context).isDrawerOpen) {
            Navigator.of(context).pop();
          }
        }
      },
      selected: isSelected,
      selectedTileColor: Colors.transparent,
      dense: true,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
      contentPadding: EdgeInsets.zero,
    );
  }
}
