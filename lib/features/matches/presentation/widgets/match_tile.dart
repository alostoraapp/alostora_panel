
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MatchTile extends StatefulWidget {
  final String homeTeam;
  final String awayTeam;
  final String homeScore;
  final String awayScore;
  final String status;
  final String homeTeamLogo;
  final String awayTeamLogo;

  const MatchTile({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
  });

  @override
  State<MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: _isHovering ? 4 : 1,
        shadowColor: _isHovering ? theme.colorScheme.primary.withOpacity(0.3) : Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: _isHovering ? theme.colorScheme.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeam(theme, name: widget.homeTeam, logoUrl: widget.homeTeamLogo),
              _buildScore(theme, homeScore: widget.homeScore, awayScore: widget.awayScore, status: widget.status),
              _buildTeam(theme, name: widget.awayTeam, logoUrl: widget.awayTeamLogo, isReversed: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeam(ThemeData theme, {required String name, required String logoUrl, bool isReversed = false}) {
    final logo = CachedNetworkImage(
      imageUrl: logoUrl,
      width: 32,
      height: 32,
      placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2.0),
      errorWidget: (context, url, error) => const Icon(Icons.shield, size: 32, color: Colors.grey),
    );

    final text = Text(name, style: theme.textTheme.titleMedium, overflow: TextOverflow.ellipsis);

    return Expanded(
      flex: 3,
      child: isReversed
          ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [Expanded(child: Align(alignment: Alignment.centerRight, child: text)), const SizedBox(width: 6), logo])
          : Row(children: [logo, const SizedBox(width: 6), Expanded(child: text)]),
    );
  }

  Widget _buildScore(ThemeData theme, {required String homeScore, required String awayScore, required String status}) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$homeScore - $awayScore',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}
