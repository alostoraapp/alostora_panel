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
      id: json['id']?.toString() ?? '',
      order: json['order'] is int ? json['order'] : 0,
      isActive: json['is_active'] ?? false,
      title: json['title'] is Map
          ? Map<String, String>.from(json['title'])
          : {'en': json['title']?.toString() ?? ''},
      createdAt: json['created_at']?.toString() ?? '',
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
