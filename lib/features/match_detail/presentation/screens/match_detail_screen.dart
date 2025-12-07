import 'package:alostora/features/matches/domain/entities/match_entity.dart';
import 'package:alostora/features/match_detail/presentation/widgets/match_detail_tab_bar.dart';
import 'package:alostora/features/matches/presentation/widgets/match_tile.dart';
import 'package:flutter/material.dart';

class MatchDetailScreen extends StatefulWidget {
  final MatchEntity match;

  const MatchDetailScreen({super.key, required this.match});

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MatchTile(
          match: widget.match,
          isInteractive: false,
        ),
        toolbarHeight: 70, // Reduced height for compact MatchTile
      ),
      body: MatchDetailTabBar(
        theme: Theme.of(context),
        textTheme: Theme.of(context).textTheme,
        match: widget.match,
      ),
    );
  }
}
