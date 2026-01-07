import 'package:equatable/equatable.dart';

class NewsCategory extends Equatable {
  final String id;
  final int order;
  final bool isActive;
  final Map<String, String> title;
  final String createdAt;

  const NewsCategory({
    required this.id,
    required this.order,
    required this.isActive,
    required this.title,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, order, isActive, title, createdAt];
}
