import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/core.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key, required this.cardData});
  final OverviewCardData cardData;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final bgColor = cardData.backgroundColor ?? Colors.blue;
    final fgColor = Colors.white;

    final _secondaryValue = getStatusColor(cardData.secondaryValue ?? 0);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            bgColor,
            bgColor.withValues(alpha: 0.60),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Shape
          ...[
            PositionedDirectional(
              bottom: 5,
              end: -50,
              child: _buildBgCircleShape(context),
            ),
            PositionedDirectional(
              bottom: 60,
              end: -50,
              child: _buildBgCircleShape(context),
            ),

            // Icon
            if (cardData.iconPath != null)
              PositionedDirectional(
                top: 20,
                end: 20,
                child: SizedBox.square(
                  dimension: 48,
                  child: CircleAvatar(
                    backgroundColor: fgColor,
                    child: SvgPicture.asset(cardData.iconPath!),
                  ),
                ),
              )
          ],

          // Content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Primary Label
                  Text(
                    cardData.primaryLabel ?? "N/A",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: fgColor,
                    ),
                  ),

                  // Primary Value
                  Text(
                    cardData.primaryValue?.toString() ?? "N/A",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: fgColor,
                    ),
                  ),
                  const SizedBox.square(dimension: 25),

                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 6,
                      children: [
                        // Secondary Label
                        Expanded(
                          child: Text(
                            cardData.secondaryLabel ?? "N/A",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: fgColor,
                            ),
                          ),
                        ),

                        // Secondary Value
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: fgColor,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            color: fgColor.withValues(alpha: 0.95),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _secondaryValue.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: _secondaryValue.color,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ).hover();
  }

  Widget _buildBgCircleShape(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(Size.square(155)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [
            Colors.white.withAlpha(0),
            Colors.white.withValues(alpha: 0.15),
          ],
        ),
      ),
    );
  }

  ({Color color, String value}) getStatusColor(num value) {
    final color = value < 0
        ? AcnooAppColors.kError
        : value == 0
            ? AcnooAppColors.kNeutral700
            : AcnooAppColors.kSuccess;
    final newValue = value < 0 ? value.toString() : "+$value";

    return (color: color, value: newValue);
  }
}

class OverviewCard2 extends StatelessWidget {
  const OverviewCard2({super.key, required this.cardData});
  final OverviewCardData cardData;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final bgColor = cardData.backgroundColor ?? Colors.blue;
    final fgColor = Colors.white;

    final _secondaryValue = getStatusColor(cardData.secondaryValue ?? 0);

    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bgColor,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 12,
            children: [
              // Icon
              SizedBox.square(
                dimension: 40,
                child: CircleAvatar(
                  backgroundColor: fgColor,
                  child: SvgPicture.asset(cardData.iconPath!),
                ),
              ),
              Expanded(
                child: Text(
                  cardData.primaryLabel ?? "N/A",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox.square(dimension: 20),
          Text(
            cardData.primaryValue?.toString() ?? "N/A",
            style: _theme.textTheme.headlineLarge?.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox.square(dimension: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 6,
            children: [
              // Secondary Label
              Expanded(
                child: Text(
                  cardData.secondaryLabel ?? "N/A",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Secondary Value
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: fgColor,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  color: fgColor.withValues(alpha: 0.95),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  _secondaryValue.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: _secondaryValue.color,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ).hover();
  }

  ({Color color, String value}) getStatusColor(num value) {
    final color = value < 0
        ? AcnooAppColors.kError
        : value == 0
            ? AcnooAppColors.kNeutral700
            : AcnooAppColors.kSuccess;
    final newValue = value < 0 ? value.toString() : "+$value";

    return (color: color, value: newValue);
  }
}

class OverviewCardData {
  final String? primaryLabel;
  final num? primaryValue;
  final String? secondaryLabel;
  final num? secondaryValue;

  /// [backgroundColor] will act like the seed color for the card's background gradient
  final Color? backgroundColor;

  /// [iconPath] must be a SVG image path.
  final String? iconPath;
  OverviewCardData({
    this.primaryLabel,
    this.primaryValue,
    this.secondaryLabel,
    this.secondaryValue,
    this.backgroundColor,
    this.iconPath,
  });

  OverviewCardData copyWith({
    String? primaryLabel,
    num? primaryValue,
    String? secondaryLabel,
    num? secondaryValue,
    Color? backgroundColor,
    String? iconPath,
  }) {
    return OverviewCardData(
      primaryLabel: primaryLabel ?? this.primaryLabel,
      primaryValue: primaryValue ?? this.primaryValue,
      secondaryLabel: secondaryLabel ?? this.secondaryLabel,
      secondaryValue: secondaryValue ?? this.secondaryValue,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconPath: iconPath ?? this.iconPath,
    );
  }
}
