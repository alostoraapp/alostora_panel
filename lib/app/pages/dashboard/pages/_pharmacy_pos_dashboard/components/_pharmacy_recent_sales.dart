import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/theme/_app_colors.dart';

class PharmacyRecentSalesTable extends StatefulWidget {
  const PharmacyRecentSalesTable({super.key});

  @override
  State<PharmacyRecentSalesTable> createState() => _PharmacyRecentSalesTableState();
}

class _PharmacyRecentSalesTableState extends State<PharmacyRecentSalesTable> {
  late final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);
    final _isDark = _theme.brightness == Brightness.dark;

    const _columnWidths = <int, double>{
      0: 60 / 1.5,
      1: 165 / 1.5,
      2: 165 / 1.5,
      3: 275 / 1.5,
      4: 205 / 1.5,
      5: 180 / 1.5,
      6: 180 / 1.5,
      7: 190 / 1,
      8: 150 / 1.5,
    };

    final _cellStyle = _theme.textTheme.bodyMedium;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Theme(
                data: _theme.copyWith(
                  dividerTheme: _theme.dividerTheme.copyWith(
                    color: _theme.colorScheme.outline,
                  ),
                ),
                child: DataTable(
                  headingTextStyle: _theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  headingRowColor: WidgetStateProperty.all<Color?>(
                    _isDark ? Color(0xff334155) : Color(0xffF7FAFA),
                  ),
                  dividerThickness: 0,
                  border: const TableBorder(
                    horizontalInside: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  columns: [
                    "${_lang.SL}.",
                    _lang.invoice,
                    _lang.customer,
                    _lang.phoneNumber,
                    _lang.total,
                    _lang.paid,
                    _lang.due,
                    _lang.date,
                    _lang.paymentType,
                    _lang.status,
                  ].asMap().entries.map((column) {
                    final _width = _columnWidths[column.key];
                    return DataColumn(
                      numeric: switch (column.key) {
                        5 || 6 || 7 => true,
                        _ => false,
                      },
                      label: Container(
                        width: _width,
                        alignment: Alignment.centerLeft,
                        child: Text(column.value),
                      ),
                    );
                  }).toList(),
                  rows: _data.asMap().entries.map((entry) {
                    final _row = entry.value;
                    final rowIndex = entry.key;

                    final _cells = <String>[
                      (entry.key + 1).toString(),
                      _row.$1,
                      _row.$2,
                      _row.$3,
                      NumberFormat.simpleCurrency().format(_row.$4),
                      NumberFormat.simpleCurrency().format(_row.$5),
                      NumberFormat.simpleCurrency().format(_row.$6),
                      _row.$7,
                      _row.$8,
                      _row.$9.getText(_lang),
                    ];

                    return DataRow(
                        color: rowIndex == 1
                            ? _isDark
                                ? WidgetStatePropertyAll(Color(0xff334155))
                                : WidgetStatePropertyAll(Color(0xffF7FAFA))
                            : null,
                        cells: List.generate(
                          _cells.length,
                          (index) {
                            final _isLastCol = _cells.length - 1 == index;
                            final _text = _cells[index];

                            return DataCell(
                              Container(
                                width: _columnWidths[index],
                                alignment: Alignment.centerLeft,
                                child: _isLastCol
                                    ? Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _row.$9.getBackgroundColor(),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          _text,
                                          style: _cellStyle?.copyWith(
                                            color: _row.$9.getColor(),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        _text,
                                        style: _cellStyle,
                                      ),
                              ),
                            );
                          },
                        ));
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<(String, String, String, double, double, double, String, String, PaymentStatus)> get _data => [
      (
        "IN255Vi",
        'Kristin Watson',
        "(629) 555-0129",
        500,
        500,
        0,
        "25 jan 2024 8:45PM",
        l.S.current.cash,
        PaymentStatus.paid,
      ),
      (
        "IN255Vi",
        'Kristin Watson',
        "(629) 555-0129",
        500,
        500,
        0,
        "25 jan 2024 8:45PM",
        l.S.current.bank,
        PaymentStatus.partial,
      ),
      (
        "IN255Vi",
        'Kristin Watson',
        "(629) 555-0129",
        500,
        500,
        0,
        "25 jan 2024 8:45PM",
        l.S.current.cash,
        PaymentStatus.paid,
      ),
      (
        "IN255Vi",
        'Kristin Watson',
        "(629) 555-0129",
        500,
        500,
        0,
        "25 jan 2024 8:45PM",
        l.S.current.cash,
        PaymentStatus.unpaid,
      ),
      (
        "IN255Vi",
        'Kristin Watson',
        "(629) 555-0129",
        500,
        500,
        0,
        "25 jan 2024 8:45PM",
        l.S.current.cash,
        PaymentStatus.paid,
      ),
    ];

enum PaymentStatus { paid, partial, unpaid }

extension PaymentStatusExt on PaymentStatus {
  String getText(l.S lang) {
    switch (this) {
      case PaymentStatus.paid:
        return lang.paid;
      case PaymentStatus.partial:
        return lang.partial;
      case PaymentStatus.unpaid:
        return lang.unpaid;
    }
  }

  Color getColor() => switch (this) {
        PaymentStatus.paid => AcnooAppColors.kSuccess,
        PaymentStatus.partial => AcnooAppColors.kPartialColor,
        PaymentStatus.unpaid => AcnooAppColors.kError,
      };

  Color getBackgroundColor() => getColor().withValues(alpha: 0.2);
}
