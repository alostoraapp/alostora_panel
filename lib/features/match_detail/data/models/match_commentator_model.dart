import '../../domain/entities/match_commentator_entity.dart';
import 'commentator_model.dart';

class MatchCommentatorModel extends MatchCommentatorEntity {
  const MatchCommentatorModel({
    required super.id,
    required super.commentator,
  });

  factory MatchCommentatorModel.fromJson(Map<String, dynamic> json) {
    return MatchCommentatorModel(
      id: json['id'] ?? '',
      commentator: CommentatorModel.fromJson(json['commentator'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commentator': (commentator as CommentatorModel).toJson(),
    };
  }
}
