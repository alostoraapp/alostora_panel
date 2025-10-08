import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../widgets/widgets.dart';
import 'components/components.dart' as comp;
import '../../../../core/core.dart';
import '../../../../../../generated/l10n.dart' as l;

class SchoolManagementDashboard extends StatefulWidget {
  const SchoolManagementDashboard({super.key});

  @override
  State<SchoolManagementDashboard> createState() => _SchoolManagementDashboardState();
}

class _SchoolManagementDashboardState extends State<SchoolManagementDashboard> {
  comp.StudentQuantityChartData studentQty = comp.StudentQuantityChartData(
    totalStudent: 480,
    activeStudent: 420,
  );

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
        child: ResponsiveGridRow(
          children: [
            // Overview Cards
            ...List.generate(_overviewItems.length, (index) {
              return ResponsiveGridCol(
                lg: _mqSize.width < 1400 ? 6 : 3,
                md: 6,
                child: Container(
                  margin: EdgeInsets.all(_padding / 2.5),
                  constraints: BoxConstraints.loose(Size.fromHeight(145)),
                  child: comp.OverviewCard(
                    cardData: _overviewItems[index],
                  ),
                ),
              );
            }),

            // Second Row
            ...[
              // Fee Summary
              ResponsiveGridCol(
                lg: _mqSize.width < 1600 ? 12 : 8,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 410,
                  ),
                  child: ShadowContainer(
                    margin: EdgeInsetsDirectional.all(_padding / 2.5),
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                      16,
                      28,
                      16,
                      20,
                    ),
                    headerText: _lang.freeSummary,
                    trailing: const FilterDropdownButton(),
                    child: const comp.FeeSummeryChart(),
                  ),
                ),
              ),

