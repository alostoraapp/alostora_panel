import 'package:flutter/material.dart';
import '../../../../../../generated/l10n.dart' as l;

class MedicineLowStock extends StatefulWidget {
  const MedicineLowStock({super.key});

  @override
  State<MedicineLowStock> createState() => _MedicineLowStockState();
}

class _MedicineLowStockState extends State<MedicineLowStock> {
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
                    columns: [
                      DataColumn(
                        label: Text(_lang.SL),
                      ),
                      DataColumn(label: Text(_lang.name)),
                      DataColumn(
                          headingRowAlignment: MainAxisAlignment.end,
                          label: Text(
                            _lang.alertQty,
                            textAlign: TextAlign.end,
                          ))
                    ],
                    rows: List.generate(
                      7,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            Text('${index + 1}'),
                          ),
                          DataCell(
                            Text('Napa 500 mg'),
                          ),
                          DataCell(
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                '10 Pcs',
                                textAlign: TextAlign.end,
                                style: _theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
