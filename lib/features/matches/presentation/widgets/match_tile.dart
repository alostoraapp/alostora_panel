import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app_router.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../domain/entities/match_entity.dart';
import '../../domain/entities/match_status_enum.dart';
import '../../domain/entities/team_entity.dart';

class MatchTile extends StatefulWidget {
  final MatchEntity match;
  final bool isInteractive;
  final VoidCallback? onTap;

  const MatchTile({
    super.key,
    required this.match,
    this.isInteractive = true,
    this.onTap,
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
        return s.matchStatusTBD;
      case MatchStatus.unknown:
        return s.matchStatusUnknown;
    }
  }

  String _getMatchMinute(MatchEntity match) {
    // Handle first half minutes
    if (match.status == MatchStatus.firstHalf &&
        match.firstHalfStartTime != null) {
      final now = DateTime.now();
      final difference = now.difference(match.firstHalfStartTime!);
      int minutes = difference.inMinutes;

      // Regular time for the first half is 1' to 45'
      if (minutes >= 0 && minutes <= 45) {
        return '$minutes\'';
      }
      // Handle stoppage time for the first half
      else if (minutes > 45) {
        final stoppageTime = minutes - 45;
        return '45+${stoppageTime}\'';
      }
    }
    // Handle second half minutes
    else if (match.status == MatchStatus.secondHalf &&
        match.secondHalfStartTime != null) {
      final now = DateTime.now();
      final difference = now.difference(match.secondHalfStartTime!);
      // The second half starts at 45 minutes into the game
      int minutes = 45 + difference.inMinutes;

      // Regular time for the second half is 46' to 90'
      if (minutes > 45 && minutes <= 90) {
        return '$minutes\'';
      }
      // Handle stoppage time for the second half
      else if (minutes > 90) {
        final stoppageTime = minutes - 90;
        return '90+${stoppageTime}\'';
      }
    }

    // Return an empty string if the match is not in the first or second half,
    // or if the start times are not available
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
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    final hasIndicators = widget.isInteractive &&
        (widget.match.hasManOfTheMatch ||
            widget.match.hasIncidentsMedia ||
            widget.match.hasHighlights ||
            widget.match.hasLiveBroadcast ||
            widget.match.hasCommentators);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: widget.isInteractive
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.isInteractive
            ? (widget.onTap ??
                () {
                  context.pushNamed(
                    AppRoutes.matchDetail,
                    pathParameters: {'matchId': widget.match.id},
                    extra: widget.match,
                  );
                })
            : null,
        child: Card(
          elevation: _isHovering && widget.isInteractive ? 4 : 1,
          shadowColor: isLive && widget.isInteractive
              ? Colors.red.withOpacity(0.5)
              : (_isHovering && widget.isInteractive
                  ? theme.colorScheme.primary.withOpacity(0.3)
                  : Colors.black12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isLive && widget.isInteractive
                ? const BorderSide(color: Colors.red, width: 1.5)
                : BorderSide(
                    color: _isHovering && widget.isInteractive
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                    width: 1,
                  ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 8.0 : 16.0,
              vertical: widget.isInteractive
                  ? 6.0
                  : 2.0, // Reduced padding when not interactive
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasIndicators)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Wrap(
                      spacing: isMobile ? 2 : 4,
                      runSpacing: isMobile ? 2 : 4,
                      alignment: WrapAlignment.center,
                      children: [
                        if (widget.match.hasManOfTheMatch)
                          _buildIndicator(theme, 'B', Colors.amber, isMobile),
                        if (widget.match.hasIncidentsMedia)
                          _buildIndicator(theme, 'E', Colors.blue, isMobile),
                        if (widget.match.hasHighlights)
                          _buildIndicator(theme, 'H', Colors.purple, isMobile),
                        if (widget.match.hasLiveBroadcast)
                          _buildIndicator(theme, 'L', Colors.red, isMobile),
                        if (widget.match.hasCommentators)
                          _buildIndicator(theme, 'C', Colors.orange, isMobile),
                      ],
                    ),
                  ),
                Row(
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTeam(theme,
                        team: widget.match.homeTeam, isMobile: isMobile),
                    _buildCenterInfo(theme,
                        match: widget.match, isMobile: isMobile),
                    _buildTeam(theme,
                        team: widget.match.awayTeam,
                        isReversed: true,
                        isMobile: isMobile),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeam(ThemeData theme,
      {required TeamEntity team,
      bool isReversed = false,
      required bool isMobile}) {
    // Reduced logo size when not interactive (e.g. in AppBar)
    final double logoSize = isMobile ? 32 : (widget.isInteractive ? 40 : 32);

    final logo = InkWell(
      onTap: () {
        context.pushNamed(
          AppRoutes.teamDetail,
          pathParameters: {'teamId': team.id},
        );
      },
      borderRadius: BorderRadius.circular(logoSize / 2),
      child: CachedNetworkImage(
        imageUrl: team.logo,
        width: logoSize,
        height: logoSize,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: theme.colorScheme.surfaceVariant,
          highlightColor: theme.colorScheme.onSurface.withOpacity(0.1),
          child: Container(
            width: logoSize,
            height: logoSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        errorWidget: (context, url, error) => SvgPicture.asset(
          AppIcons.shield,
          width: logoSize,
          height: logoSize,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),
      ),
    );

    final textStyle = isMobile
        ? theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.normal)
        : theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);

    final text = Text(
      team.shortName,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: isMobile ? TextAlign.center : null,
    );

    if (isMobile) {
      return Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            logo,
            const SizedBox(height: 4),
            text,
          ],
        ),
      );
    }

