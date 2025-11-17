part of 'shell_bloc.dart';

abstract class ShellState extends Equatable {
  final bool isSidebarExpanded;

  const ShellState({required this.isSidebarExpanded});

  @override
  List<Object> get props => [isSidebarExpanded];
}

class ShellInitial extends ShellState {
  const ShellInitial({required super.isSidebarExpanded});
}
