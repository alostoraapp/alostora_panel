import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../../generated/l10n.dart' as l;
import '../../../../widgets/dropdown_button/_dropdown_button.dart';
import '../../../../widgets/shadow_container/_shadow_container.dart';
import 'components/_components.dart' as comp;

class LandlordManagementDashboard extends StatefulWidget {
  const LandlordManagementDashboard({super.key});

  @override
  State<LandlordManagementDashboard> createState() =>
      _LandlordManagementDashboardState();
}

class _LandlordManagementDashboardState
    extends State<LandlordManagementDashboard> {
  @override
  Widget build(BuildContext context) {
    final _lang = l.S.of(context);
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
            ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  lg: 9,
                  md: 12,
                  xs: 12,
                  child: ShadowContainer(
                    showHeader: false,
                    margin: EdgeInsets.all(_padding / 2.5),
                    child: ResponsiveGridRow(
                      children: [
                        //----------Landlord Management OverView------------
                        ResponsiveGridCol(
                          lg: 4,
                          md: _mqSize.width < 780 ? 12 : 4,
                          xs: 12,
                          child: comp.LandlordOverView(),
                        ),
                        //-----------Earning statics-----------------------
                        ResponsiveGridCol(
                          lg: 8,
                          md: _mqSize.width < 780 ? 12 : 8,
                          xs: 12,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: _mqSize.width < 780 ? 20 : 0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(height: 450),
                              child: comp.EarningStaticsChart(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //-------------Property Overview-------------------
                ResponsiveGridCol(
                  lg: 3,
                  md: 12,
                  xs: 12,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(height: 510),
                    child: ShadowContainer(
                      margin: EdgeInsetsDirectional.all(_padding / 2.5),
                      contentPadding: EdgeInsetsDirectional.zero,
                      headerText: _lang.propertyOverView,
                      trailing: FilterDropdownButton(),
                      child: comp.PropertyOverViewChart(),
                    ),
                  ),
                ),
              ],
            ),
            //------------Landlord management application table----------------
            ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  lg: 12,
                  md: 12,
                  xs: 12,
                  child: comp.LandlordApplicationTable(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
