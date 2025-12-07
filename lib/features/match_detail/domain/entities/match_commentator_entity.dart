import 'package:equatable/equatable.dart';
import 'commentator_entity.dart';
import 'tv_channel_entity.dart';

class MatchCommentatorEntity extends Equatable {
  final String id;
  final CommentatorEntity commentator;
  final TvChannelEntity? tvChannel;

  const MatchCommentatorEntity({
    required this.id,
    required this.commentator,
    this.tvChannel,
  });

  @override
  List<Object?> get props => [id, commentator, tvChannel];
}
