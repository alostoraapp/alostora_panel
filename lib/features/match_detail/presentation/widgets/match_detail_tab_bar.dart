import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../injection_container.dart';
import '../../../matches/domain/entities/match_entity.dart';
import '../bloc/lineup_bloc.dart';
import 'best_player_tab.dart';
import 'events_tab.dart';
import 'highlights_tab.dart';

class MatchDetailTabBar extends StatefulWidget {
  const MatchDetailTabBar({
    super.key,
    required this.theme,
    required this.textTheme,
    required this.match,
  });
  final ThemeData theme;
  final TextTheme textTheme;
  final MatchEntity match;
  @override
  State<MatchDetailTabBar> createState() => _MatchDetailTabBarState();
}

class _MatchDetailTabBarState extends State<MatchDetailTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final LineupBloc _lineupBloc = sl<LineupBloc>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _lineupBloc.add(GetLineupEvent(matchId: widget.match.id));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _lineupBloc.close();
    super.dispose();
  }

  List<String> get _title => [
        S.of(context).events,
        S.of(context).bestPlayer,
        S.of(context).highlights,
        S.of(context).live,
        S.of(context).details,
      ];

  void _onTabTapped(int index) {
    _tabController.animateTo(index);
  }

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
          onTap: _onTabTapped,
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
          child: BlocProvider.value(
            value: _lineupBloc,
            child: BlocListener<LanguageCubit, Locale>(
              listener: (context, locale) {
                _lineupBloc.add(GetLineupEvent(matchId: widget.match.id));
              },
              child: TabBarView(
                controller: _tabController,
                children: [
                  EventsTab(matchId: widget.match.id),
                  BestPlayerTab(
                    matchId: widget.match.id,
                  ),
                  HighlightsTab(matchId: widget.match.id),
                  const Center(child: Text('H2H View')),
                  const Center(child: Text('Standings View')),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
