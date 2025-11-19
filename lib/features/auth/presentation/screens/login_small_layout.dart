import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginSmallLayout extends StatelessWidget {
  final OnLoginRequested onLogin;

  const LoginSmallLayout({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primaryContainer,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoginHeader(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 375),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: LoginForm(onLogin: onLogin),
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