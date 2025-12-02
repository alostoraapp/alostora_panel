import 'package:equatable/equatable.dart';
import 'tv_channel_entity.dart';

class MatchTvChannelEntity extends Equatable {
  final String id;
  final TvChannelEntity tvChannel;

  const MatchTvChannelEntity({
    required this.id,
    required this.tvChannel,
  });

  @override
  List<Object?> get props => [id, tvChannel];
}
