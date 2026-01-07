import '../../domain/entities/news_category.dart';

class NewsCategoryModel extends NewsCategory {
  const NewsCategoryModel({
    required super.id,
    required super.order,
    required super.isActive,
    required super.title,
    required super.createdAt,
  });

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    return NewsCategoryModel(
      id: json['id'] as String,
      order: json['order'] as int? ?? 0,
      isActive: json['is_active'] as bool? ?? false,
      title: Map<String, String>.from(json['title'] as Map),
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'is_active': isActive,
      'title': title,
      'created_at': createdAt,
    };
  }

  NewsCategory toEntity() {
    return NewsCategory(
      id: id,
      order: order,
      isActive: isActive,
      title: title,
      createdAt: createdAt,
    );
  }
}
