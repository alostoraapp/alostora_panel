import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/l10n/s.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/constants/app_icons.dart';

typedef OnLoginRequested = void Function(String email, String password);

class LoginForm extends StatefulWidget {
  final OnLoginRequested onLogin;

  const LoginForm({super.key, required this.onLogin});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "admin@admin.com");
    _passwordController = TextEditingController(text: "1234@1234");
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    widget.onLogin(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final iconColor = IconTheme.of(context).color;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          s.login,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(child: Divider(color: theme.colorScheme.outline)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(s.loginCredentials, style: theme.textTheme.bodyMedium),
            ),
            Expanded(child: Divider(color: theme.colorScheme.outline)),
          ],
        ),
        const SizedBox(height: 40),
        _TextFieldLabelWrapper(
          labelText: s.email,
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: s.emailHint),
            onFieldSubmitted: (_) => _submit(),
          ),
        ),
        const SizedBox(height: 20),
        _TextFieldLabelWrapper(
          labelText: s.password,
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              hintText: s.passwordHint,
              suffixIcon: IconButton(
                onPressed: () => setState(() => _showPassword = !_showPassword),
                icon: SvgPicture.asset(
                  _showPassword ? AppIcons.eyeSlash : AppIcons.eye,
                  colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
                ),
              ),
            ),
            onFieldSubmitted: (_) => _submit(),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: _submit,
                child: Text(s.login),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TextFieldLabelWrapper extends StatelessWidget {
  final String labelText;
  final Widget child;

  const _TextFieldLabelWrapper({required this.labelText, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
