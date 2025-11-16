import 'package:equatable/equatable.dart';

// A simple entity representing the user.
// This is what the UI and Domain layers will use.
class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}