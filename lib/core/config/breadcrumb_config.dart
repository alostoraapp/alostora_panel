import 'package:flutter/material.dart';

import '../../features/shell/domain/entities/route_breadcrumb_model.dart';
import '../../../../core/l10n/s.dart';


Map<String, RouteBreadcrumbModel> getBreadcrumbConfig(BuildContext context) {
  final s = S.of(context);

  return {
    '/dashboard/open-ai-admin': RouteBreadcrumbModel(
      title: s.dashboard,
      parentRoute: 'Dashboard',
      childRoute: 'Open AI Admin',
    ),
    '/dashboard/erp-admin': RouteBreadcrumbModel(
      title: s.dashboard,
      parentRoute: 'Dashboard',
      childRoute: 'ERP Admin',
    ),
    // ... other routes will be added here
  };
}
