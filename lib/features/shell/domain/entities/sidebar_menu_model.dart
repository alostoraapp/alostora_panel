import 'package:equatable/equatable.dart';

class SidebarMenuModel extends Equatable {
  final String title;
  final String icon;
  final String? route;
  final List<SidebarMenuModel> children;

  const SidebarMenuModel({
    required this.title,
    required this.icon,
    this.route,
    this.children = const [],
  });

  @override
  List<Object?> get props => [title, icon, route, children];
}
