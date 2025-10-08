import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/core.dart';

class PharmacyPosOverview extends StatefulWidget {
  const PharmacyPosOverview({
    super.key,
    required this.title,
    required this.value,
    required this.subAmount,
    required this.icon,
    required this.days,
    required this.isFirstIndex,
  });
  final String title;
  final String value;
  final String subAmount;
  final SvgImageHolder icon;
  final String days;
  final bool isFirstIndex;

  @override
  State<PharmacyPosOverview> createState() => _PharmacyPosOverviewState();
}

class _PharmacyPosOverviewState extends State<PharmacyPosOverview> {
  final Color kMainColor = Color(0xff00987F);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsetsDirectional.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: '${widget.subAmount} ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: widget.isFirstIndex ? theme.colorScheme.error : theme.colorScheme.onTertiary,
                    ),
                    children: [
                      WidgetSpan(child: SizedBox(width: 2)),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: widget.isFirstIndex == true
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.arrow_drop_up_outlined,
                                color: kMainColor,
                              ),
                      ),
                      WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: widget.days,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            top: -15,
            end: -30,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 22,
                bottom: 25,
                top: 35,
                end: 44,
              ),
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: widget.icon.gradientColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                child: SvgPicture.asset(widget.icon.svgPath),
              ),
            ),
          ),
        ],
      ),
    ).hover();
  }
}
