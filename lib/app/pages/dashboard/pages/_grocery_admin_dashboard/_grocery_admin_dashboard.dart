// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:intl/intl.dart' as intl;
import 'package:responsive_grid/responsive_grid.dart';

// 🌎 Project imports:
import '../../../../../generated/l10n.dart' as l;
import '../../../../core/core.dart';
import '../../../../widgets/widgets.dart';
import 'components/_components.dart' as comp;

class GroceryAdminDashboard extends StatelessWidget {
  const GroceryAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _lang = l.S.of(context);
    final _mqSize = MediaQuery.sizeOf(context);
    final _padding = responsiveValue<double>(context, xs: 16, lg: 24);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.all(_padding / 2.5),
        child: ResponsiveGridRow(
          children: [
            // Overview Containers
            ...List.generate(
              _overviewCardData.length,
              (index) {
                final _data = _overviewCardData[index];
                return ResponsiveGridCol(
                  lg: 3,
                  md: 6,
                  child: Padding(
                    padding: EdgeInsetsDirectional.all(_padding / 2.5),
                    child: comp.OverviewCardWidget(
                      value: _data.value,
                      label: _data.label,
                      fluctuationAmount: _data.fluctuationAmount,
                      fluctuationFrequency: _data.fluctuationFrequency,
                      icon: _data.svgIcon,
                      showCompactValue: true,
                      cardDecoration: index == 0
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: RadialGradient(
                                center: AlignmentDirectional.centerEnd,
                                focal: AlignmentDirectional(0.9, 0.0),
                                focalRadius: 0.05,
                                radius: 1,
                                colors: [
                                  const Color(0xffFF8617)
                                      .withValues(alpha: 0.15),
                                  _theme.colorScheme.primaryContainer,
                                ],
                              ),
                            )
                          : null,
                    ).hover(elevation: 3),
                  ),
                );
              },
            ),

            // Statistics Chart
            ResponsiveGridCol(
              lg: _mqSize.width < 1600 ? 12 : 8,
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 440),
                child: ShadowContainer(
                  margin: EdgeInsetsDirectional.all(_padding / 2.5),
                  contentPadding: const EdgeInsetsDirectional.fromSTEB(
                    16,
                    28,
                    16,
                    20,
                  ),
                  richHeaderText: TextSpan(
                    // text: 'Statistic ',
                    text: '${_lang.statistic} ',
                    children: [
                      TextSpan(
                        // text: '(Sales & Purchase)',
                        text: _lang.saleNPurchase,
                        style: TextStyle(
                          color: _theme.checkboxTheme.side?.color,
                        ),
                      )
                    ],
                    style: _theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const comp.StatisticsLineChart(),
                ),
              ),
            ),

