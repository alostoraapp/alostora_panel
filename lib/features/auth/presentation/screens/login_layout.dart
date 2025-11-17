import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../widgets/login_form.dart';
import 'login_large_layout.dart';
import 'login_small_layout.dart';

class LoginLayout extends StatelessWidget {
  final OnLoginRequested onLogin;

  const LoginLayout({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    if (isDesktop) {
      return LoginLargeLayout(onLogin: onLogin);
    } else {
      return LoginSmallLayout(onLogin: onLogin);
    }
  }
}
