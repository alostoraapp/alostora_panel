import '../../domain/entities/match_tv_channel_entity.dart';
import 'tv_channel_model.dart';

class MatchTvChannelModel extends MatchTvChannelEntity {
  const MatchTvChannelModel({
    required super.id,
    required super.tvChannel,
  });

  factory MatchTvChannelModel.fromJson(Map<String, dynamic> json) {
    return MatchTvChannelModel(
      id: json['id'] ?? '',
      tvChannel: TvChannelModel.fromJson(json['tv_channel'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tv_channel': (tvChannel as TvChannelModel).toJson(),
    };
  }
}