              // Income vs Expense Chart
              ResponsiveGridCol(
                lg: _mqSize.width < 1600 ? 6 : 4,
                md: _mqSize.width < 992 ? 12 : 6,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    height: 410,
                  ),
                  child: ShadowContainer(
                    margin: EdgeInsetsDirectional.all(_padding / 2.5),
                    contentPadding: EdgeInsetsDirectional.all(_padding),
                    headerText: _lang.incomeVSExpense,
                    trailing: const FilterDropdownButton(),
                    child: comp.IncomeExpensePiChart(),
                  ),
                ),
              ),
            ],

            // Third Row
            ...[
              // More Overview cards
              ResponsiveGridCol(
                lg: _mqSize.width < 1600 ? 6 : 5,
                md: _mqSize.width < 992 ? 12 : 6,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    height: responsiveValue(context, xs: null, md: 410),
                  ),
                  child: ShadowContainer(
                    margin: EdgeInsetsDirectional.all(_padding / 2.5),
                    contentPadding: EdgeInsetsDirectional.all(12),
                    showHeader: false,
                    child: ResponsiveGridRow(
                      children: List.generate(
                        _overviewItems2.length,
                        (index) {
                          final _data = _overviewItems2[index];
                          return ResponsiveGridCol(
                            md: 6,
                            child: Padding(
                              padding: EdgeInsets.all(_padding / 2.5),
                              child: comp.OverviewCard2(
                                cardData: _data.copyWith(
                                  backgroundColor: _data.backgroundColor?.withValues(
                                    alpha: 0.25,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // Attendance Chart
              ResponsiveGridCol(
                lg: _mqSize.width < 1600 ? 12 : 7,
                md: _mqSize.width < 992 ? 12 : 12,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(height: 410),
                  child: ShadowContainer(
                    margin: EdgeInsetsDirectional.all(_padding / 2.5),
                    headerText: _lang.attendanceInspection,
                    trailing: const FilterDropdownButton(),
                    child: const comp.AttendanceInspectionChart(),
                  ),
                ),
              ),
            ],

            // Fourth Row
            ...[
              // Student Quantity
              ResponsiveGridCol(
                lg: _mqSize.width < 1600 ? 6 : 4,
                md: _mqSize.width < 992 ? 12 : 6,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 410,
                  ),
                  child: ShadowContainer(
                    margin: EdgeInsetsDirectional.all(_padding / 2.5),
                    contentPadding: EdgeInsetsDirectional.zero,
                    headerText: _lang.studentQuantity,
                    trailing: FilterDropdownButton(
                      items: [
                        ...{
                          comp.StudentQuantityChartData(totalStudent: 480, activeStudent: 420): _lang.one,
                          comp.StudentQuantityChartData(totalStudent: 520, activeStudent: 480): _lang.two,
                          comp.StudentQuantityChartData(totalStudent: 300, activeStudent: 250): _lang.three,
                          comp.StudentQuantityChartData(totalStudent: 400, activeStudent: 350): _lang.four,
                          comp.StudentQuantityChartData(totalStudent: 600, activeStudent: 550): _lang.five,
                          comp.StudentQuantityChartData(totalStudent: 700, activeStudent: 650): _lang.six,
                          comp.StudentQuantityChartData(totalStudent: 200, activeStudent: 150): _lang.seven,
                          comp.StudentQuantityChartData(totalStudent: 800, activeStudent: 750): _lang.eight,
                          comp.StudentQuantityChartData(totalStudent: 300, activeStudent: 200): _lang.nine,
                          comp.StudentQuantityChartData(totalStudent: 250, activeStudent: 150): _lang.ten
                        }.entries.map(
                              (e) => DropdownMenuItem<comp.StudentQuantityChartData>(
                                value: e.key,
                                child: Text('${_lang.clas} ${e.value}'),
                              ),
                            )
                      ],
                      onChanged: (v) => setState(() => studentQty = v!),
                    ),
                    child: comp.StudentQuantityChart(data: studentQty),
                  ),
                ),
              ),

              // Student's Birthday
              ResponsiveGridCol(
                lg: _mqSize.width < 1600 ? 6 : 4,
                md: _mqSize.width < 992 ? 12 : 6,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 410,
                  ),
                  child: ShadowContainer(
                    margin: EdgeInsetsDirectional.all(_padding / 2.5),
                    contentPadding: EdgeInsetsDirectional.zero,
                    headerText: _lang.todayStudentsBirthday,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AcnooAppColors.kSuccess.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "${_lang.total}: ${_overviewItems.length}",
                        style: _theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AcnooAppColors.kSuccess,
                        ),
                      ),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: _studentBirthday.length,
                      itemBuilder: (context, index) {
                        final _item = _studentBirthday[index];
                        return comp.UserListTile(
                          data: comp.UserListTileData(
                            imagePath: _item.imagePath,
                            fullName: _item.name,
                            subtitle: _item.studClass,
                            trailingData: DateFormat('dd MMM yyyy').format(
                              DateTime.now(),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (c, i) {
                        return Divider(
                          color: _theme.colorScheme.outline,
                          height: 0,
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Employee Birthday
              ResponsiveGridCol(
                lg: _mqSize.width < 1600 ? 6 : 4,
                md: _mqSize.width < 992 ? 12 : 6,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 410,
                  ),
                  child: ShadowContainer(
                    margin: EdgeInsetsDirectional.all(_padding / 2.5),
                    contentPadding: EdgeInsetsDirectional.zero,
                    headerText: _lang.todayEmployeeBirthday,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AcnooAppColors.kInfo.withValues(
                          alpha: 0.15,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "${_lang.total}: ${_overviewItems.length}",
                        style: _theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AcnooAppColors.kInfo,
                        ),
                      ),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: _emplBirthday.length,
                      itemBuilder: (context, index) {
                        final _item = _emplBirthday[index];
                        return comp.UserListTile(
                          data: comp.UserListTileData(
                            imagePath: _item.imagePath,
                            fullName: _item.name,
                            subtitle: _item.studClass,
                            trailingData: DateFormat('dd MMM yyyy').format(
                              DateTime.now(),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (c, i) {
                        return Divider(
                          color: _theme.colorScheme.outline,
                          height: 0,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],

            // Fifth Row
            ...(() {
              final content = [
                // This Month Expired Subscription
                ResponsiveGridCol(
                  lg: _mqSize.width < 1600 ? 12 : 8,
                  md: 12,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      height: 410,
                    ),
                    child: ShadowContainer(
                      margin: EdgeInsetsDirectional.all(_padding / 2.5),
                      contentPadding: EdgeInsetsDirectional.zero,
                      headerText: _lang.theMonthExpiredSubscription,
                      trailing: Text.rich(
                        TextSpan(
                          // text: 'View All',
                          text: _lang.viewAll,
                          mouseCursor: SystemMouseCursors.click,
                        ),
                        style: _theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AcnooAppColors.kSuccess,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: const comp.SubscriptionTable(),
                      ),
                    ),
                  ),
                ),

                // Calender
                ResponsiveGridCol(
                  lg: _mqSize.width < 1600 ? 6 : 4,
                  md: _mqSize.width < 992 ? 12 : 6,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      height: 410,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(_padding / 2.5),
                      child: comp.CalendarWidget(),
                    ),
                  ),
                ),
              ];

              return [...(_mqSize.width < 1600 ? content.reversed : content)];
            })(),
          ],
        ),
      ),
    );
  }
}

List<comp.OverviewCardData> get _overviewItems {
  return [
    comp.OverviewCardData(
      primaryLabel: l.S.current.totalAdmission,
      primaryValue: 50,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: 4,
      iconPath: AcnooSVGIcons.book01.svgPath,
      backgroundColor: AcnooSVGIcons.book01.baseColor,
    ),
    comp.OverviewCardData(
      primaryLabel: l.S.current.totalVoucher,
      primaryValue: 12,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: 5,
      iconPath: AcnooSVGIcons.discountTicket01.svgPath,
      backgroundColor: AcnooSVGIcons.discountTicket01.baseColor,
    ),
    comp.OverviewCardData(
      primaryLabel: l.S.current.totalTransport,
      primaryValue: 4,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: 0,
      iconPath: AcnooSVGIcons.busTransit01.svgPath,
      backgroundColor: AcnooSVGIcons.busTransit01.baseColor,
    ),
    comp.OverviewCardData(
      primaryLabel: l.S.current.fosterRooms,
      primaryValue: 12,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: 0,
      iconPath: AcnooSVGIcons.building01.svgPath,
      backgroundColor: AcnooSVGIcons.building01.baseColor,
    ),
  ];
}

List<comp.OverviewCardData> get _overviewItems2 {
  return [
    comp.OverviewCardData(
      primaryLabel: l.S.current.totalEmployees,
      primaryValue: 50,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: 2,
      iconPath: AcnooSVGIcons.usersIcon.svgPath,
      backgroundColor: AcnooSVGIcons.usersIcon.baseColor,
    ),
    comp.OverviewCardData(
      primaryLabel: l.S.current.totalStudents,
      primaryValue: 12,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: 8,
      iconPath: AcnooSVGIcons.student01.svgPath,
      backgroundColor: AcnooSVGIcons.student01.baseColor,
    ),
    comp.OverviewCardData(
      primaryLabel: l.S.current.totalParents,
      primaryValue: 4,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: 8,
      iconPath: AcnooSVGIcons.parent01.svgPath,
      backgroundColor: AcnooSVGIcons.parent01.baseColor,
    ),
    comp.OverviewCardData(
      primaryLabel: l.S.current.totalTeachers,
      primaryValue: 12,
      secondaryLabel: l.S.current.fromLastMonth,
      secondaryValue: -3,
      iconPath: AcnooSVGIcons.teacher01.svgPath,
      backgroundColor: AcnooSVGIcons.teacher01.baseColor,
    ),
  ];
}

List<({String imagePath, String name, String studClass})> get _studentBirthday {
  return [
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_01.png',
      name: 'Richie Collins',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_02.jpeg',
      name: 'Darrell Lemke',
      studClass: l.S.current.seven,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_03.png',
      name: 'Glen Nitzsche',
      studClass: l.S.current.nine,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_04.png',
      name: 'Virgie Kohler',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_05.png',
      name: 'Alexander Rempel',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_01.png',
      name: 'Coralie Greenfelder',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_02.jpeg',
      name: 'Elian VonRueden',
      studClass: l.S.current.seven,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_03.png',
      name: 'Eldon Daniel',
      studClass: l.S.current.nine,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_04.png',
      name: 'Cordie Larkin',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_05.png',
      name: 'Madisen Cronin',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_01.png',
      name: 'Dorothea Ankunding',
      studClass: l.S.current.nine,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_02.jpeg',
      name: 'Mandy Schaden',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/placeholder_avatar/placeholder_avatar_03.png',
      name: 'Tracey Lebsack',
      studClass: l.S.current.six,
    ),
  ];
}

List<({String imagePath, String name, String studClass})> get _emplBirthday {
  return [
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_01.jpeg',
      name: 'Richie Collins',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_02.jpeg',
      name: 'Darrell Lemke',
      studClass: l.S.current.seven,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_03.jpeg',
      name: 'Glen Nitzsche',
      studClass: l.S.current.nine,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_04.jpeg',
      name: 'Virgie Kohler',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_05.jpeg',
      name: 'Alexander Rempel',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_01.jpeg',
      name: 'Coralie Greenfelder',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_02.jpeg',
      name: 'Elian VonRueden',
      studClass: l.S.current.seven,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_03.jpeg',
      name: 'Eldon Daniel',
      studClass: l.S.current.nine,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_04.jpeg',
      name: 'Cordie Larkin',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_05.jpeg',
      name: 'Madisen Cronin',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_01.jpeg',
      name: 'Dorothea Ankunding',
      studClass: l.S.current.nine,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_02.jpeg',
      name: 'Mandy Schaden',
      studClass: l.S.current.six,
    ),
    (
      imagePath: 'assets/images/static_images/avatars/person_images/person_image_03.jpeg',
      name: 'Tracey Lebsack',
      studClass: l.S.current.six,
    ),
  ];
}
