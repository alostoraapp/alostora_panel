import 'package:equatable/equatable.dart';

import '../../../matches/domain/entities/match_entity.dart';
import '../../../matches/domain/entities/team_entity.dart';
import 'news_category.dart';

class NewsEntity extends Equatable {
  final String id;
  final Map<String, String> title;
  final Map<String, String> content;
  final String sourceUrl;
  final String status;
  final String priority;
  final bool isPinned;
  final List<TeamEntity>? relatedTeamsDetails;
  final List<NewsImageEntity> images;
  final NewsCategory? categoryDetails;
  final String? relatedMatch;
  final MatchEntity? relatedMatchDetails;
  final bool isLive;
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
    this.categoryDetails,
    this.relatedMatch,
    this.relatedMatchDetails,
    this.isLive = false,
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
        categoryDetails,
        relatedMatch,
        relatedMatchDetails,
        isLive,
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
