import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/l10n/s.dart';

class MatchDetailTabBar extends StatefulWidget {
  const MatchDetailTabBar({super.key, required this.theme, required this.textTheme});
  final ThemeData theme;
  final TextTheme textTheme;
  @override
  State<MatchDetailTabBar> createState() => _MatchDetailTabBarState();
}

class _MatchDetailTabBarState extends State<MatchDetailTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> get _title => [
        S.of(context).details,
        S.of(context).bestPlayer,
        S.of(context).highlights,
        S.of(context).events,
      ];
  @override
  Widget build(BuildContext context) {
    final padding = responsiveValue<double>(
      context,
      xs: 16,
      sm: 16,
      md: 16,
      lg: 16,
    );
    return Column(
      children: [
        TabBar(
          splashBorderRadius: BorderRadius.circular(12),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          indicatorColor: AppColors.kPrimary600,
          indicatorWeight: 2.0,
          dividerColor: widget.theme.colorScheme.outline,
          unselectedLabelColor: widget.theme.colorScheme.onTertiary,
          tabs: _title
              .map(
                (e) => Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding / 2,
                    ),
                    child: Text(e),
                  ),
                ),
              )
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              // Details View
              Center(child: Text('Details View')),
              // Best Player View
              Center(child: Text('Best Player View')),
              // Highlights View
              Center(child: Text('Highlights View')),
              // Events View
              Center(child: Text('Events View')),
            ],
          ),
        ),
      ],
    );
  }
}
