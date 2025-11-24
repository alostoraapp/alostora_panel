import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../injection_container.dart';
import '../bloc/lineup_bloc.dart';
import 'best_player_tab.dart';

class MatchDetailTabBar extends StatefulWidget {
  const MatchDetailTabBar(
      {super.key,
      required this.theme,
      required this.textTheme,
      required this.matchId});
  final ThemeData theme;
  final TextTheme textTheme;
  final String matchId;
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
    _tabController = TabController(length: 5, vsync: this);
    _lineupBloc.add(GetLineupEvent(matchId: widget.matchId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> get _title => [
        S.of(context).bestPlayer,
        S.of(context).summary,
        S.of(context).stats,
        S.of(context).h2h,
        S.of(context).standings,
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
          child: BlocListener<LanguageCubit, Locale>(
            listener: (context, locale) {
              _lineupBloc.add(GetLineupEvent(matchId: widget.matchId));
            },
            child: BlocBuilder<LineupBloc, LineupState>(
              bloc: _lineupBloc,
              builder: (context, state) {
                if (state is LineupLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is LineupError) {
                  return Center(child: Text(state.message));
                }
                if (state is LineupLoaded) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      BestPlayerTab(lineup: state.lineup),
                      const Center(child: Text('Summary View')),
                      const Center(child: Text('Stats View')),
                      const Center(child: Text('H2H View')),
                      const Center(child: Text('Standings View')),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }
}
