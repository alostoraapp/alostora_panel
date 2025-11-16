import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'injection_container.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'core/presentation/cubit/language_cubit.dart';
import 'core/presentation/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetIt service locator
  await di.init();

  runApp(
    // Provide the BLoCs/Cubits that need to be globally accessible
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(AuthCheckStatusRequested()),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => di.sl<ThemeCubit>(),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) => di.sl<LanguageCubit>(),
        ),
      ],
      child: const App(),
    ),
  );
}