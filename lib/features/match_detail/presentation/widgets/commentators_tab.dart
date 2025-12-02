import 'package:flutter/material.dart';
import '../../../../core/l10n/s.dart';

class CommentatorsTab extends StatelessWidget {
  final String matchId;

  const CommentatorsTab({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Center(
      child: Text(s.commentators),
    );
  }
}
