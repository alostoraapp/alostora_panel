import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/widgets/go_router_refresh_stream.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/match_detail/presentation/screens/match_detail_screen.dart';
import 'features/matches/presentation/bloc/matches_bloc.dart';
import 'features/matches/presentation/screens/match_tiles_screen.dart';
import 'features/overview/presentation/screens/dashboard_screen.dart';
import 'features/settings/presentation/screens/competition_select_screen.dart';
import 'features/shell/presentation/screens/app_shell.dart';
import 'features/shell/presentation/screens/placeholder_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'injection_container.dart';
import 'features/matches/domain/entities/match_entity.dart'; // Import MatchEntity

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
          // Provide MatchesBloc to the entire shell
          return BlocProvider(
            create: (context) => sl<MatchesBloc>(),
            child: AppShell(child: child),
          );
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
            path: AppRoutes.matchDetail,
            name: AppRoutes.matchDetail,
            builder: (context, state) {
              final match = state.extra as MatchEntity?;
              if (match == null) {
                return const PlaceholderScreen(title: 'Error: Match not found');
              }
              return MatchDetailScreen(match: match);
            },
          ),
          GoRoute(
            path: AppRoutes.matchesList,
            name: AppRoutes.matchesList,
            builder: (context, state) =>
                const PlaceholderScreen(title: 'Matches List'),
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
        if (isSplash || isLoggingIn) return AppRoutes.dashboardOverview;
        if (state.matchedLocation == '/') return AppRoutes.dashboardOverview;
      }

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
  static const String matchDetail = '/matches/:matchId';
  static const String matchOverview = 'overview';
  static const String matchHighlights = 'highlights';
  static const String matchIncidents = 'incidents';
  static const String matchMedia = 'media';
  static const String matchDetails = 'details';

  // Settings
  static const String settings = '/settings';
  static const String competitionSelect = '/settings/competition-select';
}
