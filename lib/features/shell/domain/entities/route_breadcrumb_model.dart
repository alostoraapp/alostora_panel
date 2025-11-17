import 'package:equatable/equatable.dart';

class RouteBreadcrumbModel extends Equatable {
  final String title;
  final String parentRoute;
  final String childRoute;

  const RouteBreadcrumbModel({
    required this.title,
    required this.parentRoute,
    required this.childRoute,
  });

  @override
  List<Object?> get props => [title, parentRoute, childRoute];
}
