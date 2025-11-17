import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shell_event.dart';
part 'shell_state.dart';

class ShellBloc extends Bloc<ShellEvent, ShellState> {
  ShellBloc() : super(const ShellInitial(isSidebarExpanded: true)) {
    on<ToggleSidebar>(_onToggleSidebar);
  }

  void _onToggleSidebar(ToggleSidebar event, Emitter<ShellState> emit) {
    emit(ShellInitial(isSidebarExpanded: !state.isSidebarExpanded));
  }
}
