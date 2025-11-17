import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ResponsiveGridRow(
          children: [
            _buildStatCard(
              context,
              icon: AppIcons.user,
              color: Colors.blue,
              label: s.totalUsers,
              value: '1,450',
              gridSize: 3,
            ),
            _buildStatCard(
              context,
              icon: AppIcons.wifi,
              color: Colors.green,
              label: s.onlineUsers,
              value: '128',
              gridSize: 3,
            ),
            _buildStatCard(
              context,
              icon: AppIcons.calendarDay,
              color: Colors.orange,
              label: s.todaysMatches,
              value: '24',
              gridSize: 3,
            ),
            _buildStatCard(
              context,
              icon: AppIcons.satelliteDish,
              color: Colors.red,
              label: s.liveMatches,
              value: '5',
              gridSize: 3,
            ),
            _buildStatCard(
              context,
              icon: AppIcons.calendar,
              color: Colors.purple,
              label: s.tomorrowsMatches,
              value: '18',
              gridSize: 3,
            ),
            _buildStatCard(
              context,
              icon: AppIcons.calendarWeek,
              color: Colors.teal,
              label: s.thisWeeksMatches,
              value: '76',
              gridSize: 3,
            ),
          ],
        ),
      ],
    );
  }

  ResponsiveGridCol _buildStatCard(BuildContext context, {
    required String icon,
    required Color color,
    required String label,
    required String value,
    int gridSize = 4,
  }) {
    final theme = Theme.of(context);
    return ResponsiveGridCol(
      lg: gridSize,
      md: 4,
      sm: 6,
      xs: 12,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
