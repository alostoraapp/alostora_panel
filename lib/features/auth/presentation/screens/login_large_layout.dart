import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginLargeLayout extends StatelessWidget {
  final OnLoginRequested onLogin;

  const LoginLargeLayout({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final logoAsset = isDark
        ? 'assets/images/logo/logo_caption_dark.png'
        : 'assets/images/logo/logo_caption_light.png';

    return Row(
      children: [
        Expanded(
          child: Container(
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
          ),
        ),
        Expanded(
          child: Container(
            color: theme.colorScheme.tertiaryContainer,
            child: Center(
              child: Image.asset(
                logoAsset,
                width: 400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
