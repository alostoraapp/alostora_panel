// 🐦 Flutter imports:
import 'package:flutter/material.dart';
// 🌎 Project imports:
import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/theme/_app_colors.dart';

class TrackingOrderTable extends StatefulWidget {
  const TrackingOrderTable({super.key});

  @override
  State<TrackingOrderTable> createState() => _TrackingOrderTableState();
}

class _TrackingOrderTableState extends State<TrackingOrderTable> {
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
    final _cellStyle = _theme.textTheme.bodyMedium?.copyWith(
      color: _theme.colorScheme.onTertiary,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(
              bottom: 16,
            ),
            controller: scrollController,
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
                    _lang.sl,
                    _lang.orderId,
                    _lang.vehiclesType,
                    _lang.weight,
                    _lang.date,
                    _lang.route,
                    _lang.amount,
                    _lang.status,
                  ].asMap().entries.map((column) {
                    // final _width = _columnWidths[column.key];
                    return DataColumn(
                      label: Text(column.value),
                    );
                  }).toList(),
                  rows: List.generate(_orderList.length, (index) {
                    final _details = _orderList[index];
                    return DataRow(cells: [
                      DataCell(
                        Text(
                          "${index + 1}",
                          style: _cellStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          _details.orderId,
                          style: _cellStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          _details.vehiclesType,
                          style: _cellStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          _details.weight,
                          style: _cellStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          _details.date,
                          style: _cellStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          _details.route,
                          style: _cellStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          _details.amount.toString(),
                          style: _cellStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          _details.status.getLocalizedDisplayName(),
                          style: _theme.textTheme.bodyMedium?.copyWith(
                            color: _details.status.statusColor,
                          ),
                        ),
                      ),
                    ]);
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

//Tracking order status
enum TrackingOrderStatus {
  pending(
    displayName: 'Pending',
    statusColor: AcnooAppColors.kWarning,
  ),
  completed(
    displayName: 'Completed',
    statusColor: AcnooAppColors.kSuccess,
  ),
  canceled(
    displayName: 'Canceled',
    statusColor: AcnooAppColors.kError,
  );

  final String displayName;
  final Color? statusColor;
  const TrackingOrderStatus({
    required this.displayName,
    this.statusColor,
  });

  String getLocalizedDisplayName() {
    return switch (this) {
      TrackingOrderStatus.pending => l.S.current.pending,
      TrackingOrderStatus.completed => l.S.current.completed,
      TrackingOrderStatus.canceled => l.S.current.cancel,
    };
  }
}

List<
    ({
      String orderId,
      String vehiclesType,
      String weight,
      String date,
      String route,
      double amount,
      TrackingOrderStatus status,
    })> get _orderList => [
      (
        orderId: "#236511",
        vehiclesType: "Bike",
        weight: "5 kg",
        date: "25 Nov 2023",
        route: "87 walden Road > 39 Grenoble Road",
        amount: 70.00,
        status: TrackingOrderStatus.pending,
      ),
      (
        orderId: "#236512",
        vehiclesType: "Car",
        weight: "800 gr",
        date: "28 Nov 2023",
        route: "87 walden Road > 39 Grenoble Road",
        amount: 70.00,
        status: TrackingOrderStatus.completed,
      ),
      (
        orderId: "#236513",
        vehiclesType: "Bike",
        weight: "7 kg",
        date: "28 Nov 2023",
        route: "87 walden Road > 39 Grenoble Road",
        amount: 70.00,
        status: TrackingOrderStatus.canceled,
      ),
      (
        orderId: "#236514",
        vehiclesType: "Car",
        weight: "25 kg",
        date: "28 Nov 2023",
        route: "87 walden Road > 39 Grenoble Road",
        amount: 70.00,
        status: TrackingOrderStatus.completed,
      ),
      (
        orderId: "#236515",
        vehiclesType: "Car",
        weight: "8 kg",
        date: "28 Nov 2023",
        route: "87 walden Road > 39 Grenoble Road",
        amount: 70.00,
        status: TrackingOrderStatus.completed,
      ),
    ];
