import 'package:alostora/features/match_detail/domain/entities/highlight_entity.dart';

class HighlightModel extends HighlightEntity {
  const HighlightModel({
    required super.id,
    required super.matchId,
    required super.type,
    required super.title,
    required super.mediaUrl,
    super.cover,
    super.videoTime,
    required super.status,
    required super.priority,
    super.publishTime,
    required super.titleTranslations,
  });

  factory HighlightModel.fromJson(Map<String, dynamic> json) {
    return HighlightModel(
      id: json['id'],
      matchId: json['match'],
      type: json['type'],
      title: json['title'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      cover: json['cover'],
      videoTime: json['video_time'],
      status: json['status'],
      priority: json['priority'],
      publishTime: json['publish_time'],
      titleTranslations: (json['title_translations'] as List<dynamic>?)
              ?.map((e) => HighlightTranslationModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'match': matchId,
      'type': type,
      'title': title,
      'media_url': mediaUrl,
      'cover': cover,
      'video_time': videoTime,
      'status': status,
      'priority': priority,
      'publish_time': publishTime,
      'title_translations': titleTranslations
          .map((e) => (e as HighlightTranslationModel).toJson())
          .toList(),
    };
  }
}

class HighlightTranslationModel extends HighlightTranslationEntity {
  const HighlightTranslationModel({
    required super.languageCode,
    required super.text,
  });

  factory HighlightTranslationModel.fromJson(Map<String, dynamic> json) {
    return HighlightTranslationModel(
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
