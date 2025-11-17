import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_localizations.dart'; // Correct import for the 'S' helper class
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bool isRTL = context.read<LanguageCubit>().isRTL();
    final authState = context.watch<AuthBloc>().state;

    UserEntity? user;
    if (authState is AuthAuthenticated) {
      user = authState.user;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(s.home), // This now correctly points to "Dashboard"
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: s.logout,
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                s.welcome,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (user != null)
                Text(
                  user.name, // Display user's name from the entity
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
