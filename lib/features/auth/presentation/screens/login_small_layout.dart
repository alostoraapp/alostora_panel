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
        child: Column(
          children: [
            const LoginHeader(),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 375),
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: LoginForm(onLogin: onLogin),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