            // Earning Overview Chart
            ResponsiveGridCol(
              lg: _mqSize.width < 1600 ? 12 : 4,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: 440,
                ),
                child: ShadowContainer(
                  margin: EdgeInsetsDirectional.all(_padding / 2.5),
                  contentPadding: EdgeInsetsDirectional.all(_padding),
                  // headerText: "Earning Overview",
                  headerText: _lang.earningOverview,
                  child: comp.EarningOverviewChart(),
                ),
              ),
            ),

            // Top 5 Customers
            ResponsiveGridCol(
              lg: 4,
              md: 6,
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 390),
                child: ShadowContainer(
                  margin: EdgeInsetsDirectional.all(_padding / 2.5),
                  contentPadding: EdgeInsetsDirectional.zero,
                  // headerText: 'Top 5 Customer',
                  headerText: _lang.top5Customer,
                  trailing: Text.rich(
                    TextSpan(
                      text: "${_lang.viewAll} ",
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: _theme.checkboxTheme.side?.color,
                            size: 16,
                          ),
                        )
                      ],
                      mouseCursor: SystemMouseCursors.click,
                    ),
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _theme.checkboxTheme.side?.color,
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _top5Customers.length,
                    itemBuilder: (context, index) {
                      final _item = _top5Customers[index];

                      return ListTile(
                        leading: AvatarWidget(
                          initialsOnly: index != 2,
                          avatarShape: AvatarShape.roundedRectangle,
                          fullName: _item.$1,
                          backgroundColor: index != 2
                              ? Color(0xffFF8C00)
                              : _theme.colorScheme.outline,
                          imagePath:
                              'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_07.png',
                          foregroundColor: Colors.white,
                        ),
                        title: Text(_item.$1),
                        titleTextStyle: _theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: Text(_item.$2),
                        subtitleTextStyle:
                            _theme.textTheme.bodyMedium?.copyWith(
                          color: _theme.checkboxTheme.side?.color,
                          fontWeight: FontWeight.w500,
                        ),
                        trailing: Text(
                          intl.NumberFormat.simpleCurrency(decimalDigits: 0)
                              .format(2000),
                          style: _theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Top 5 Products
            ResponsiveGridCol(
              lg: 4,
              md: 6,
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 390),
                child: ShadowContainer(
                  margin: EdgeInsetsDirectional.all(_padding / 2.5),
                  contentPadding: EdgeInsetsDirectional.zero,
                  // headerText: 'Top 5 Product',
                  headerText: _lang.top5Product,
                  trailing: Text.rich(
                    TextSpan(
                      text: "${_lang.viewAll} ",
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: _theme.checkboxTheme.side?.color,
                            size: 16,
                          ),
                        )
                      ],
                      mouseCursor: SystemMouseCursors.click,
                    ),
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _theme.checkboxTheme.side?.color,
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _top5Product.length,
                    itemBuilder: (context, index) {
                      final _item = _top5Product[index];

                      return comp.ProductListTile(
                        title: _item.$1,
                        subtitle: _item.$2,
                        amount: _item.$3,
                        imagePath: _item.$4,
                      );
                    },
                  ),
                ),
              ),
            ),

            // Stock Alert Table
            ResponsiveGridCol(
              lg: 4,
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 390),
                child: ShadowContainer(
                  margin: EdgeInsetsDirectional.all(_padding / 2.5),
                  contentPadding: EdgeInsetsDirectional.zero,
                  // headerText: 'Stock Alert',
                  headerText: _lang.stockAlert,
                  trailing: Text.rich(
                    TextSpan(
                      text: "${_lang.viewAll} ",
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: _theme.checkboxTheme.side?.color,
                            size: 16,
                          ),
                        )
                      ],
                      mouseCursor: SystemMouseCursors.click,
                    ),
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _theme.checkboxTheme.side?.color,
                    ),
                  ),
                  child: comp.StockAlertTable(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<
    ({
      String label,
      num value,
      SvgImageHolder svgIcon,
      num fluctuationAmount,
      String? fluctuationFrequency,
    })> get _overviewCardData {
  return [
    (
      // label: 'Total Sales',
      label: l.S.current.totalSales,
      value: 80700,
      svgIcon: AcnooSVGIcons.cartChecked,
      fluctuationAmount: 20000,
      // fluctuationFrequency: 'Today Sales',
      fluctuationFrequency: l.S.current.totalSales,
    ),
    (
      // label: 'Total Purchase',
      label: l.S.current.totalPurchase,
      value: 50500,
      svgIcon: AcnooSVGIcons.packageChecked,
      fluctuationAmount: 10000,
      // fluctuationFrequency: 'Today Purchase',
      fluctuationFrequency: l.S.current.todayPurchase,
    ),
    (
      // label: 'Total Income',
      label: l.S.current.totalIncome,
      value: 50500,
      svgIcon: AcnooSVGIcons.dollarSack,
      fluctuationAmount: 10000,
      // fluctuationFrequency: 'Today Income',
      fluctuationFrequency: l.S.current.todayIncome,
    ),
    (
      // label: 'Total Expense',
      label: l.S.current.totalExpense,
      value: 50500,
      svgIcon: AcnooSVGIcons.dollarOutSquare,
      fluctuationAmount: 10000,
      // fluctuationFrequency: 'Today Expense',
      fluctuationFrequency: l.S.current.todayExpense,
    ),
  ];
}

List<(String, String, int, String)> get _top5Customers => [
      (
        //"Jenny Wilson",
        l.S.current.jennyWilson,
        // "Retailer",
        l.S.current.retailer,
        250,
        "assets/images/static_images/avatars/person_images/person_image_09.jpeg",
      ),
      (
        //"Dianne Russell",
        l.S.current.dianneRussell,
        "Supplier",
        250,
        "assets/images/static_images/avatars/person_images/person_image_10.jpeg",
      ),
      (
        //"Wade Warren",
        l.S.current.wadeWarren,
        "Wholesaler ",
        250,
        "assets/images/static_images/avatars/person_images/person_image_11.jpeg",
      ),
      (
        //"Darrell Steward",
        l.S.current.darrellSteward,
        "Dealer  ",
        250,
        "assets/images/static_images/avatars/person_images/person_image_12.jpeg",
      ),
      (
        //"Bessie Cooper",
        l.S.current.bessieCooper,
        // "Retailer",
        l.S.current.retailer,
        250,
        "assets/images/static_images/avatars/person_images/person_image_13.jpeg",
      ),
    ];

List<(String, String, int, String)> get _top5Product => [
      (
        //"Rice",
        l.S.current.rice,
        //"Food",
        l.S.current.food,
        15,
        "assets/images/static_images/product_images/product_image_10.png",
      ),
      (
        // "Fresh Fruits",
        l.S.current.freshFruits,
        //"Fruits",
        l.S.current.fruits,

        20,
        "assets/images/static_images/product_images/product_image_11.png",
      ),
      (
        //"Beef Meat",
        l.S.current.beefMeat,
        //"Food ",
        l.S.current.food,

        15,
        "assets/images/static_images/product_images/product_image_12.png",
      ),
      (
        // "Apple",
        l.S.current.apple,
        l.S.current.fruits,
        //"Fruits ",
        30,
        "assets/images/static_images/product_images/product_image_13.png",
      ),
      (
        l.S.current.mango,
        l.S.current.fruits,
        // "Mango",
        //"Fruits",
        25,
        "assets/images/static_images/product_images/product_image_14.png",
      ),
    ];
