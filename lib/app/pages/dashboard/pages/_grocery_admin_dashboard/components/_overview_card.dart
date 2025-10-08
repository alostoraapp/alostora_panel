// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/core.dart';

class OverviewCardWidget extends StatelessWidget {
  const OverviewCardWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.showCompactValue = false,
    this.fluctuationAmount = 0,
    this.showCompactFluctuation = false,
    this.fluctuationFrequency,
    this.cardDecoration,
    this.fluctuationBgPadding,
    this.hasIncreases = true,
    this.customCurrency,
    this.showCurrency = true,
  });
  final String label;
  final num value;
  final SvgImageHolder? icon;
  final bool showCompactValue;
  final num fluctuationAmount;
  final bool showCompactFluctuation;
  final String? fluctuationFrequency;
  final Decoration? cardDecoration;

  final EdgeInsetsGeometry? fluctuationBgPadding;
  final bool hasIncreases;
  final String? customCurrency;
  final bool showCurrency;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _locale = Localizations.localeOf(context);
    final _currency = customCurrency ??
        intl.NumberFormat.simpleCurrency(locale: _locale.countryCode)
            .currencySymbol;

    final _fluctuationColor =
        hasIncreases ? AcnooAppColors.kSuccess : AcnooAppColors.kError;

    final _value = showCompactValue
        ? intl.NumberFormat.compactCurrency(
            decimalDigits: 0,
            symbol: showCurrency ? _currency : '',
          ).format(value)
        : intl.NumberFormat.currency(
            decimalDigits: 0,
            symbol: showCurrency ? _currency : '',
          ).format(value);

    final _fluctuationAmount = showCompactFluctuation
        ? intl.NumberFormat.compactCurrency(
            decimalDigits: 0,
            symbol: showCurrency ? _currency : '',
          ).format(fluctuationAmount)
        : intl.NumberFormat.currency(
            decimalDigits: 0,
            symbol: showCurrency ? _currency : '',
          ).format(fluctuationAmount);

    return Container(
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      decoration: cardDecoration ??
          BoxDecoration(
            color: _theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Value
                    Text(
                      _value,
                      style: _theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Title
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: _theme.checkboxTheme.side?.color,
                      ),
                    ),
                  ],
                ),
              ),
              if (icon != null)
                Container(
                  constraints: BoxConstraints.tight(Size.square(48)),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: icon?.baseColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(icon!.svgPath),
                )
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: fluctuationBgPadding ?? const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _theme.colorScheme.primaryContainer,
              border: Border.all(color: _theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  hasIncreases ? FeatherIcons.arrowUp : FeatherIcons.arrowDown,
                  size: 14,
                  color: _fluctuationColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    _fluctuationAmount,
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      color: _fluctuationColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      fluctuationFrequency ?? l.S.current.thisMonth,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _theme.textTheme.bodyMedium?.copyWith(
                        color: _theme.checkboxTheme.side?.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
