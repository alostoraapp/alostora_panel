import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../../generated/l10n.dart' as l;
import '../../../../core/core.dart';
import '../../../../widgets/widgets.dart';
import 'components/components.dart' as comp;

class LmsManagementDashboard extends StatefulWidget {
  const LmsManagementDashboard({super.key});

  @override
  State<LmsManagementDashboard> createState() => _LmsManagementDashboardState();
}

class _LmsManagementDashboardState extends State<LmsManagementDashboard> {
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
            //OverView Item
            ResponsiveGridRow(
              children: List.generate(
                _overView.length,
                (index) {
                  final _data = _overView[index];
                  return ResponsiveGridCol(
                    lg: _mqSize.width < 1400 ? 6 : 3,
                    md: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OverviewIncomeReportWidget(
                        color: _data.color,
                        title: _data.title,
                        value: _data.amount,
                        subAmount: _data.subAmount,
                        icon: _data.icon,
                      ),
                    ),
                  );
                },
              ),
            ),
            ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  child: ResponsiveGridRow(
                    children: [
                      //Overall Revenue
                      ResponsiveGridCol(
                        lg: _mqSize.width < 1600 ? 12 : 8,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            height: 420,
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(_padding / 2.5),
                            headerText: _lang.overallRevenue,
                            trailing: const FilterDropdownButton(),
                            child: comp.OverallRevenueChart(),
                          ),
                        ),
                      ),

                      //Device Statistics chart
                      ResponsiveGridCol(
                        lg: _mqSize.width < 1600 ? 6 : 4,
                        md: _mqSize.width < 768 ? 12 : 6,
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            height: responsiveValue(
                              context,
                              lg: _mqSize.width < 1600 ? 388 : 420,
                              xs: 388,
                            ),
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(_padding / 2.5),
                            contentPadding: EdgeInsetsDirectional.all(_padding),
                            headerText: _lang.deviceStatics,
                            trailing: const FilterDropdownButton(),
                            child: comp.DeviceStaticsPieChart(),
                          ),
                        ),
                      ),

                      //statics by gender chart
                      ResponsiveGridCol(
                        lg: _mqSize.width < 1600 ? 6 : 4,
                        md: _mqSize.width < 768 ? 12 : 6,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            height: 388,
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(
                              _padding / 2.5,
                            ),
                            contentPadding: EdgeInsetsDirectional.all(
                              _padding / 2.5,
                            ),
                            headerText: _lang.staticsByGender,
                            trailing: const FilterDropdownButton(),
                            child: Align(
                              alignment: Alignment.center,
                              child: comp.StaticsGenderChart(),
                            ),
                          ),
                        ),
                      ),

                      //Popular instructor
                      ResponsiveGridCol(
                        lg: _mqSize.width < 1600 ? 6 : 4,
                        md: _mqSize.width < 992 ? 12 : 6,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            height: 388,
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(_padding / 2.5),
                            contentPadding: EdgeInsetsDirectional.zero,
                            headerText: _lang.popularInstructor,
                            trailing: Text.rich(
                              TextSpan(
                                text: _lang.viewAll,
                                mouseCursor: SystemMouseCursors.click,
                              ),
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: _theme.colorScheme.primary,
                              ),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _instructionList.length,
                              itemBuilder: (context, index) {
                                final _item = _instructionList[index];
                                return comp.PopularInstructionTile(
                                  imagePath: _item.imagePath,
                                  name: _item.name,
                                  instructorDetails: _item.instructorDetail,
                                  course: _item.course,
                                );
                              },
                              separatorBuilder: (c, i) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      //Top Students
                      ResponsiveGridCol(
                        lg: _mqSize.width < 1600 ? 6 : 4,
                        md: _mqSize.width < 992 ? 12 : 6,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            height: 388,
                          ),
                          child: ShadowContainer(
                            margin: EdgeInsetsDirectional.all(_padding / 2.5),
                            contentPadding: EdgeInsetsDirectional.zero,
                            headerText: _lang.topStudents,
                            trailing: Text.rich(
                              TextSpan(
                                // text: 'View All',
                                text: _lang.viewAll,
                                mouseCursor: SystemMouseCursors.click,
                              ),
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: _theme.colorScheme.primary,
                              ),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _studentInfo.length,
                              itemBuilder: (context, index) {
                                final _item = _studentInfo[index];
                                return comp.TopStudentTile(
                                  imagePath: _item.imagePath,
                                  title: _item.name,
                                  subTitle: _item.courseDeatils,
                                  progressColor: _item.progressColor,
                                  percentValue: _item.percentValue,
                                );
                              },
                              separatorBuilder: (c, i) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
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
                //Popular Course Category
                ResponsiveGridCol(
                  lg: 4,
                  md: 12,
                  xs: 12,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      height: 388,
                    ),
                    child: ShadowContainer(
                      margin: EdgeInsetsDirectional.all(_padding / 2.5),
                      contentPadding: EdgeInsetsDirectional.zero,
                      headerText: _lang.popularCourseCategory,
                      trailing: Text.rich(
                        TextSpan(
                          text: _lang.viewAll,
                          mouseCursor: SystemMouseCursors.click,
                        ),
                        style: _theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: _theme.colorScheme.primary,
                        ),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _courseInfo.length,
                        itemBuilder: (context, index) {
                          final _item = _courseInfo[index];
                          return comp.PopularCourseCategory(
                            imagePath: _item.imagePath,
                            title: _item.title,
                            subTitle: _item.subtitle,
                            totalCourse: _item.totalCourse,
                            leadingColor: _item.color,
                          );
                        },
                        separatorBuilder: (c, i) {
                          return SizedBox(
                            height: 16,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                //Total Traffic
                ResponsiveGridCol(
                  lg: 8,
                  md: 12,
                  xs: 12,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      height: 388,
                    ),
                    child: ShadowContainer(
                      margin: EdgeInsetsDirectional.all(_padding / 2.5),
                      headerText: _lang.totalTraffic,
                      trailing: const FilterDropdownButton(),
                      child: comp.TrafficChart(),
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

List<
    ({
      String title,
      String amount,
      Color color,
      String subAmount,
      String icon
    })> get _overView {
  return [
    (
      title: l.S.current.totalCourseSales,
      amount: "1500",
      subAmount: "18",
      color: Color(0xff0043FA),
      icon: AcnooSVGIcons.tutorIcon,
    ),
    (
      title: l.S.current.totalNewStudents,
      amount: "700",
      subAmount: "300",
      color: Color(0xff9935FE),
      icon: AcnooSVGIcons.usersIcon.svgPath,
    ),
    (
      title: l.S.current.totalProfileViews,
      amount: "50,000",
      subAmount: "5k",
      color: Color(0xff00BBB4),
      icon: AcnooSVGIcons.flowIcon,
    ),
    (
      title: l.S.current.totalIncome,
      amount: "\$7,500",
      subAmount: "5k",
      color: Color(0xffF44207),
      icon: AcnooSVGIcons.amountIcon,
    ),
  ];
}

List<({String name, String instructorDetail, int course, String imagePath})>
    get _instructionList {
  return [
    (
      name: 'Ralph Edwards',
      instructorDetail: 'Certified Instructor, NV DMV',
      course: 10,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_09.jpeg',
    ),
    (
      name: 'Eleanor Pena',
      instructorDetail: 'Certified Instructor, NV DMV',
      course: 20,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_10.jpeg',
    ),
    (
      name: 'Jane Cooper',
      instructorDetail: 'Certified Instructor, NV DMV',
      course: 8,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_11.jpeg',
    ),
    (
      name: 'Jacob Jones',
      instructorDetail: 'Certified Instructor, NV DMV',
      course: 12,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_12.jpeg',
    ),
    (
      name: 'Ralph Edwards',
      instructorDetail: 'Certified Instructor, NV DMV',
      course: 10,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_13.jpeg',
    ),
  ];
}

List<
    ({
      String name,
      String courseDeatils,
      Color progressColor,
      String imagePath,
      double percentValue
    })> get _studentInfo {
  return [
    (
      name: 'Robert Fox',
      courseDeatils: '5',
      percentValue: 0.8,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_09.jpeg',
      progressColor: Color(0xffFD7F0B),
    ),
    (
      name: 'Courtney Henry',
      courseDeatils: '2',
      percentValue: 0.6,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_10.jpeg',
      progressColor: Color(0xff1D4ED8)
    ),
    (
      name: 'Cameron Williamson',
      courseDeatils: '3',
      percentValue: 0.8,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_11.jpeg',
      progressColor: Color(0xff00B243)
    ),
    (
      name: 'Cody Fisher',
      courseDeatils: '4',
      percentValue: 0.82,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_12.jpeg',
      progressColor: Color(0xff7500FD)
    ),
    (
      name: 'Ralph Edwards',
      courseDeatils: '5',
      percentValue: 0.5,
      imagePath:
          'assets/images/static_images/avatars/person_images/person_image_13.jpeg',
      progressColor: Color(0xffE40F0F)
    ),
  ];
}

List<
    ({
      String title,
      String subtitle,
      Color color,
      String imagePath,
      double totalCourse
    })> get _courseInfo {
  return [
    (
      title: l.S.current.uiUxDesign,
      subtitle: l.S.current.availableCertificate,
      totalCourse: 40,
      imagePath:
          'assets/images/widget_images/dashboard_lms_management_icons/uiux.svg',
      color: Color(0xff1B84FF),
    ),
    (
      title: l.S.current.webDevelopment,
      subtitle: l.S.current.availableCertificate,
      totalCourse: 40,
      imagePath:
          'assets/images/widget_images/dashboard_lms_management_icons/web.svg',
      color: Color(0xffF8285A),
    ),
    (
      title: l.S.current.marketing,
      subtitle: l.S.current.availableCertificate,
      totalCourse: 40,
      imagePath:
          'assets/images/widget_images/dashboard_lms_management_icons/marketing.svg',
      color: Color(0xff7239EA),
    ),
    (
      title: l.S.current.philosophy,
      subtitle: 'N/A',
      totalCourse: 50,
      imagePath:
          'assets/images/widget_images/dashboard_lms_management_icons/philosopy.svg',
      color: Color(0xffFD7F0B),
    ),
    (
      title: l.S.current.mathematics,
      subtitle: l.S.current.availableCertificate,
      totalCourse: 50,
      imagePath:
          'assets/images/widget_images/dashboard_lms_management_icons/mathmatics.svg',
      color: Color(0xff00CEE4),
    ),
  ];
}
