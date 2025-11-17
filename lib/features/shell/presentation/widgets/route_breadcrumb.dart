import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/breadcrumb_config.dart';
import '../../domain/entities/route_breadcrumb_model.dart';
import '../../../../core/constants/app_icons.dart';

class RouteBreadcrumb extends StatelessWidget {
  const RouteBreadcrumb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = IconTheme.of(context).color;
    final location = GoRouterState.of(context).uri.toString();
    final breadcrumbConfig = getBreadcrumbConfig(context);
    final breadcrumb = breadcrumbConfig[location];

    if (breadcrumb == null) {
      return const SizedBox.shrink(); // Don't show breadcrumb if not found
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            breadcrumb.title,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  AppIcons.house,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
                ),
                onPressed: () => context.go('/dashboard'), // Assuming dashboard is the home route
              ),
              Text(
                '/ ${breadcrumb.parentRoute} / ',
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                breadcrumb.childRoute,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
