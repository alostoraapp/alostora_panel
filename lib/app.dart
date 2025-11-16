import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'core/config/app_theme.dart';
import 'core/l10n/l10n.dart';
import 'core/presentation/cubit/language_cubit.dart';
import 'core/presentation/cubit/theme_cubit.dart';
import 'l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the states of Theme and Language cubits
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LanguageCubit>().state;

    return MaterialApp.router(
      title: 'Admin Panel',
      debugShowCheckedModeBanner: false,

      // --- Theme Configuration ---
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // --- Localization Configuration ---
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: L10n.all,

      // --- Router Configuration ---
      routerConfig: AppRouter.router,
    );
  }
}