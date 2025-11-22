import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/competition_config_entity.dart';
import '../bloc/competition_config_bloc.dart';
import '../bloc/competition_config_event.dart';

class CompetitionConfigItem extends StatelessWidget {
  final CompetitionConfigEntity config;
  final int index;

  const CompetitionConfigItem({
    required Key key,
    required this.config,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    final double spacing = isMobile ? 8.0 : 16.0;
    final double logoSize = isMobile ? 32.0 : 40.0;
    final double switchContainerWidth = isMobile ? 50.0 : 100.0;
    final int cacheSize = (logoSize * MediaQuery.of(context).devicePixelRatio).round();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(isMobile ? 8.0 : 12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: index,
            child: Icon(Icons.drag_indicator, color: Colors.grey, size: isMobile ? 20 : 24),
          ),
          SizedBox(width: spacing),
          CachedNetworkImage(
            imageUrl: config.competitionDetails.logo,
            width: logoSize,
            height: logoSize,
            memCacheWidth: cacheSize,
            memCacheHeight: cacheSize,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: theme.colorScheme.surfaceContainerHighest,
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
            errorWidget: (context, url, error) => Icon(Icons.broken_image, size: logoSize),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.competitionDetails.shortName,
                  style: isMobile
                      ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)
                      : theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (config.competitionDetails.country != null)
                  Text(
                    config.competitionDetails.country!.name,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          SizedBox(
            width: switchContainerWidth,
            child: Center(
              child: Transform.scale(
                scale: isMobile ? 0.8 : 1.0,
                child: Switch(
                  value: config.isActiveByDefault,
                  onChanged: (value) {
                    context.read<CompetitionConfigBloc>().add(
                          ToggleCompetitionStatusEvent(config.id, value),
                        );
                  },
                ),
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(), // Compact icon button
            icon: SvgPicture.asset(
              AppIcons.trash,
              width: isMobile ? 20 : 24,
              height: isMobile ? 20 : 24,
              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text(s.deleteCompetition),
                    content: Text(s.deleteCompetitionConfirmation),
                    actions: <Widget>[
                      TextButton(
                        child: Text(s.cancel),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          s.delete,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                        onPressed: () {
                          context.read<CompetitionConfigBloc>().add(
                                DeleteCompetitionConfigEvent(config.id),
                              );
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                    ],
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
