import 'package:flutter/material.dart';
import '../../../../core/l10n/s.dart';

class TvChannelsTab extends StatelessWidget {
  final String matchId;

  const TvChannelsTab({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Center(
      child: Text(s.tvChannels),
    );
  }
}
