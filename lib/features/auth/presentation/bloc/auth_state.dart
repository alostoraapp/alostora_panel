
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

// Initial state, shown during splash screen
class AuthInitial extends AuthState {}

// Shown when user is logging in (e.g., show loading indicator)
class AuthLoading extends AuthState {}

// State when user is successfully logged in
class AuthAuthenticated extends AuthState {
  // Now we hold the complete user entity
  final UserEntity user;
  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

// State when user is not logged in
class AuthUnauthenticated extends AuthState {}

// State when an error occurs during authentication
class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
