
import 'package:equatable/equatable.dart';

// A functional programming type for handling success (Right) or failure (Left)
abstract class Either<L, R> extends Equatable {
  const Either();

  // This method allows you to process the value inside Either
  // by providing two functions: one for failure (Left) and one for success (Right).
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight);

  @override
  List<Object?> get props => [];
}

class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);

  @override
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) => onLeft(value);

  @override
  List<Object?> get props => [value];
}

class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);

  @override
  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) => onRight(value);

  @override
  List<Object?> get props => [value];
}
