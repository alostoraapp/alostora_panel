import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final String sourceUrl;
  final String status;
  final String priority;
  final bool isPinned;
  final List<dynamic>? relatedTeamsDetails;
  final List<NewsImageEntity> images;
  final List<NewsTranslationEntity> titleTranslations;
  final List<NewsTranslationEntity> contentTranslations;
  final String createdAt;
  final String updatedAt;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.sourceUrl,
    required this.status,
    required this.priority,
    required this.isPinned,
    this.relatedTeamsDetails,
    required this.images,
    required this.titleTranslations,
    required this.contentTranslations,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        sourceUrl,
        status,
        priority,
        isPinned,
        relatedTeamsDetails,
        images,
        titleTranslations,
        contentTranslations,
        createdAt,
        updatedAt,
      ];
}

class NewsImageEntity extends Equatable {
  final String id;
  final String image;
  final String order;
  final String sourceUrl;
  final String createdAt;

  const NewsImageEntity({
    required this.id,
    required this.image,
    required this.order,
    required this.sourceUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, image, order, sourceUrl, createdAt];
}

class NewsTranslationEntity extends Equatable {
  final String languageCode;
  final String text;

  const NewsTranslationEntity({
    required this.languageCode,
    required this.text,
  });

  @override
  List<Object?> get props => [languageCode, text];
}
