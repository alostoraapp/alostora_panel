import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/l10n/s.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/incident_entity.dart';
import '../../domain/entities/incident_enums.dart';
import '../bloc/match_incidents/match_incidents_bloc.dart';

enum _MatchPeriod { firstHalf, secondHalf, overtime, penalties }

class EventsTab extends StatelessWidget {
  final String matchId;

  const EventsTab({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<MatchIncidentsBloc>()..add(GetMatchIncidentsEvent(matchId)),
      child: BlocBuilder<MatchIncidentsBloc, MatchIncidentsState>(
        builder: (context, state) {
          if (state is MatchIncidentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchIncidentsError) {
            return Center(child: Text(state.message));
          } else if (state is MatchIncidentsLoaded) {
            if (state.incidents.isEmpty) {
              return Center(child: Text(S.of(context).noDataFound));
            }
            return _EventsList(incidents: state.incidents);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _EventsList extends StatelessWidget {
  final List<IncidentEntity> incidents;

  const _EventsList({required this.incidents});

  @override
  Widget build(BuildContext context) {
    // Sort incidents by time descending
    final sortedIncidents = List<IncidentEntity>.from(incidents)
      ..sort((a, b) => b.order.compareTo(a.order)); // Use order for splitting

    // Grouping logic
    final List<IncidentEntity> penalties = [];
    final List<IncidentEntity> overtime = [];
    final List<IncidentEntity> secondHalf = [];
    final List<IncidentEntity> firstHalf = [];

    // Markers
    // 26: overtimeIsOver
    // 12: end (End of Regular Time / Second Half)
    // 11: midfield (End of First Half / Start of Second Half)
    // 10: start (Start of First Half)

    // We iterate descending.
    // Everything before 'overtimeIsOver' (or end of penalties) is Penalties.
    // Between 'overtimeIsOver' and 'end' is Overtime.
    // Between 'end' and 'midfield' is Second Half.
    // Between 'midfield' and 'start' is First Half.

    // Note: The markers themselves should probably be excluded from the list display or used as headers?
    // The user wants cards for these periods.

    // Simple state machine based on markers encountered
    for (var incident in sortedIncidents) {
      if (incident.type == StatTypeChoices.penaltyKickEnded ||
          incident.type == StatTypeChoices.penaltyShootout) {
        // Part of penalties
        penalties.add(incident);
      } else if (incident.type == StatTypeChoices.overtimeIsOver) {
        // Separator
        continue;
      } else if (incident.type == StatTypeChoices.end) {
        // Separator between Overtime/Second Half
        continue;
      } else if (incident.type == StatTypeChoices.midfield) {
        // Separator between Second Half/First Half
        continue;
      } else if (incident.type == StatTypeChoices.start) {
        // Separator
        continue;
      } else {
        // Assign to current bucket based on time/logic?
        // Since we can't strictly rely on markers being present (e.g. live match),
        // we might need to use time or just the markers if they exist.
        // Let's try to use the markers as switch points.
      }
    }

    // Re-implementing with strict marker logic
    // We will iterate and switch lists when we hit a marker.
    // Default list is Penalties (if match ended in penalties) or Overtime or Second Half?
    // Safer to just bucket based on ranges if markers exist.

    // Let's try a different approach: Split the list by markers.

    List<IncidentEntity> currentList;

    // Determine the initial list based on the highest phase present
    if (sortedIncidents.any((e) => e.type == StatTypeChoices.overtimeIsOver)) {
      currentList = penalties;
    } else if (sortedIncidents.any((e) => e.type == StatTypeChoices.end)) {
      currentList = overtime;
    } else if (sortedIncidents.any((e) => e.type == StatTypeChoices.midfield)) {
      currentList = secondHalf;
    } else {
      currentList = firstHalf;
    }

    for (var incident in sortedIncidents) {
      if (incident.type == StatTypeChoices.overtimeIsOver) {
        currentList = overtime;
        continue;
      }
      if (incident.type == StatTypeChoices.end) {
        currentList = secondHalf;
        continue;
      }
      if (incident.type == StatTypeChoices.midfield) {
        currentList = firstHalf;
        continue;
      }
      if (incident.type == StatTypeChoices.start) {
        continue;
      }
      // Filter other markers
      if (incident.type == StatTypeChoices.penaltyKickEnded) continue;

      currentList.add(incident);
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (penalties.isNotEmpty)
                  _buildSection(context, S.of(context).penalties, penalties,
                      _MatchPeriod.penalties),
                if (overtime.isNotEmpty)
                  _buildSection(context, S.of(context).overtime, overtime,
                      _MatchPeriod.overtime),
                if (secondHalf.isNotEmpty)
                  _buildSection(context, S.of(context).secondHalf, secondHalf,
                      _MatchPeriod.secondHalf),
                if (firstHalf.isNotEmpty)
                  _buildSection(context, S.of(context).firstHalf, firstHalf,
                      _MatchPeriod.firstHalf),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title,
      List<IncidentEntity> incidents, _MatchPeriod period) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kNeutral700,
                    ),
              ),
            ),
            const Divider(),
            ...incidents.map((incident) =>
                _IncidentItem(incident: incident, period: period)),
          ],
        ),
      ),
    );
  }
}

