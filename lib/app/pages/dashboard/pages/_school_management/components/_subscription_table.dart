// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:intl/intl.dart' as intl;

// 🌎 Project imports:
import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/theme/theme.dart';

class SubscriptionTable extends StatefulWidget {
  const SubscriptionTable({super.key});

  @override
  State<SubscriptionTable> createState() => _SubscriptionTableState();
}

class _SubscriptionTableState extends State<SubscriptionTable> {
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

    const _columnWidths = <int, double>{
      0: 180,
      1: 100,
      2: 80,
      3: 60,
      4: 80,
      5: 60,
    };
    const _columnAlignments = <int, AlignmentGeometry>{
      0: AlignmentDirectional.centerStart,
      1: AlignmentDirectional.centerStart,
      2: AlignmentDirectional.centerStart,
      3: AlignmentDirectional.centerStart,
      4: AlignmentDirectional.centerStart,
      5: AlignmentDirectional.center,
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
                    _theme.colorScheme.tertiaryContainer,
                  ),
                  dividerThickness: 0,
                  border: const TableBorder(
                    horizontalInside: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  columns: [
                    _lang.schoolName,
                    // "Phone",
                    _lang.phone,
                    _lang.package,
                    // "Price",
                    _lang.price,
                    _lang.expireDate,
                    // "Status",
                    _lang.status,
                  ].asMap().entries.map((column) {
                    final _width = _columnWidths[column.key];
                    final _alignment = _columnAlignments[column.key];
                    return DataColumn(
                      label: Container(
                        width: _width,
                        alignment: _alignment,
                        child: Text(column.value),
                      ),
                    );
                  }).toList(),
                  rows: [
                    ..._data.map((row) {
                      return DataRow(
                        cells: [
                          DataCell(Text(row.schoolName, style: _cellStyle)),
                          DataCell(Text(row.phone, style: _cellStyle)),
                          DataCell(
                            Text(
                              row.package.label,
                              style: _cellStyle?.copyWith(
                                color: row.package.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              intl.NumberFormat.simpleCurrency().format(
                                row.price,
                              ),
                            ),
                          ),
                          DataCell(Text(row.expireDate, style: _cellStyle)),
                          DataCell(
                            Container(
                              decoration: BoxDecoration(
                                color: AcnooAppColors.kSuccess20Op,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              child: Text(
                                row.status,
                                style: _cellStyle?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AcnooAppColors.kSuccess,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<({String schoolName, String phone, Package package, num price, String expireDate, String status})> get _data {
  return [
    (
      schoolName: "RAJUK Uttara Model College",
      phone: '015 555 86515',
      package: Package.premium,
      price: 100,
      expireDate: intl.DateFormat('dd MMM yyyy').format(DateTime.now()),
      status: l.S.current.active,
    ),
    (
      schoolName: "ABC School & Collage",
      phone: '011 555 49522',
      package: Package.silver,
      price: 150,
      expireDate: intl.DateFormat('dd MMM yyyy').format(DateTime.now()),
      status: l.S.current.active,
    ),
    (
      schoolName: "Stride International School",
      phone: '018 555 22586',
      package: Package.gold,
      price: 200,
      expireDate: intl.DateFormat('dd MMM yyyy').format(DateTime.now()),
      status: l.S.current.active,
    ),
    (
      schoolName: "E & H School",
      phone: '011 555 71370',
      package: Package.silver,
      price: 150,
      expireDate: intl.DateFormat('dd MMM yyyy').format(DateTime.now()),
      status: l.S.current.active,
    ),
    (
      schoolName: "Sydney International School",
      phone: '011 555 79244',
      package: Package.gold,
      price: 200,
      expireDate: intl.DateFormat('dd MMM yyyy').format(DateTime.now()),
      status: l.S.current.active,
    ),
    (
      schoolName: "RAJUK Uttara Model College",
      phone: '015 555 86515',
      package: Package.premium,
      price: 100,
      expireDate: intl.DateFormat('dd MMM yyyy').format(DateTime.now()),
      status: l.S.current.active,
    ),
  ];
}

enum Package {
  premium(color: AcnooAppColors.kSuccess),
  silver(color: AcnooAppColors.kInfo),
  gold(color: AcnooAppColors.kWarning);

  final Color color;
  const Package({required this.color});

  String get label {
    return switch (this) {
      Package.premium => l.S.current.premium,
      Package.silver => l.S.current.silver,
      Package.gold => l.S.current.gold,
    };
  }
}
