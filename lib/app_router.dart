import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/widgets/go_router_refresh_stream.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/matches/presentation/screens/match_tiles_screen.dart';
import 'features/overview/presentation/screens/dashboard_screen.dart';
import 'features/settings/presentation/screens/competition_select_screen.dart';
import 'features/shell/presentation/screens/app_shell.dart';
import 'features/shell/presentation/screens/placeholder_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'injection_container.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,

    refreshListenable: GoRouterRefreshStream(
      sl<AuthBloc>().stream,
    ),

    initialLocation: AppRoutes.splash,

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.dashboardOverview,
            name: AppRoutes.dashboardOverview,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.matchesTiles,
            name: AppRoutes.matchesTiles,
            builder: (context, state) => const MatchTilesScreen(),
          ),
          GoRoute(
            path: AppRoutes.matchesList,
            name: AppRoutes.matchesList,
            builder: (context, state) => const PlaceholderScreen(title: 'Matches List'),
          ),
          // Settings
          GoRoute(
            path: AppRoutes.competitionSelect,
            name: AppRoutes.competitionSelect,
            builder: (context, state) => const CompetitionSelectScreen(),
          ),
        ],
      ),
    ],

    redirect: (BuildContext context, GoRouterState state) {
      final authState = context.read<AuthBloc>().state;

      final isSplash = state.matchedLocation == AppRoutes.splash;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;

      if (authState is AuthInitial) {
        return isSplash ? null : AppRoutes.splash;
      }

      if (authState is AuthUnauthenticated) {
        return isLoggingIn ? null : AppRoutes.login;
      }

      if (authState is AuthAuthenticated) {
        // If authenticated, redirect from splash or login to the overview page.
        if (isSplash || isLoggingIn) return AppRoutes.dashboardOverview;
        // If at the root, also redirect to the overview page.
        if (state.matchedLocation == '/') return AppRoutes.dashboardOverview;
      }

      // No redirect needed for other cases
      return null;
    },
  );
}

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';

  // Dashboard
  static const String dashboard = '/dashboard';
  static const String dashboardOverview = '/dashboard/overview';

  // Matches
  static const String matches = '/matches';
  static const String matchesTiles = '/matches/tiles';
  static const String matchesList = '/matches/list';

  // Settings
  static const String settings = '/settings';
  static const String competitionSelect = '/settings/competition-select';
}
