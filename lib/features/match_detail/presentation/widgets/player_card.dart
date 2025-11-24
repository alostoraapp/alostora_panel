import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/player_lineup_entity.dart';
import '../bloc/lineup_bloc.dart';

class PlayerCard extends StatefulWidget {
  final PlayerLineupEntity player;
  final bool isManOfTheMatch;
  final String matchId;

  const PlayerCard({
    super.key,
    required this.player,
    this.isManOfTheMatch = false,
    required this.matchId,
  });

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  bool _isHovered = false;

  void _showConfirmationDialog() {
    final playerName =
        widget.player.player?.name ?? S.of(context).unknownPlayer;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final textTheme = Theme.of(context).textTheme;
        return AlertDialog(
          title: Text(S.of(context).confirmMOTMTitle),
          content: Text(
            S.of(context).confirmMOTMMessage(playerName),
            style: textTheme.titleMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).yes),
              onPressed: () {
                // Note: We need to use the BLoC from the parent context
                // that provides the LineupBloc.
                BlocProvider.of<LineupBloc>(this.context).add(
                  UpdateManOfTheMatchEvent(
                    matchId: widget.matchId,
                    playerLineupId: widget.player.id,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final hasPlayerData = widget.player.player != null;

    final playerImage = SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: theme.colorScheme.surface,
            backgroundImage: hasPlayerData && widget.player.player!.logo != null
                ? NetworkImage(widget.player.player!.logo!)
                : null,
            onBackgroundImageError:
                hasPlayerData && widget.player.player!.logo != null
                    ? (exception, stackTrace) {}
                    : null,
            child: !hasPlayerData || widget.player.player!.logo == null
                ? const Icon(Icons.person, size: 30, color: Colors.white70)
                : null,
          ),
          Positioned(
            bottom: -5,
            right: -5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: ShapeDecoration(
                color: theme.colorScheme.secondary,
                shape: const StadiumBorder(),
              ),
              child: Text(
                widget.player.shirtNumber.toString(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: _showConfirmationDialog,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppColors.kPrimary600
                  : (widget.isManOfTheMatch
                      ? AppColors.kGold
                      : theme.dividerColor),
              width: _isHovered || widget.isManOfTheMatch ? 1.5 : 1.0,
            ),
            boxShadow: _isHovered || widget.isManOfTheMatch
                ? [
                    BoxShadow(
                      color: (widget.isManOfTheMatch
                              ? AppColors.kGold
                              : AppColors.kPrimary600)
                          .withOpacity(0.25),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                playerImage,
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hasPlayerData
                        ? (widget.player.player!.shortName ??
                            widget.player.player!.name)
                        : S.of(context).unknownPlayer,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (widget.isManOfTheMatch) ...[
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    AppIcons.trophyStar,
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      AppColors.kGold,
                      BlendMode.srcIn,
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
