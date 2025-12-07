import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/widgets/error_view.dart';
import '../../domain/entities/lineup_entity.dart';
import '../../domain/entities/player_lineup_entity.dart';
import '../../domain/entities/team_lineup_info_entity.dart';
import '../bloc/lineup_bloc.dart';
import 'player_card.dart';

class BestPlayerTab extends StatefulWidget {
  final String matchId;
  const BestPlayerTab({super.key, required this.matchId});

  @override
  State<BestPlayerTab> createState() => _BestPlayerTabState();
}

class _BestPlayerTabState extends State<BestPlayerTab> {
  late int _selectedTeamSide;

  @override
  void initState() {
    super.initState();
    _selectedTeamSide = 1; // Default to home team
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineupBloc, LineupState>(
      builder: (context, state) {
        if (state is LineupLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LineupError) {
          return ErrorView(
            message: state.message,
            onRetry: () => context
                .read<LineupBloc>()
                .add(GetLineupEvent(matchId: widget.matchId)),
          );
        }
        if (state is LineupLoaded) {
          final lineup = state.lineup;
          final starters = lineup.players
              .where((p) => p.teamSide == _selectedTeamSide && p.isStarter)
              .toList();
          final bench = lineup.players
              .where((p) => p.teamSide == _selectedTeamSide && !p.isStarter)
              .toList();

          return ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildTeamToggle(context, lineup),
                  const SizedBox(height: 18),
                  _buildPlayerSection(
                    context,
                    title: S.of(context).onThePitch,
                    players: starters,
                    lineup: lineup,
                  ),
                  const SizedBox(height: 24),
                  _buildPlayerSection(
                    context,
                    title: S.of(context).onTheBench,
                    players: bench,
                    lineup: lineup,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTeamToggle(BuildContext context, LineupEntity lineup) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _TeamToggleButton(
            team: lineup.homeTeam,
            isSelected: _selectedTeamSide == 1,
            onTap: () => setState(() => _selectedTeamSide = 1),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _TeamToggleButton(
            team: lineup.awayTeam,
            isSelected: _selectedTeamSide == 2,
            onTap: () => setState(() => _selectedTeamSide = 2),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerSection(
    BuildContext context, {
    required String title,
    required List<PlayerLineupEntity> players,
    required LineupEntity lineup,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final breakpoints = ResponsiveBreakpoints.of(context);
              final int crossAxisCount = breakpoints.equals('4K')
                  ? 5
                  : (breakpoints.isDesktop ? 3 : 1);
              const double itemHeight = 76.0;
              const double crossAxisSpacing = 16.0;
              const double mainAxisSpacing = 16.0;

              final double itemWidth = (constraints.maxWidth -
                      (crossAxisSpacing * (crossAxisCount - 1))) /
                  crossAxisCount;
              final double childAspectRatio =
                  itemWidth > 0 ? itemWidth / itemHeight : 1.0;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  final isManOfTheMatch = player.id == lineup.manOfTheMatchId;
                  return PlayerCard(
                    player: player,
                    isManOfTheMatch: isManOfTheMatch,
                    matchId: widget.matchId,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TeamToggleButton extends StatelessWidget {
  final TeamLineupInfoEntity team;
  final bool isSelected;
  final VoidCallback onTap;

  const _TeamToggleButton({
    required this.team,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (team.logo != null)
              Image.network(
                team.logo!,
                height: 40,
                width: 40,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.shield, size: 40),
              ),
            const SizedBox(width: 8.0),
            Text(
              team.displayName ?? team.name,
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
