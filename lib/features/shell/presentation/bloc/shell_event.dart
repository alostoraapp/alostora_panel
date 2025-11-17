part of 'shell_bloc.dart';

abstract class ShellEvent extends Equatable {
  const ShellEvent();

  @override
  List<Object> get props => [];
}

class ToggleSidebar extends ShellEvent {}
