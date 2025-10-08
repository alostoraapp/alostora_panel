import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sfc;
import 'package:intl/intl.dart' as intl;

import '../../../../../core/core.dart';
import '../../../../../widgets/widgets.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late final controller = sfc.CalendarController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addPropertyChangedListener((p0) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _mqSize = MediaQuery.sizeOf(context);

    return ShadowContainer(
      margin: EdgeInsetsDirectional.zero,
      contentPadding: EdgeInsetsDirectional.zero,
      customHeader: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: _theme.colorScheme.outline),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionButton(),
            if (_mqSize.width >= 400) _headerText(_theme),
            const FilterDropdownButton(),
          ],
        ),
      ),
      child: Theme(
        data: _theme.copyWith(
          primaryColor: AcnooAppColors.kSuccess,
          colorScheme: _theme.colorScheme.copyWith(
            primary: AcnooAppColors.kSuccess,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_mqSize.width < 400) ...[
              const SizedBox.square(dimension: 5),
              _headerText(_theme),
            ],
            const SizedBox.square(dimension: 5),
            sfc.SfCalendar(
              controller: controller,
              headerHeight: 0,
              view: sfc.CalendarView.month,
              allowedViews: const [sfc.CalendarView.month],
              cellBorderColor: Colors.transparent,
              todayHighlightColor: Colors.transparent,
              showCurrentTimeIndicator: true,
              todayTextStyle: _theme.textTheme.bodySmall?.copyWith(),
              initialSelectedDate: DateTime.now(),
              selectionDecoration: BoxDecoration(
                border: Border.all(color: AcnooAppColors.kSuccess),
                borderRadius: BorderRadius.circular(4),
                color: AcnooAppColors.kSuccess20Op,
              ),
              monthViewSettings: sfc.MonthViewSettings(
                dayFormat: 'EEE',
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _headerText(ThemeData _theme) {
    return Text(
      intl.DateFormat('MMMM yyyy').format(
        controller.displayDate ?? DateTime.now(),
      ),
      style: _theme.textTheme.bodyLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildActionButton() {
    return Builder(
      builder: (context) {
        final _theme = Theme.of(context);
        return Row(
          children: [
            IconButton.outlined(
              onPressed: controller.backward,
              style: IconButton.styleFrom(
                visualDensity: const VisualDensity(
                  horizontal: -1,
                  vertical: -1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.horizontal(
                    start: Radius.circular(4),
                  ),
                ),
                padding: EdgeInsets.zero,
              ),
              color: _theme.checkboxTheme.side?.color,
              icon: const Icon(Icons.chevron_left_outlined),
            ),
            IconButton.outlined(
              onPressed: controller.forward,
              style: IconButton.styleFrom(
                visualDensity: const VisualDensity(
                  horizontal: -1,
                  vertical: -1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.horizontal(
                    end: Radius.circular(4),
                  ),
                ),
                padding: EdgeInsets.zero,
              ),
              color: _theme.checkboxTheme.side?.color,
              icon: const Icon(Icons.chevron_right_outlined),
            )
          ],
        );
      },
    );
  }
}
