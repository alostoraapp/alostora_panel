import 'package:alostora/features/news/domain/entities/news_entity.dart';

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
    required super.titleTranslations,
    required super.contentTranslations,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
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
      titleTranslations: (json['title_translations'] as List<dynamic>?)
              ?.map((e) =>
                  NewsTranslationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      contentTranslations: (json['content_translations'] as List<dynamic>?)
              ?.map((e) =>
                  NewsTranslationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
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
      'title_translations': titleTranslations.map((e) {
        if (e is NewsTranslationModel) {
          return e.toJson();
        }
        return NewsTranslationModel(
          languageCode: e.languageCode,
          text: e.text,
        ).toJson();
      }).toList(),
      'content_translations': contentTranslations.map((e) {
        if (e is NewsTranslationModel) {
          return e.toJson();
        }
        return NewsTranslationModel(
          languageCode: e.languageCode,
          text: e.text,
        ).toJson();
      }).toList(),
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

class NewsTranslationModel extends NewsTranslationEntity {
  const NewsTranslationModel({
    required super.languageCode,
    required super.text,
  });

  factory NewsTranslationModel.fromJson(Map<String, dynamic> json) {
    return NewsTranslationModel(
      languageCode: json['language_code'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language_code': languageCode,
      'text': text,
    };
  }
}
