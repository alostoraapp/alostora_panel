import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart' as rf;
import '_pharmacy_loss_profit_chart.dart' as comp;

import '../../../../../widgets/widgets.dart';

class StraightLineTextView extends StatelessWidget {
  const StraightLineTextView({
    super.key,
    this.headerText,
    this.dataTitle,
    this.dataValue,
    this.data2Title,
    this.data2Value,
  });

  final String? headerText;
  final String? dataTitle;
  final String? dataValue;
  final String? data2Title;
  final String? data2Value;
  @override
  Widget build(BuildContext context) {
    final _mqSize = MediaQuery.of(context).size.width;

    const _profitColor1 = Color(0xff2BB2FE);
    const _profitColor2 = Color(0xff22CAAD);
    const _lossColor1 = Color(0xffF86624);
    const _lossColor2 = Color(0xffF9C80E);

    final _sizeInfo = rf.ResponsiveValue<_SizeInfo>(
      context,
      conditionalValues: const [
        rf.Condition.between(
          start: 0,
          end: 350,
          value: _SizeInfo(
            fonstSize: 16,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        rf.Condition.between(
          start: 351,
          end: 410,
          value: _SizeInfo(
            fonstSize: 18,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        rf.Condition.between(
          start: 411,
          end: 675,
          value: _SizeInfo(
            fonstSize: 18,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
      defaultValue: const _SizeInfo(),
    ).value;

    final _theme = Theme.of(context);

    return Padding(
      padding: _sizeInfo.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              headerText ?? '',
              style: _theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: _sizeInfo.fonstSize,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (_mqSize > 768)
            Wrap(
              children: [
                comp.BuildIndicator(
                  title: dataTitle ?? '',
                  color: [_profitColor1, _profitColor2],
                  amount: dataValue ?? '',
                ),
                const SizedBox(width: 16),
                comp.BuildIndicator(
                  title: data2Title ?? '',
                  color: [_lossColor1, _lossColor2],
                  amount: data2Value ?? '',
                ),
              ],
            ),
          FilterDropdownButton(
            buttonDecoration: BoxDecoration(
              color: _theme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
          )
        ],
      ),
    );
  }
}

class _SizeInfo {
  final double? fonstSize;
  final EdgeInsetsGeometry padding;
  const _SizeInfo({
    this.fonstSize = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });
}
