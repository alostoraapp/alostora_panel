import 'package:alostora/core/l10n/s.dart';
import 'package:alostora/features/matches/domain/entities/match_entity.dart';
import 'package:alostora/features/match_detail/presentation/widgets/match_detail_tab_bar.dart';
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
        title: Text(S.of(context).matchDetails),
      ),
      body: MatchDetailTabBar(
        theme: Theme.of(context),
        textTheme: Theme.of(context).textTheme,
        match: widget.match,
      ),
    );
  }
}
