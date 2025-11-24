import 'package:equatable/equatable.dart';

// Represents a failure in the application, to be used by the Domain layer
abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

// General failures for server-side and cache-side errors
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