class _IncidentItem extends StatelessWidget {
  final IncidentEntity incident;
  final _MatchPeriod period;

  const _IncidentItem({required this.incident, required this.period});

  @override
  Widget build(BuildContext context) {
    final isHome = incident.isHome;
    final hasMedia = incident.mediaUrl != null && incident.mediaUrl!.isNotEmpty;
    final primaryColor = Theme.of(context).primaryColor;

    Widget content = Row(
      mainAxisAlignment:
          isHome ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isHome) ...[
          _TimeDisplay(
              time: incident.time,
              addedTime: incident.addedTime,
              period: period),
          const SizedBox(width: 8),
          _IncidentIcon(type: incident.type),
          const SizedBox(width: 8),
          Expanded(child: _IncidentDetails(incident: incident, isHome: true)),
        ] else ...[
          Expanded(child: _IncidentDetails(incident: incident, isHome: false)),
          const SizedBox(width: 8),
          _IncidentIcon(type: incident.type),
          const SizedBox(width: 8),
          _TimeDisplay(
              time: incident.time,
              addedTime: incident.addedTime,
              period: period),
        ],
      ],
    );

    if (hasMedia) {
      content = Container(
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.05),
          border: Border.all(color: primaryColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            content,
            Positioned.fill(
              child: Center(
                child: Icon(Icons.play_circle_fill,
                    color: primaryColor.withOpacity(0.3), size: 32),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: content,
    );
  }
}

class _TimeDisplay extends StatelessWidget {
  final int time;
  final int? addedTime;
  final _MatchPeriod period;

  const _TimeDisplay(
      {required this.time, this.addedTime, required this.period});

  @override
  Widget build(BuildContext context) {
    String timeStr = '$time\'';

    // Custom time formatting logic
    if (period == _MatchPeriod.firstHalf && time > 45) {
      timeStr = '45+${time - 45}\'';
    } else if (period == _MatchPeriod.secondHalf && time > 90) {
      timeStr = '90+${time - 90}\'';
    } else if (addedTime != null && addedTime! > 0) {
      timeStr += '+$addedTime';
    }

    return SizedBox(
      width: 45, // Slightly wider for formatted time
      child: Text(
        timeStr,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.kNeutral600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _IncidentIcon extends StatelessWidget {
  final StatTypeChoices type;

  const _IncidentIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    Color color = AppColors.kNeutral500;
    Widget? customIcon;

    switch (type) {
      case StatTypeChoices.goal:
        icon = Icons.sports_soccer;
        color = Colors.green;
        break;
      case StatTypeChoices.corner:
        icon = Icons.rounded_corner;
        color = AppColors.kNeutral700;
        break;
      case StatTypeChoices.yellowCard:
        customIcon = _buildCard(AppColors.kGold);
        break;
      case StatTypeChoices.redCard:
        customIcon = _buildCard(AppColors.kError);
        break;
      case StatTypeChoices.offside:
        icon = Icons.flag;
        color = Colors.orange;
        break;
      case StatTypeChoices.freeKick:
        icon = Icons.gps_fixed;
        color = AppColors.kNeutral700;
        break;
      case StatTypeChoices.goalKick:
        icon = Icons.sports_football; // Placeholder
        color = AppColors.kNeutral700;
        break;
      case StatTypeChoices.penalty:
        // Goal frame
        customIcon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.crop_square, size: 24, color: Colors.grey),
            const Icon(Icons.circle, size: 10, color: Colors.green),
          ],
        );
        break;
      case StatTypeChoices.substitution:
        icon = Icons.compare_arrows;
        color = AppColors.kNeutral500;
        break;
      case StatTypeChoices.cardUpgradeConfirmed:
        customIcon = Stack(
          children: [
            _buildCard(AppColors.kGold),
            Positioned(
              left: 4,
              top: 4,
              child: _buildCard(AppColors.kError),
            ),
          ],
        );
        break;
      case StatTypeChoices.penaltyMissed:
        // Goal frame with red ball
        customIcon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.crop_square, size: 24, color: Colors.grey),
            const Icon(Icons.circle, size: 10, color: AppColors.kError),
          ],
        );
        break;
      case StatTypeChoices.ownGoal:
        icon = Icons.dangerous;
        color = AppColors.kError;
        break;
      case StatTypeChoices.varCheck:
        icon = Icons.tv;
        color = AppColors.kNeutral500;
        break;
      case StatTypeChoices.penaltyShootout:
        // Goal frame with green ball
        customIcon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.crop_square, size: 24, color: Colors.grey),
            const Icon(Icons.circle, size: 10, color: Colors.green),
          ],
        );
        break;
      case StatTypeChoices.penaltyMissedShootout:
        // Goal frame with red ball
        customIcon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.crop_square, size: 24, color: Colors.grey),
            const Icon(Icons.circle, size: 10, color: AppColors.kError),
          ],
        );
        break;
      default:
        icon = Icons.circle;
        color = Colors.grey;
    }

    if (customIcon != null) {
      return SizedBox(width: 20, height: 20, child: Center(child: customIcon));
    }
    return Icon(icon, color: color, size: 20);
  }

  Widget _buildCard(Color color) {
    return Container(
      width: 12,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
    );
  }
}

