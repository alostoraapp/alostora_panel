import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../bloc/shell_bloc.dart';
import '../widgets/route_breadcrumb.dart';
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return BlocProvider(
      create: (_) => ShellBloc(),
      child: Scaffold(
        appBar: const Topbar(),
        drawer: isDesktop ? null : const Drawer(child: Sidebar()),
        body: Row(
          children: [
            if (isDesktop) const Sidebar(),
            Expanded(
              child: Column(
                children: [
                  // --- Breadcrumb Navigation --- //
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                    child: RouteBreadcrumb(),
                  ),
                  // --- Main Content --- //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
