import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/core.dart';

class LandlordOverView extends StatelessWidget {
  const LandlordOverView({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: const BoxConstraints.tightFor(height: 448),
      child: ListView.separated(
        itemCount: overViewItems.length,
        separatorBuilder: (_, __) {
          return Divider(color: _theme.colorScheme.outline, height: 1);
        },
        itemBuilder: (context, index) {
          final _data = overViewItems[index];
          return LandlordOverViewWidget(
            color: _data.color,
            title: _data.title,
            value: _data.value,
            trendingAmount: _data.trendingAmount,
            icon: _data.icon,
            durationText: _data.durationText,
            treadingIcon: _data.trendingIcon,
          );
        },
      ),
    );
  }
}

class LandlordOverViewWidget extends StatefulWidget {
  const LandlordOverViewWidget({
    super.key,
    required this.color,
    required this.title,
    required this.value,
    required this.trendingAmount,
    required this.icon,
    required this.durationText,
    required this.treadingIcon,
  });

  final Color color;
  final String title;
  final String value;
  final String trendingAmount;
  final String icon;
  final String durationText;
  final IconData treadingIcon;

  @override
  State<LandlordOverViewWidget> createState() => _LandlordOverViewWidgetState();
}

class _LandlordOverViewWidgetState extends State<LandlordOverViewWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              SvgPicture.asset(
                widget.icon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white : AcnooAppColors.kNeutral900,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 5),
              Text(widget.title,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 8),
            Text(widget.value,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8, // horizontal spacing between items
              runSpacing: 8, // vertical spacing if items wrap to next line
              crossAxisAlignment:
                  WrapCrossAlignment.center, // align items vertically
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    minimumSize: const Size(45, 28),
                    backgroundColor: widget.color.withValues(alpha: 0.17),
                    side: BorderSide(color: widget.color),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // important for proper sizing
                    children: [
                      Icon(widget.treadingIcon, size: 18, color: widget.color),
                      const SizedBox(width: 2),
                      Text(
                        widget.trendingAmount,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.durationText,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<
    ({
      String title,
      String value,
      String trendingAmount,
      String icon,
      Color color,
      String durationText,
      IconData trendingIcon,
    })> get overViewItems => [
      (
        title: l.S.current.totalProperty,
        value: "5",
        icon: AcnooSVGIcons.propertyIcon,
        color: Color(0xff009F5E),
        trendingAmount: "1",
        durationText: l.S.current.fromLastMonth,
        trendingIcon: Icons.trending_up,
      ),
      (
        title: l.S.current.totalTenant,
        value: "20",
        icon: AcnooSVGIcons.userIcon,
        color: Color(0xffF89100),
        trendingAmount: "5",
        durationText: l.S.current.fromLastMonth,
        trendingIcon: Icons.trending_down,
      ),
      (
        title: l.S.current.totalWithdraw,
        value: "\$900",
        icon: AcnooSVGIcons.withdrawalIcon,
        color: Color(0xff009F5E),
        trendingAmount: "\$300",
        durationText: l.S.current.fromLastMonth,
        trendingIcon: Icons.trending_up
      ),
    ];
