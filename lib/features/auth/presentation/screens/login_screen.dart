import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../core/presentation/cubit/theme_cubit.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (context.read<AuthBloc>().state is! AuthLoading) {
      context.read<AuthBloc>().add(
            AuthLoginRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDesktop = screenWidth >= 1200;
    final isDark = theme.brightness == Brightness.dark;

    final logoAsset = isDark
        ? 'assets/images/logo/logo_caption_dark.png'
        : 'assets/images/logo/logo_caption_light.png';

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: isDesktop ? (screenWidth * 0.45) : screenWidth,
                ),
                color: theme.colorScheme.primaryContainer,
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildHeader(context, s),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 375),
                          child: Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(24),
                              child: _buildLoginForm(context, s, theme),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isDesktop)
              Expanded(
                child: Container(
                  color: theme.colorScheme.tertiaryContainer,
                  child: Center(
                    child: Image.asset(
                      logoAsset, // Use dynamic logo
                      width: 400,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            s.appName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                tooltip: s.changeTheme,
                onPressed: () => context.read<ThemeCubit>().toggleThemeMode(),
              ),
              IconButton(
                icon: const Icon(Icons.language),
                tooltip: s.changeLanguage,
                onPressed: () => context.read<LanguageCubit>().toggleLanguage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, AppLocalizations s, ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          s.login,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 40),
        
        // Divider
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

        // Email Field
        _TextFieldLabelWrapper(
          labelText: s.email,
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: s.emailHint),
            onFieldSubmitted: (_) => _login(context),
          ),
        ),
        const SizedBox(height: 20),

        // Password Field
        _TextFieldLabelWrapper(
          labelText: s.password,
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              hintText: s.passwordHint,
              suffixIcon: IconButton(
                onPressed: () => setState(() => _showPassword = !_showPassword),
                icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
              ),
            ),
            onFieldSubmitted: (_) => _login(context),
          ),
        ),
        const SizedBox(height: 30),

        // Submit Button
        SizedBox(
          width: double.infinity,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: theme.colorScheme.error,
                    ),
                  );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () => _login(context),
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
