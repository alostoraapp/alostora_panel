import '../../domain/entities/broadcast_entity.dart';
import 'tv_channel_model.dart';

class BroadcastModel extends BroadcastEntity {
  const BroadcastModel({
    required super.id,
    required super.matchId,
    required super.platformName,
    required super.url,
    required super.tvChannel,
    required super.createdAt,
  });

  factory BroadcastModel.fromJson(Map<String, dynamic> json) {
    return BroadcastModel(
      id: json['id'] ?? '',
      matchId: json['match'] ?? '',
      platformName: json['platform_name'] ?? '',
      url: json['url'] ?? '',
      tvChannel: TvChannelModel.fromJson(json['tv_channel'] ?? {}),
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'match': matchId,
      'platform_name': platformName,
      'url': url,
      'tv_channel': (tvChannel as TvChannelModel).toJson(),
      'created_at': createdAt,
    };
  }
}
