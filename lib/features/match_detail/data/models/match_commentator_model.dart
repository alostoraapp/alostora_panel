import '../../domain/entities/match_commentator_entity.dart';
import 'commentator_model.dart';
import 'tv_channel_model.dart';

class MatchCommentatorModel extends MatchCommentatorEntity {
  const MatchCommentatorModel({
    required super.id,
    required super.commentator,
    super.tvChannel,
  });

  factory MatchCommentatorModel.fromJson(Map<String, dynamic> json) {
    return MatchCommentatorModel(
      id: json['id'] ?? '',
      commentator: CommentatorModel.fromJson(json['commentator'] ?? {}),
      tvChannel: json['tv_channel'] != null
          ? TvChannelModel.fromJson(json['tv_channel'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commentator': (commentator as CommentatorModel).toJson(),
      if (tvChannel != null)
        'tv_channel': (tvChannel as TvChannelModel).toJson(),
    };
  }
}
