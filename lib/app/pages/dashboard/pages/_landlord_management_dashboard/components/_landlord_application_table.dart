import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart' as l;
import '../../../../../core/core.dart';

class LandlordApplicationTable extends StatefulWidget {
  const LandlordApplicationTable({super.key});

  @override
  State<LandlordApplicationTable> createState() =>
      _LandlordApplicationTableState();
}

class _LandlordApplicationTableState extends State<LandlordApplicationTable> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _lang = l.S.of(context);
    final tabs = {
      _lang.applicationRequest: 8,
      _lang.maintenanceRequest: 12,
    };

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (tabContext) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            DefaultTabController.of(tabContext).addListener(
              () => setState(() {}),
            );
          });
          return Container(
            constraints: BoxConstraints.tightFor(height: 360),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.primaryContainer,
            ),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: Divider.createBorderSide(
                        context,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          indicatorColor: theme.colorScheme.primary,
                          tabAlignment: TabAlignment.start,
                          dividerColor: theme.colorScheme.outline,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerHeight: 0,
                          labelStyle: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle:
                              theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onTertiary,
                          ),
                          isScrollable: true,
                          tabs: List.generate(
                            tabs.length,
                            (index) {
                              final tab = tabs.entries.elementAt(index);
                              return _buildTab(
                                context,
                                title: tab.key,
                                count: tab.value,
                                isSelected: index ==
                                    DefaultTabController.of(tabContext).index,
                              );
                            },
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(
                            vertical: -2,
                          ),
                        ),
                        label: Text(_lang.viewAll),
                        icon: Icon(Icons.arrow_forward),
                        iconAlignment: IconAlignment.end,
                      ),
                      const SizedBox.square(dimension: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: TabBarView(
                    children: List.generate(
                      2,
                      (index) {
                        return _buildDataTable(context, index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String title,
    required int count,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
          ),
          const SizedBox(width: 8),
          Container(
            height: 24,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : theme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '$count',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(BuildContext context, int tabIndex) {
    final theme = Theme.of(context);
    final cellStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onTertiary,
    );
    final _lang = l.S.of(context);

    late final scrollController = ScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Theme(
                data: theme.copyWith(
                  dividerTheme: theme.dividerTheme.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                child: DataTable(
                  headingTextStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  headingRowColor: WidgetStateProperty.all<Color?>(
                    theme.colorScheme.tertiaryContainer,
                  ),
                  dividerThickness: 0,
                  border: const TableBorder(
                    horizontalInside: BorderSide(color: Colors.transparent),
                  ),
                  columns: [
                    _lang.SL,
                    _lang.dateAndTime,
                    _lang.tenantName,
                    _lang.emailAddress,
                    _lang.tenantPhone,
                    _lang.propertyId,
                    _lang.propertyName,
                    _lang.status,
                  ].map((column) {
                    return DataColumn(label: Text(column));
                  }).toList(),
                  rows: List.generate(_orderList.length, (index) {
                    final details = _orderList[index];
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}', style: cellStyle)),
                      DataCell(Text(details.dateTime, style: cellStyle)),
                      DataCell(Text(details.tenantName, style: cellStyle)),
                      DataCell(Text(details.email, style: cellStyle)),
                      DataCell(Text(details.phone, style: cellStyle)),
                      DataCell(Text(details.propertyId, style: cellStyle)),
                      DataCell(Text(details.propartyName, style: cellStyle)),
                      DataCell(
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(4),
                            color: details.status.statusColor
                                ?.withValues(alpha: 0.1),
                            border: Border.all(
                              color: details.status.statusColor ??
                                  Colors.transparent,
                            ),
                          ),
                          child: Text(
                            details.status.getLocalizedDisplayName(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: details.status.statusColor,
                              fontWeight: FontWeight.w600,
                            ),
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

List<
    ({
      String dateTime,
      String tenantName,
      String email,
      String phone,
      String propertyId,
      String propartyName,
      LandlordManagementStatus status,
    })> get _orderList => [
      (
        dateTime: "25 Feb, 2025  01:26 PM",
        tenantName: "Jenny Wilson",
        email: "bockelboy@gmail.com",
        phone: "(+33)7 35 55 45 43",
        propertyId: "12256",
        propartyName: "Pine House",
        status: LandlordManagementStatus.pending
      ),
      (
        dateTime: "20 Feb, 2025  10:30 AM",
        tenantName: "Ralph Edwards",
        email: "csilvers@gmail.com",
        phone: "(+33)6 55 58 55 63",
        propertyId: "56321",
        propartyName: "Sunny Valley Casa",
        status: LandlordManagementStatus.approved,
      ),
      (
        dateTime: "18 Feb, 2025  11:22 AM",
        tenantName: "Savannah Nguyen",
        email: "ateniese@gmail.com",
        phone: "(+33)7 75 55 87 24",
        propertyId: "32654",
        propartyName: "Restful House",
        status: LandlordManagementStatus.rejected
      ),
      (
        dateTime: "17 Feb, 2025  09:26 AM",
        tenantName: "Annette Black",
        email: "frostman@gmail.com",
        phone: "(+33)7 35 55 31 15",
        propertyId: "96523",
        propartyName: "Mountain Fabric",
        status: LandlordManagementStatus.processing
      ),
      (
        dateTime: "16 Feb, 2025  10:26 AM",
        tenantName: "Courtney Henry",
        email: "doormat@gmail.com",
        phone: "(+33)6 55 59 16 45",
        propertyId: "45879",
        propartyName: "Bright Forest Camp",
        status: LandlordManagementStatus.pending
      ),
    ];

//-------------landlord enum status-------------
//Tracking order status
enum LandlordManagementStatus {
  pending(
    displayName: 'Pending',
    statusColor: AcnooAppColors.kWarning,
  ),
  approved(
    displayName: 'Approved',
    statusColor: AcnooAppColors.kSuccess,
  ),
  rejected(
    displayName: 'Rejected',
    statusColor: AcnooAppColors.kError,
  ),
  processing(
    displayName: 'Processing',
    statusColor: AcnooAppColors.kProcessingColor,
  );

  final String displayName;
  final Color? statusColor;
  const LandlordManagementStatus({
    required this.displayName,
    this.statusColor,
  });

  String getLocalizedDisplayName() {
    return switch (this) {
      LandlordManagementStatus.pending => l.S.current.pending,
      LandlordManagementStatus.approved => l.S.current.approved,
      LandlordManagementStatus.rejected => l.S.current.rejected,
      LandlordManagementStatus.processing => l.S.current.processing,
    };
  }
}
