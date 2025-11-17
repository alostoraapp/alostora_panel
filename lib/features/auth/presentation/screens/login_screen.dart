import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/s.dart';
import '../bloc/auth_bloc.dart';
import 'login_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

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
        resizeToAvoidBottomInset: false,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(s.loginError),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
            }
          },
          child: LoginLayout(onLogin: onLogin),
        ),
      ),
    );
  }
}
