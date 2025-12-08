import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = 1;
        if (width > 1600) {
          crossAxisCount = 3;
        } else if (width > 800) {
          crossAxisCount = 2;
        }

        // Calculate item width
        final totalSpacing = (crossAxisCount - 1) * spacing;
        final itemWidth = (width - totalSpacing) / crossAxisCount;

        // Simple Wrap-based implementation for equal height cards (if needed)
        // or just use Wrap. For true grid alignment, Wrap is okay if items are similar height.
        // But user asked for specific columns.

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onTap;
  final IconData? icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.children,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withOpacity(0.5),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabeledValue extends StatelessWidget {
  final String label;
  final Map<String, String>? values;
  final String? singleValue;
  final String? logoUrl;

  const LabeledValue({
    super.key,
    required this.label,
    this.values,
    this.singleValue,
    this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              if (logoUrl != null) ...[
                const SizedBox(width: 8),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(logoUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: _buildValues(context),
          ),
        ],
      ),
    );
  }

  Widget _buildValues(BuildContext context) {
    final theme = Theme.of(context);
    final valueStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
    );

    if (singleValue != null) {
      return Text(singleValue!, style: valueStyle);
    } else if (values != null && values!.isNotEmpty) {
      final sortedEntries = values!.entries.toList()
        ..sort((a, b) {
          if (a.key == 'en') return -1;
          if (b.key == 'en') return 1;
          if (a.key == 'ar') return -1;
          if (b.key == 'ar') return 1;
          return a.key.compareTo(b.key);
        });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sortedEntries.map((e) {
          final flagPath = _getFlagPath(e.key);
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (flagPath != null)
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAlias,
                    child: SvgPicture.asset(
                      flagPath,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Text(e.key.toUpperCase(),
                      style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 10),
                Text(e.value, style: valueStyle),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return Text('-', style: valueStyle?.copyWith(color: Colors.grey));
    }
  }

  String? _getFlagPath(String code) {
    switch (code) {
      case 'en':
        return AppIcons.flagUK;
      case 'ar':
        return AppIcons.flagSA;
      case 'fa':
        return AppIcons.flagIR;
      case 'fr':
        return AppIcons.flagFR;
      case 'es':
        return AppIcons.flagES;
      case 'de':
        return AppIcons.flagDE;
      case 'it':
        return AppIcons.flagIT;
      default:
        return null;
    }
  }
}
