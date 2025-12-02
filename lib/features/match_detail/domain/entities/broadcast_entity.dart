import 'package:equatable/equatable.dart';
import 'tv_channel_entity.dart';

class BroadcastEntity extends Equatable {
  final String id;
  final String matchId;
  final String platformName;
  final String url;
  final TvChannelEntity tvChannel;
  final String createdAt;

  const BroadcastEntity({
    required this.id,
    required this.matchId,
    required this.platformName,
    required this.url,
    required this.tvChannel,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, matchId, platformName, url, tvChannel, createdAt];
}
