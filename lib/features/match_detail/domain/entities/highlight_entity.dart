import 'package:equatable/equatable.dart';

class HighlightEntity extends Equatable {
  final String id;
  final String matchId;
  final String type;
  final String title;
  final String mediaUrl;
  final String? cover;
  final int? videoTime;
  final String status;
  final String priority;
  final String? publishTime;
  final List<HighlightTranslationEntity> titleTranslations;

  const HighlightEntity({
    required this.id,
    required this.matchId,
    required this.type,
    required this.title,
    required this.mediaUrl,
    this.cover,
    this.videoTime,
    required this.status,
    required this.priority,
    this.publishTime,
    required this.titleTranslations,
  });

  @override
  List<Object?> get props => [
        id,
        matchId,
        type,
        title,
        mediaUrl,
        cover,
        videoTime,
        status,
        priority,
        publishTime,
        titleTranslations,
      ];
}

class HighlightTranslationEntity extends Equatable {
  final String languageCode;
  final String text;

  const HighlightTranslationEntity({
    required this.languageCode,
    required this.text,
  });

  @override
  List<Object?> get props => [languageCode, text];
}