class _IncidentDetails extends StatelessWidget {
  final IncidentEntity incident;
  final bool isHome;

  const _IncidentDetails({required this.incident, required this.isHome});

  @override
  Widget build(BuildContext context) {
    final playerName =
        incident.player?.name ?? incident.player?.shortName ?? '';
    final assistName = incident.assist1?.name ?? incident.assist1?.shortName;
    final inPlayerName =
        incident.inPlayer?.name ?? incident.inPlayer?.shortName;
    final outPlayerName =
        incident.outPlayer?.name ?? incident.outPlayer?.shortName;

    final CrossAxisAlignment alignment =
        isHome ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final TextAlign textAlign = isHome ? TextAlign.start : TextAlign.end;

    final List<Widget> children = [];

    if (incident.type == StatTypeChoices.substitution) {
      // Removed "Substitution" text
      if (inPlayerName != null) {
        children.add(Text(
          'In: $inPlayerName',
          style: const TextStyle(color: Colors.green, fontSize: 12),
          textAlign: textAlign,
        ));
      }
      if (outPlayerName != null) {
        children.add(Text(
          'Out: $outPlayerName',
          style: const TextStyle(color: AppColors.kError, fontSize: 12),
          textAlign: textAlign,
        ));
      }
    } else {
      if (playerName.isNotEmpty) {
        children.add(Text(
          playerName,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: textAlign,
        ));
      }
      if (assistName != null) {
        children.add(Text(
          'Assist: $assistName',
          style: const TextStyle(fontSize: 12, color: AppColors.kNeutral600),
          textAlign: textAlign,
        ));
      }
      if (incident.type == StatTypeChoices.ownGoal) {
        children.add(Text(
          S.of(context).ownGoal,
          style: const TextStyle(fontSize: 12, color: AppColors.kError),
          textAlign: textAlign,
        ));
      }
      if (incident.type == StatTypeChoices.penaltyMissed) {
        children.add(Text(
          S.of(context).penaltyMissed,
          style: const TextStyle(fontSize: 12, color: AppColors.kError),
          textAlign: textAlign,
        ));
      }
      if (incident.type == StatTypeChoices.varCheck) {
        children.add(Text(
          S.of(context).varCheck,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: textAlign,
        ));
      }
    }

    return Column(
      crossAxisAlignment: alignment,
      children: children,
    );
  }
}
