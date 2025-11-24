import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../domain/entities/player_lineup_entity.dart';

class PlayerCard extends StatelessWidget {
  final PlayerLineupEntity player;
  final bool isManOfTheMatch;

  const PlayerCard({
    super.key,
    required this.player,
    this.isManOfTheMatch = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final hasPlayerData = player.player != null;

    // The image widget for the player
    final playerImage = SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 25, // 50 / 2
            backgroundColor: theme.colorScheme.surface, // A neutral background
            backgroundImage: hasPlayerData && player.player!.logo != null
                ? NetworkImage(player.player!.logo!)
                : null,
            onBackgroundImageError:
                hasPlayerData && player.player!.logo != null
                    ? (exception, stackTrace) {}
                    : null,
            child: !hasPlayerData || player.player!.logo == null
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
                player.shirtNumber.toString(),
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

    return Container(
      height: 72, // Fixed height for homogeneity
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isManOfTheMatch
              ? AppColors.kGold
              : theme.dividerColor,
          width: isManOfTheMatch ? 1.5 : 1.0,
        ),
        boxShadow: isManOfTheMatch
            ? [
                BoxShadow(
                  color: AppColors.kGold.withOpacity(0.25),
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
                    ? (player.player!.shortName ?? player.player!.name)
                    : 'Unknown Player', // Fallback text
                style:
                    theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            if (isManOfTheMatch) ...[
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
    );
  }
}
