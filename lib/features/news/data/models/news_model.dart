import 'package:alostora/features/matches/data/models/team_model.dart';
import 'package:alostora/features/matches/domain/entities/match_entity.dart';
import 'package:alostora/features/matches/domain/entities/match_status_enum.dart';
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
    super.relatedMatch,
    super.relatedMatchDetails,
    super.isLive = false,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] is Map
          ? Map<String, String>.from(json['title'])
          : {'en': json['title']?.toString() ?? ''},
      content: json['content'] is Map
          ? Map<String, String>.from(json['content'])
          : {'en': json['content']?.toString() ?? ''},
      sourceUrl: json['source_url']?.toString() ?? '',
      status: json['status']?.toString() ?? 'draft',
      priority: json['priority']?.toString() ?? 'normal',
      isPinned: json['is_pinned'] ?? false,
      relatedTeamsDetails: (json['related_teams_details'] as List<dynamic>?)
          ?.map((e) => TeamModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList(),
      images: (json['images'] as List<dynamic>?)
              ?.map<NewsImageEntity>(
                  (e) => NewsImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NewsImageEntity>[],
      categoryDetails: json['category_details'] != null
          ? NewsCategoryModel.fromJson(
              json['category_details'] as Map<String, dynamic>)
          : null,
      relatedMatch: json['related_match']?.toString() ??
          json['related_match_details']?['id']?.toString(),
      relatedMatchDetails: json['related_match_details'] != null
          ? MatchEntity(
              id: json['related_match_details']['id']?.toString() ?? '',
              exId: '',
              matchTime: DateTime.now(),
              status: MatchStatus.notStarted,
              homeScoreFinal: 0,
              awayScoreFinal: 0,
              homeTeam: TeamModel.fromJson(
                      json['related_match_details']['home_team'] ?? {})
                  .toEntity(),
              awayTeam: TeamModel.fromJson(
                      json['related_match_details']['away_team'] ?? {})
                  .toEntity(),
            )
          : null,
      isLive: json['is_live'] ?? false,
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
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
      'related_match': relatedMatch,
      'is_live': isLive,
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
      id: json['id']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      order: json['order']?.toString() ?? '',
      sourceUrl: json['source_url']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
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
