import 'package:flutter/material.dart';

import '../../../matches/domain/entities/match_entity.dart';
import '../../../matches/presentation/widgets/match_tile.dart';
import '../widgets/match_detail_tab_bar.dart';

class MatchDetailScreen extends StatelessWidget {
  final MatchEntity match;
  const MatchDetailScreen({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: MatchTile(match: match),
        toolbarHeight: 74.0,
        automaticallyImplyLeading: true,
      ),
      body: MatchDetailTabBar(
        theme: theme,
        textTheme: textTheme,
        match: match,
      ),
    );
  }
}
