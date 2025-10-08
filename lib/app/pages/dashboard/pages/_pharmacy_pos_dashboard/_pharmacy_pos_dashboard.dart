import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'components/components.dart' as comp;

import '../../../../../generated/l10n.dart' as l;
import '../../../../widgets/shadow_container/_shadow_container.dart';
import '../../../../core/core.dart';

class PharmacyPosDashboard extends StatefulWidget {
  const PharmacyPosDashboard({super.key});

  @override
  State<PharmacyPosDashboard> createState() => _PharmacyPosDashboardState();
}

class _PharmacyPosDashboardState extends State<PharmacyPosDashboard> {
  @override
  Widget build(BuildContext context) {
    final _lang = l.S.of(context);
    final _theme = Theme.of(context);
    final _mqSize = MediaQuery.sizeOf(context);
    final _isDark = _theme.brightness == Brightness.dark;

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
            ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  lg: _mqSize.width >= 1600 ? 8 : 12,
                  md: 12,
                  child: Column(
                    children: [
                      // POS Overview
                      ResponsiveGridRow(
                        children: List.generate(
                          _overView.length,
                          (index) {
                            final _data = _overView[index];
                            return ResponsiveGridCol(
                              lg: 3,
                              md: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: comp.PharmacyPosOverview(
                                  days: _data.totalDaysAmount,
                                  title: _data.title,
                                  value: _data.amount,
                                  subAmount: _data.subAmount,
                                  icon: _data.icon,
                                  isFirstIndex: _data.firstIndex,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Show Today + Low Stock only on md/sm (screen < 1600)
                      if (_mqSize.width < 1600) ...[
                        ResponsiveGridRow(
                          children: [
                            //Today's Report
                            ResponsiveGridCol(
                              lg: 6,
                              md: _mqSize.width < 720 ? 12 : 6,
                              xs: 12,
                              child: todaysReport(context),
                            ),

                            //Low Stock
                            ResponsiveGridCol(
                              lg: 6,
                              md: _mqSize.width < 720 ? 12 : 6,
                              xs: 12,
                              child: ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                  height: 485,
                                ),
                                child: lowStockList(context),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Profit / Loss Chart
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(height: 419),
                        child: ShadowContainer(
                          margin: EdgeInsetsDirectional.all(_padding / 2.5),
                          customHeader: comp.StraightLineTextView(
                            headerText: _lang.lossProfitOverview,
                            dataTitle: _lang.profit,
                            dataValue: '\$1.5K',
                            data2Title: _lang.loss,
                            data2Value: '\$300',
                          ),
                          child: comp.PharmacyLossProfitChart(),
                        ),
                      ),

                      // Purchase & Sales Statics
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(height: 422),
                        child: ShadowContainer(
                          margin: EdgeInsetsDirectional.all(_padding / 2.5),
                          contentPadding: EdgeInsetsDirectional.zero,
                          customHeader: comp.StraightLineTextView(
                            headerText: _lang.purchaseAndSaleStatics,
                            dataTitle: _lang.purchase,
                            dataValue: '\$800',
                            data2Title: _lang.sales,
                            data2Value: '\$1.5k',
                          ),
                          child: const comp.SalePurchaseChart(),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_mqSize.width >= 1600)
                  ResponsiveGridCol(
                    lg: 4,
                    child: Column(
                      children: [
                        //Today’s Report
                        todaysReport(context),

                        //Low Stock
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(height: 485),
                          child: lowStockList(context),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            ResponsiveGridRow(
              children: [
                //Recent Sales
                ResponsiveGridCol(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: 390,
                    ),
                    child: ShadowContainer(
                      margin: EdgeInsetsDirectional.all(
                        _padding / 2.5,
                      ),
                      contentPadding: EdgeInsetsDirectional.zero,
                      headerText: _lang.recentSales,
                      headerDecoration: BoxDecoration(border: Border()),
                      trailing: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          visualDensity: const VisualDensity(
                            horizontal: -1,
                            vertical: -0.5,
                          ),
                          backgroundColor: _isDark
                              ? AcnooAppColors.kDark1
                              : AcnooAppColors.kPrimary50,
                          foregroundColor: _isDark
                              ? AcnooAppColors.kNeutral400
                              : AcnooAppColors.kNeutral500,
                        ),
                        onPressed: () {},
                        child: Text(
                          '${l.S.current.viewAll} >',
                          style: _theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: comp.PharmacyRecentSalesTable(),
                      ),
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

  Widget todaysReport(BuildContext context) {
    final _padding = responsiveValue<double>(
      context,
      xs: 16,
      lg: 24,
    );
    return ShadowContainer(
      margin: EdgeInsetsDirectional.all(_padding / 2.5),
      contentPadding: EdgeInsetsDirectional.zero,
      headerText: l.S.current.todayReport,
      headerDecoration: BoxDecoration(border: Border()),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: 416),
        child: comp.TodayPieChart(),
      ),
    );
  }

  Widget lowStockList(BuildContext context) {
    final _padding = responsiveValue<double>(
      context,
      xs: 16,
      lg: 24,
    );
    final _theme = Theme.of(context);
    final _isDark = _theme.brightness == Brightness.dark;

    return ShadowContainer(
      margin: EdgeInsetsDirectional.all(_padding / 2.5),
      contentPadding: EdgeInsets.zero,
      headerText: l.S.current.lowStock,
      trailing: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          visualDensity: const VisualDensity(
            horizontal: -1,
            vertical: -0.5,
          ),
          backgroundColor:
              _isDark ? AcnooAppColors.kDark1 : AcnooAppColors.kPrimary50,
          foregroundColor:
              _isDark ? AcnooAppColors.kNeutral400 : AcnooAppColors.kNeutral500,
        ),
        onPressed: () {},
        child: Text(
          '${l.S.current.viewAll} >',
          style: _theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: comp.MedicineLowStock(),
    );
  }
}

List<
    ({
      String title,
      String amount,
      String subAmount,
      SvgImageHolder icon,
      String totalDaysAmount,
      bool firstIndex
    })> get _overView {
  return [
    (
      title: l.S.current.totalCustomer,
      amount: "1.5k",
      subAmount: "10%",
      icon: AcnooSVGIcons.gropuImage,
      totalDaysAmount: '+250 ${l.S.current.days}',
      firstIndex: true,
    ),
    (
      title: l.S.current.totalSupplier,
      amount: "70",
      subAmount: "10%",
      icon: AcnooSVGIcons.supplier,
      totalDaysAmount: '+8 ${l.S.current.today}',
      firstIndex: false,
    ),
    (
      title: l.S.current.stockMedicine,
      amount: "620",
      subAmount: "10%",
      icon: AcnooSVGIcons.stock,
      totalDaysAmount: '+180 ${l.S.current.today}',
      firstIndex: false,
    ),
    (
      title: l.S.current.expiredMedicine,
      amount: "30",
      subAmount: "10%",
      icon: AcnooSVGIcons.expired,
      totalDaysAmount: '+15 ${l.S.current.today}',
      firstIndex: false,
    ),
  ];
}
