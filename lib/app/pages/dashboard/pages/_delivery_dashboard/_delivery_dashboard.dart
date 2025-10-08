import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../../generated/l10n.dart' as l;
import '../../../../core/static/static.dart';
import '../../../../widgets/widgets.dart';
import 'components/components.dart' as comp;

class DeliveryDashboard extends StatefulWidget {
  const DeliveryDashboard({super.key});

  @override
  State<DeliveryDashboard> createState() => _DeliveryDashboardState();
}

class _DeliveryDashboardState extends State<DeliveryDashboard> {
  @override
  Widget build(BuildContext context) {
    final _lang = l.S.of(context);
    final _theme = Theme.of(context);
    final _mqSize = MediaQuery.sizeOf(context);

    final _padding = responsiveValue<double>(
      context,
      xs: 16,
      lg: 24,
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(_padding / 2.5),
        child: Column(
          children: [
            // Other Contents
            ResponsiveGridRow(
              children: [
                // Left Side Contents
                ResponsiveGridCol(
                  lg: _mqSize.width < 1600 ? 7 : 8,
                  child: ResponsiveGridRow(
                    children: [
                      // Order Status
                      ResponsiveGridCol(
                        child: ResponsiveGridRow(
                          children: List.generate(
                            _orderProcess.length,
                            (index) {
                              final _data = _orderProcess[index];

                              return ResponsiveGridCol(
                                lg: _mqSize.width < 1600
                                    ? 6
                                    : (_mqSize.width < 1900 ? 6 : 3),
                                md: _mqSize.width < 800
                                    ? 6
                                    : (_mqSize.width < 1080 ? 6 : 3),
                                xs: _mqSize.width < 531 ? 12 : 6,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.all(
                                    _padding / 2.5,
                                  ),
                                  child: comp.DeliveryOrderWidget(
                                    title: _data.title,
                                    imagePath: _data.image,
                                    subTitle: _data.subTilte,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Deliveries by Category
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            height: 419,
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(_padding / 2.5),
                            // contentPadding:
                            //     EdgeInsetsDirectional.all(_padding / 2.5),
                            // headerText: 'Top Customers',
                            headerText: _lang.deliveryByCategory,
                            trailing: FilterDropdownButton(),
                            child: comp.DeliveryCategoryChart(),
                          ),
                        ),
                      ),

                      // Tracking Order
                      ResponsiveGridCol(
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            height: 404,
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(_padding / 2.5),
                            contentPadding: EdgeInsetsDirectional.zero,
                            // headerText: 'Earning Reports',
                            headerText: _lang.trackingOrder,
                            trailing: Text.rich(
                              TextSpan(
                                text: _lang.viewAll,
                                mouseCursor: SystemMouseCursors.click,
                              ),
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: _theme.colorScheme.onTertiary,
                              ),
                            ),
                            // child: const comp.EarningReportChart(),
                            child: comp.TrackingOrderTable(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Side Contents
                ResponsiveGridCol(
                  lg: _mqSize.width < 1600 ? 5 : 4,
                  child: ResponsiveGridRow(
                    children: [
                      // Earning Summary
                      ResponsiveGridCol(
                        lg: 12,
                        md: _mqSize.width < 768 ? 12 : 6,
                        child: ShadowContainer(
                          margin: EdgeInsetsDirectional.all(
                            _padding / 2.5,
                          ),
                          contentPadding: EdgeInsetsDirectional.zero,
                          headerText: _lang.earningSummary,
                          trailing: const FilterDropdownButton(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(height: 336),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _summaryItems.length,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemBuilder: (context, index) {
                                final _item = _summaryItems[index];
                                return comp.EarningSummaryWidget(
                                  title: _item.title,
                                  amount: _item.amount,
                                  imagePath: _item.image,
                                  percentage: _item.persentence,
                                );
                              },
                              separatorBuilder: (_, __) {
                                return Divider(
                                  height: 2,
                                  color: _theme.colorScheme.outline,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      // Delivery Tracking
                      ResponsiveGridCol(
                        lg: 12,
                        md: _mqSize.width < 768 ? 12 : 6,
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            height: _mqSize.width < 1240
                                ? 428
                                : _mqSize.width < 1900
                                    ? 614
                                    : 500,
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(_padding / 2.5),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: _padding,
                            ),
                            headerText: _lang.deliveryTracking,
                            trailing: Text.rich(
                              TextSpan(
                                text: _lang.viewAll,
                                mouseCursor: SystemMouseCursors.click,
                              ),
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: _theme.colorScheme.onTertiary,
                              ),
                            ),
                            child: DefaultTabController(
                              length: 4,
                              initialIndex: 0,
                              child: Column(
                                children: [
                                  TabBar(
                                    indicatorColor: _theme.colorScheme.primary,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    dividerColor: _theme.colorScheme.outline,
                                    unselectedLabelColor:
                                        _theme.colorScheme.onTertiary,
                                    tabs: [
                                      Tab(text: _lang.pending),
                                      Tab(text: _lang.preparing),
                                      Tab(text: _lang.shipping),
                                      Tab(text: _lang.cancelled),
                                    ],
                                  ),
                                  Flexible(
                                    child: TabBarView(
                                      children: List.generate(4, (index) {
                                        return ListView.separated(
                                          itemCount:
                                              _deliverTrackingItem.length,
                                          itemBuilder: (context, index) {
                                            final _item =
                                                _deliverTrackingItem[index];
                                            return comp.DeliveryTracking(
                                              senderName: _item.senderName,
                                              senderAddress:
                                                  _item.senderAddress,
                                              receiverName: _item.receiverName,
                                              receiverAddress:
                                                  _item.receiverAdress,
                                            );
                                          },
                                          separatorBuilder: (c, i) =>
                                              comp.DottedLineBorder(),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ResponsiveGridRow(
              children: [
                //Area Statistics
                ResponsiveGridCol(
                  lg: _mqSize.width < 1700 ? 5 : 4,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: 358,
                    ),
                    child: ShadowContainer(
                      margin: EdgeInsetsDirectional.all(
                        _padding / 2.5,
                      ),
                      contentPadding: EdgeInsetsDirectional.symmetric(
                        horizontal: _padding,
                      ),
                      headerText: _lang.areaStatistics,
                      trailing: FilterDropdownButton(),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: const comp.AreaStatisticsPiChart(),
                      ),
                    ),
                  ),
                ),

                //Top delivery man
                ResponsiveGridCol(
                  lg: _mqSize.width < 1700 ? 7 : 8,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: 358,
                    ),
                    child: ShadowContainer(
                      margin: EdgeInsetsDirectional.all(_padding / 2.5),
                      contentPadding: EdgeInsetsDirectional.all(_padding / 2.5),
                      // headerText: 'Top Delivery Man',
                      headerText: _lang.topDeliveryMan,
                      trailing: FilterDropdownButton(),
                      child: comp.TopDeliveryManComponents(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//order process list
List<({SvgImageHolder image, String title, String subTilte})>
    get _orderProcess => [
          (
            title: '857',
            subTilte: l.S.current.confirmedOrder,
            image: AcnooSVGIcons.orderConfirmIcon,
          ),
          (
            title: '857',
            subTilte: l.S.current.pendingOrder,
            image: AcnooSVGIcons.orderPendingIcon,
          ),
          (
            title: '857',
            subTilte: l.S.current.deliveredOrder,
            image: AcnooSVGIcons.orderDeliveredIcon,
          ),
          (
            title: '857',
            subTilte: l.S.current.cancelledOrder,
            image: AcnooSVGIcons.orderCancelledIcon,
          ),
        ];

//Earning Summary item
List<({SvgImageHolder image, String title, String amount, double persentence})>
    get _summaryItems => [
          (
            title: l.S.current.totalItemsSold,
            amount: '172',
            image: AcnooSVGIcons.deliverySoldIcon,
            persentence: 30.5,
          ),
          (
            title: l.S.current.totalIncome,
            amount: '\$5000.00',
            image: AcnooSVGIcons.deliveryIncomeIcon,
            persentence: 24.6,
          ),
          (
            title: l.S.current.totalCost,
            amount: '\$1000.00',
            image: AcnooSVGIcons.deliveryCostIcon,
            persentence: 17.6,
          ),
          (
            title: l.S.current.totalRevenue,
            amount: '\$4000.00',
            image: AcnooSVGIcons.deliveryRevenuesIcon,
            persentence: 27.6,
          ),
          (
            title: l.S.current.totalItemsSold,
            amount: '172',
            image: AcnooSVGIcons.deliverySoldIcon,
            persentence: 30.5,
          ),
          (
            title: l.S.current.totalIncome,
            amount: '\$5000.00',
            image: AcnooSVGIcons.deliveryIncomeIcon,
            persentence: 24.6,
          ),
          (
            title: l.S.current.totalCost,
            amount: '\$1000.00',
            image: AcnooSVGIcons.deliveryCostIcon,
            persentence: 17.6,
          ),
          (
            title: l.S.current.totalRevenue,
            amount: '\$4000.00',
            image: AcnooSVGIcons.deliveryRevenuesIcon,
            persentence: 27.6,
          ),
        ];

//Delivery Tracking item
List<
    ({
      String senderName,
      String senderAddress,
      String receiverName,
      String receiverAdress
    })> get _deliverTrackingItem => [
      (
        senderName: 'Ralph Edwards',
        senderAddress: '4140 Parker Rd. Allentown, New Mexico 31134',
        receiverName: 'Guy Hawkins',
        receiverAdress: '4517 Washington Ave. Manchester, Kentucky 39495',
      ),
      (
        senderName: 'Albert Flores',
        senderAddress: '3891 Ranchview Dr. Richardson, California 62639',
        receiverName: 'Floyd Miles',
        receiverAdress: '4140 Parker Rd. Allentown, New Mexico 31134',
      ),
      (
        senderName: 'Bessie Cooper',
        senderAddress: '4140 Parker Rd. Allentown, New Mexico 31134',
        receiverName: 'Theresa Webb',
        receiverAdress: '10, kazi nazrul islam avenue, (2nd floor) kawran',
      ),
      (
        senderName: 'Bessie Cooper',
        senderAddress: '4140 Parker Rd. Allentown, New Mexico 31134',
        receiverName: 'Theresa Webb',
        receiverAdress: '10, kazi nazrul islam avenue, (2nd floor) kawran',
      ),
    ];
