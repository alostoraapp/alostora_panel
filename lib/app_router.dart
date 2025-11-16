import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/widgets/go_router_refresh_stream.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/screens/dashboard_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'injection_container.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,

    // Refresh the router state when AuthBloc state changes
    refreshListenable: GoRouterRefreshStream(
      sl<AuthBloc>().stream,
    ),

    // Initial route
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
      GoRoute(
        path: AppRoutes.dashboard, // Changed from home to dashboard
        name: AppRoutes.dashboard, // Changed from home to dashboard
        builder: (context, state) => const DashboardScreen(), // Changed from HomeScreen to DashboardScreen
      ),
    ],

    redirect: (BuildContext context, GoRouterState state) {
      final authState = context.read<AuthBloc>().state;

      final isSplash = state.matchedLocation == AppRoutes.splash;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;

      // While app is initializing, show splash screen
      if (authState is AuthInitial) {
        return isSplash ? null : AppRoutes.splash;
      }

      // If unauthenticated, redirect to login
      if (authState is AuthUnauthenticated) {
        return isLoggingIn ? null : AppRoutes.login;
      }

      // If authenticated, redirect to dashboard
      if (authState is AuthAuthenticated) {
        return isLoggingIn || isSplash ? AppRoutes.dashboard : null; // Changed from home to dashboard
      }

      // Default redirect in case of unknown state
      return AppRoutes.login;
    },
  );
}

// Static class for route paths to avoid magic strings
class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard'; // Changed from home to dashboard
}