    return Expanded(
      flex: 3,
      child: isReversed
          ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                  child: Align(
                      alignment: AlignmentDirectional.centerEnd, child: text)),
              const SizedBox(width: 8),
              logo
            ])
          : Row(children: [
              logo,
              const SizedBox(width: 8),
              Expanded(child: text)
            ]),
    );
  }

  Widget _buildCenterInfo(ThemeData theme,
      {required MatchEntity match, required bool isMobile}) {
    final statusText = _getMatchStatusText(match.status, context);
    final matchMinute = _getMatchMinute(match);
    final startTime = DateFormat('HH:mm').format(match.matchTime.toLocal());
    final isLive = _isLive(match.status);

    // Removed MatchStatus.afterPenalties as it doesn't exist in MatchStatus enum
    final showScore = isLive ||
        match.status == MatchStatus.ended ||
        match.status == MatchStatus.penaltyShootout;

    final hasIndicators = widget.isInteractive &&
        (match.hasManOfTheMatch ||
            match.hasIncidentsMedia ||
            match.hasHighlights ||
            match.hasLiveBroadcast ||
            match.hasCommentators);

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (match.status == MatchStatus.notStarted && !hasIndicators)
            Text(
              startTime,
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            ),
          if (showScore)
            Text(
              '${match.homeScoreFinal} - ${match.awayScoreFinal}',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 18 : 24,
              ),
            ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color,
                fontWeight: isLive ? FontWeight.bold : FontWeight.normal,
              ),
              children: [
                TextSpan(text: statusText),
                if (matchMinute.isNotEmpty)
                  TextSpan(
                    text: '   $matchMinute',
                    style: TextStyle(
                      color: isLive ? Colors.red : theme.hintColor,
                      fontWeight: isLive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(
      ThemeData theme, String text, Color color, bool isMobile) {
    final double size = isMobile ? 14 : 17;
    final double fontSize = isMobile ? 8 : 10;
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MatchTileShimmer extends StatelessWidget {
  const MatchTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceVariant,
      highlightColor: theme.colorScheme.onSurface.withOpacity(0.1),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 8.0 : 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamShimmer(theme, isMobile: isMobile),
              _buildCenterInfoShimmer(theme),
              _buildTeamShimmer(theme, isReversed: true, isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamShimmer(ThemeData theme,
      {bool isReversed = false, required bool isMobile}) {
    final double logoSize = isMobile ? 32 : 40;
    final logo = Container(
      width: logoSize,
      height: logoSize,
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

    if (isMobile) {
      return Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            const SizedBox(height: 4),
            text,
          ],
        ),
      );
    }

    return Expanded(
      flex: 3,
      child: isReversed
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [text, const SizedBox(width: 8), logo])
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
