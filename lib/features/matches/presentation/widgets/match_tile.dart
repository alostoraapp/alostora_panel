import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
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
      final minutes = difference.inMinutes;
      if (minutes > 45) {
        return '45+${minutes - 45}\'';
      }
      return '$minutes\'';
    }
    if (match.status == MatchStatus.secondHalf && match.secondHalfStartTime != null) {
      final difference = DateTime.now().difference(match.secondHalfStartTime!);
      final minutes = 90 + difference.inMinutes - 45; // Assuming second half starts at 45, which is not always true but standard for calculation relative to start time if we treat it as absolute match time, but better:
       // Standard logic: 45 + (now - second_half_start). 
      final secondHalfMinutes = difference.inMinutes;
      final totalMinutes = 45 + secondHalfMinutes;
      
      if (totalMinutes > 90) {
        return '90+${totalMinutes - 90}\'';
      }
      return '$totalMinutes\'';
    }
    return '';
  }

  bool _isLive(MatchStatus status) {
    return status == MatchStatus.firstHalf ||
        status == MatchStatus.secondHalf ||
        status == MatchStatus.halfTime ||
        status == MatchStatus.overtime ||
        status == MatchStatus.penaltyShootout;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = context.watch<LanguageCubit>().isRTL();
    final isLive = _isLive(widget.match.status);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: _isHovering ? 4 : 1,
        shadowColor: isLive
            ? Colors.red.withOpacity(0.5)
            : (_isHovering ? theme.colorScheme.primary.withOpacity(0.3) : Colors.black12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isLive
              ? const BorderSide(color: Colors.red, width: 1.5)
              : BorderSide(
                  color: _isHovering ? theme.colorScheme.primary : Colors.transparent,
                  width: 1,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Row(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeam(theme, team: widget.match.homeTeam),
              _buildCenterInfo(theme, match: widget.match),
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
      width: 40,
      height: 40,
      placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2.0),
      errorWidget: (context, url, error) => const Icon(Icons.shield, size: 40, color: Colors.grey),
    );

    final text = Text(team.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis, maxLines: 2);

    return Expanded(
      flex: 3,
      child: isReversed
          ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [Expanded(child: Align(alignment: AlignmentDirectional.centerEnd, child: text)), const SizedBox(width: 8), logo])
          : Row(children: [logo, const SizedBox(width: 8), Expanded(child: text)]),
    );
  }

  Widget _buildCenterInfo(ThemeData theme, {required MatchEntity match}) {
    final statusText = _getMatchStatusText(match.status, context);
    final matchMinute = _getMatchMinute(match);
    final startTime = DateFormat('HH:mm').format(match.matchTime.toLocal());

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            startTime,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
          Text(
            '${match.homeScoreFinal} - ${match.awayScoreFinal}',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '$statusText $matchMinute'.trim(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: _isLive(match.status) ? Colors.red : theme.hintColor,
              fontWeight: _isLive(match.status) ? FontWeight.bold : FontWeight.normal,
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamShimmer(theme),
              _buildCenterInfoShimmer(theme),
              _buildTeamShimmer(theme, isReversed: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamShimmer(ThemeData theme, {bool isReversed = false}) {
    final logo = Container(
      width: 40,
      height: 40,
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
          ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [text, const SizedBox(width: 8), logo])
          : Row(children: [logo, const SizedBox(width: 8), text]),
    );
  }

  Widget _buildCenterInfoShimmer(ThemeData theme) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Container(
            height: 14,
            width: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Container(
            height: 24,
            width: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Container(
            height: 12,
            width: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
