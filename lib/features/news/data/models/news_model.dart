import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'news_category_model.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    required super.id,
    required super.title,
    required super.content,
    required super.sourceUrl,
    required super.status,
    required super.priority,
    required super.isPinned,
    super.relatedTeamsDetails,
    required super.images,
    super.categoryDetails,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'] is Map
          ? Map<String, String>.from(json['title'])
          : {'en': json['title']?.toString() ?? ''},
      content: json['content'] is Map
          ? Map<String, String>.from(json['content'])
          : {'en': json['content']?.toString() ?? ''},
      sourceUrl: json['source_url'] ?? '',
      status: json['status'] ?? 'draft',
      priority: json['priority'] ?? 'normal',
      isPinned: json['is_pinned'] ?? false,
      relatedTeamsDetails: json['related_teams_details'] as List<dynamic>?,
      images: (json['images'] as List<dynamic>?)
              ?.map<NewsImageEntity>(
                  (e) => NewsImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NewsImageEntity>[],
      categoryDetails: json['category_details'] != null
          ? NewsCategoryModel.fromJson(
              json['category_details'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'source_url': sourceUrl,
      'status': status,
      'priority': priority,
      'is_pinned': isPinned,
      'related_teams_details': relatedTeamsDetails,
      'images': images.map((e) {
        if (e is NewsImageModel) {
          return e.toJson();
        }
        return NewsImageModel(
          id: e.id,
          image: e.image,
          order: e.order,
          sourceUrl: e.sourceUrl,
          createdAt: e.createdAt,
        ).toJson();
      }).toList(),
      if (categoryDetails != null)
        'category_details': (categoryDetails as NewsCategoryModel).toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class NewsImageModel extends NewsImageEntity {
  const NewsImageModel({
    required super.id,
    required super.image,
    required super.order,
    required super.sourceUrl,
    required super.createdAt,
  });

  factory NewsImageModel.fromJson(Map<String, dynamic> json) {
    return NewsImageModel(
      id: json['id'],
      image: json['image'] ?? '',
      order: json['order'] ?? '',
      sourceUrl: json['source_url'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'order': order,
      'source_url': sourceUrl,
      'created_at': createdAt,
    };
  }
}
