import 'package:flutter/material.dart';
import '../../../../../../generated/l10n.dart' as l;

class StockAlertTable extends StatefulWidget {
  const StockAlertTable({super.key});

  @override
  State<StockAlertTable> createState() => _StockAlertTableState();
}

class _StockAlertTableState extends State<StockAlertTable> {
  final _verticalController = ScrollController();
  final _horizontalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;
    final _lang = l.S.of(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scrollbar(
          controller: _horizontalController,
          thumbVisibility: true,
          interactive: true,
          thickness: 5,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            controller: _verticalController,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                ),
                child: Theme(
                  data: _theme.copyWith(
                    dividerTheme: _theme.dividerTheme.copyWith(
                      color: _theme.colorScheme.outline,
                    ),
                  ),
                  child: DataTable(
                    dividerThickness: 0,
                    headingRowColor: WidgetStateProperty.all<Color?>(
                      _isDark ? Color(0xff334155) : Color(0xffF7FAFA),
                    ),
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    headingTextStyle: _theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    columnSpacing: 0,
                    columns: [
                      DataColumn(
                        label: Text(_lang.SL),
                        columnWidth: FlexColumnWidth(1),
                      ),
                      DataColumn(
                        label: Text(_lang.name),
                        columnWidth: FlexColumnWidth(3),
                      ),
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.end,
                        columnWidth: FlexColumnWidth(2),
                        label: Text(
                          _lang.alertQty,
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                    rows: [
                      ...{
                        "Apple": "5 kg",
                        "Cabbage": "6 kg",
                        "Bananas": "4 kg",
                        "Rice": "7 kg",
                        "Beetroot": "4 kg",
                        "Beetle Juice": "4L",
                      }.entries.toList().asMap().entries.map((entry) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text('${entry.key + 1}'),
                            ),
                            DataCell(
                              Text(entry.value.key),
                            ),
                            DataCell(
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Text(
                                  entry.value.value,
                                  textAlign: TextAlign.end,
                                  style: _theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
