import 'package:equatable/equatable.dart';
import 'commentator_entity.dart';

class MatchCommentatorEntity extends Equatable {
  final String id;
  final CommentatorEntity commentator;

  const MatchCommentatorEntity({
    required this.id,
    required this.commentator,
  });

  @override
  List<Object?> get props => [id, commentator];
}
