import 'package:flutter/material.dart';

import '../widgets/match_detail_tab_bar.dart';

class MatchDetailScreen extends StatelessWidget {
  final String matchId;
  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Match ID: $matchId'),
      ),
      body: MatchDetailTabBar(
        theme: theme,
        textTheme: textTheme,
      ),
    );
  }
}
