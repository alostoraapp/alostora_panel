import 'package:equatable/equatable.dart';

// Represents a failure in the application, to be used by the Domain layer
abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

// Specific failure for authentication errors
class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}