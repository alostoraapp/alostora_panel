import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../core/l10n/s.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    void onLogin(String email, String password) {
      if (context.read<AuthBloc>().state is! AuthLoading) {
        context.read<AuthBloc>().add(
          AuthLoginRequested(email: email, password: password),
        );
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.primaryContainer,
        resizeToAvoidBottomInset: true,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(s.loginError),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
            }
          },
          child: SafeArea(
            child: Builder(
              builder: (context) {
                final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

                if (isDesktop) {
                  return _buildDesktopLayout(context, onLogin);
                } else {
                  return _buildMobileLayout(context, onLogin);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, OnLoginRequested onLogin) {
    return Column(
      children: [
        // هدر ثابت در بالای صفحه
        const LoginHeader(),
        // فضای اسکرول شونده برای فرم
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16), // فاصله کمی از هدر
                  Text(
                    S.of(context).login,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 375),
                    child: LoginForm(onLogin: onLogin),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, OnLoginRequested onLogin) {
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
            child: Column(
              children: [
                // هدر ثابت در بالای ستون چپ
                const LoginHeader(),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Text(
                            S.of(context).login,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 375),
                            child: LoginForm(onLogin: onLogin),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                errorBuilder: (context, error, stackTrace) => 
                    const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
