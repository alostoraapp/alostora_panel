import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/check_status_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckStatusUseCase _checkStatusUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required CheckStatusUseCase checkStatusUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _checkStatusUseCase = checkStatusUseCase,
        super(AuthInitial()) {
    on<AuthCheckStatusRequested>(_onAuthCheckStatusRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  // A mock user entity. In a real app, this would be fetched from the backend.
  static const _mockUser = UserEntity(
    id: '1',
    name: 'Admin User',
    email: 'admin@test.com',
  );

  Future<void> _onAuthCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    // The artificial delay was removed. The splash screen will be visible
    // for the actual duration of the checkStatusUseCase call.
    final result = await _checkStatusUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthUnauthenticated()), // On error, treat as unauthenticated
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(const AuthAuthenticated(user: _mockUser));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _loginUseCase(
        LoginParams(email: event.email, password: event.password));

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(const AuthAuthenticated(user: _mockUser)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Attempt to logout from server
    await _logoutUseCase(NoParams());
    
    // Regardless of the server response (success or failure), 
    // we should clear the local state and redirect the user to login.
    emit(AuthUnauthenticated());
  }
}
