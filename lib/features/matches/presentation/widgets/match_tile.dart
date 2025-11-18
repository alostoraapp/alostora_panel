import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../domain/entities/match_entity.dart';
import '../../domain/entities/match_status_enum.dart';
import '../../domain/entities/team_entity.dart';

class MatchTile extends StatefulWidget {
  final MatchEntity match;

  const MatchTile({
    super.key,
    required this.match,
  });

  @override
  State<MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
  bool _isHovering = false;

  String _getMatchStatusText(MatchStatus status, BuildContext context) {
    final s = S.of(context);
    switch (status) {
      case MatchStatus.abnormal:
        return s.matchStatusAbnormal;
      case MatchStatus.notStarted:
        return s.matchStatusNotStarted;
      case MatchStatus.firstHalf:
        return s.matchStatusFirstHalf;
      case MatchStatus.halfTime:
        return s.matchStatusHalfTime;
      case MatchStatus.secondHalf:
        return s.matchStatusSecondHalf;
      case MatchStatus.overtime:
        return s.matchStatusOvertime;
      case MatchStatus.overtimeDeprecated:
        return s.matchStatusOvertimeDeprecated;
      case MatchStatus.penaltyShootout:
        return s.matchStatusPenaltyShootout;
      case MatchStatus.ended:
        return s.matchStatusEnded;
      case MatchStatus.delayed:
        return s.matchStatusDelayed;
      case MatchStatus.interrupted:
        return s.matchStatusInterrupted;
      case MatchStatus.cutInHalf:
        return s.matchStatusCutInHalf;
      case MatchStatus.cancelled:
        return s.matchStatusCancelled;
      case MatchStatus.tbd:
        return s.matchStatusTbd;
      case MatchStatus.unknown:
      default:
        return s.matchStatusUnknown;
    }
  }

  String _getMatchMinute(MatchEntity match) {
    if (match.status == MatchStatus.firstHalf && match.firstHalfStartTime != null) {
      final difference = DateTime.now().difference(match.firstHalfStartTime!);
      return '${difference.inMinutes}\'';
    }
    if (match.status == MatchStatus.secondHalf && match.secondHalfStartTime != null) {
      final difference = DateTime.now().difference(match.secondHalfStartTime!);
      return '${45 + difference.inMinutes}\'';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = context.watch<LanguageCubit>().isRTL();
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: _isHovering ? 4 : 1,
        shadowColor: _isHovering ? theme.colorScheme.primary.withOpacity(0.3) : Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: _isHovering ? theme.colorScheme.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
          child: Row(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeam(theme, team: widget.match.homeTeam),
              _buildScore(theme, match: widget.match),
              _buildTeam(theme, team: widget.match.awayTeam, isReversed: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeam(ThemeData theme, {required TeamEntity team, bool isReversed = false}) {
    final logo = CachedNetworkImage(
      imageUrl: team.logo,
      width: 32,
      height: 32,
      placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2.0),
      errorWidget: (context, url, error) => const Icon(Icons.shield, size: 32, color: Colors.grey),
    );

    final text = Text(team.name, style: theme.textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2);

    return Expanded(
      flex: 3,
      child: isReversed
          ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [Expanded(child: Align(alignment: AlignmentDirectional.centerEnd, child: text)), const SizedBox(width: 6), logo])
          : Row(children: [logo, const SizedBox(width: 6), Expanded(child: text)]),
    );
  }

  Widget _buildScore(ThemeData theme, {required MatchEntity match}) {
    final statusText = _getMatchStatusText(match.status, context);
    final matchMinute = _getMatchMinute(match);

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${match.homeScoreFinal} - ${match.awayScoreFinal}',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '$statusText $matchMinute'.trim(),
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}

class MatchTileShimmer extends StatelessWidget {
  const MatchTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceVariant,
      highlightColor: theme.colorScheme.onSurface.withOpacity(0.1),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamShimmer(theme),
              _buildScoreShimmer(theme),
              _buildTeamShimmer(theme, isReversed: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamShimmer(ThemeData theme, {bool isReversed = false}) {
    final logo = Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );

    final text = Container(
      height: 16,
      width: 100,
      color: Colors.white,
    );

    return Expanded(
      flex: 3,
      child: isReversed
          ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [text, const SizedBox(width: 6), logo])
          : Row(children: [logo, const SizedBox(width: 6), text]),
    );
  }

  Widget _buildScoreShimmer(ThemeData theme) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Container(
            height: 12,
            width: 80,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
