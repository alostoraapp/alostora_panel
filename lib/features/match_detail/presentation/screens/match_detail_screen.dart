import 'package:flutter/material.dart';

import '../../../matches/domain/entities/match_entity.dart';
import '../../../matches/presentation/widgets/match_tile.dart';
import '../widgets/match_detail_tab_bar.dart';

class MatchDetailScreen extends StatelessWidget {
  final MatchEntity match; // Changed from matchId to MatchEntity
  const MatchDetailScreen({super.key, required this.match}); // Updated constructor

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        // Replaced AppBar with MatchTile
        title: MatchTile(match: match),
        toolbarHeight: 74.0, // Adjust height as needed for MatchTile
        automaticallyImplyLeading: true, // Keep back button
      ),
      body: MatchDetailTabBar(
        theme: theme,
        textTheme: textTheme,
      ),
    );
  }
}
