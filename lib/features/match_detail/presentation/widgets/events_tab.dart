import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/l10n/s.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/incident_entity.dart';
import '../../domain/entities/incident_enums.dart';
import '../bloc/match_incidents/match_incidents_bloc.dart';
import 'incident_media_dialog.dart';

// --- Data Structures ---

/// Represents a match period for grouping incidents.
enum _MatchPeriod { firstHalf, secondHalf, overtime, penalties }

/// A container for incidents grouped by match period.
class _GroupedIncidents {
  final List<IncidentEntity> firstHalf;
  final List<IncidentEntity> secondHalf;
  final List<IncidentEntity> overtime;
  final List<IncidentEntity> penalties;

  const _GroupedIncidents({
    this.firstHalf = const [],
    this.secondHalf = const [],
    this.overtime = const [],
    this.penalties = const [],
  });
}

// --- Logic ---

/// Groups a list of match incidents into distinct periods.
///
/// This function processes a raw list of incidents, filters out unwanted types,
/// and uses special "marker" incidents (like 'end' or 'midfield') to categorize
/// all other incidents into First Half, Second Half, Overtime, or Penalties.
_GroupedIncidents _groupIncidents(List<IncidentEntity> allIncidents) {
  // 1. Filter out non-displayable events and sort chronologically descending.
  final incidents = allIncidents
      .where((i) => i.type != StatTypeChoices.injuryTime)
      .toList()
    ..sort((a, b) => b.order.compareTo(a.order));

  final List<IncidentEntity> penalties = [];
  final List<IncidentEntity> overtime = [];
  final List<IncidentEntity> secondHalf = [];
  final List<IncidentEntity> firstHalf = [];

  // 2. Determine the starting period for the state machine.
  // We start from the latest part of the match and work backwards.
  var currentPeriod = _MatchPeriod.firstHalf;
  final endMarkerIndex =
      incidents.indexWhere((e) => e.type == StatTypeChoices.end);

  if (incidents.any((e) => e.type == StatTypeChoices.overtimeIsOver)) {
    currentPeriod = _MatchPeriod.penalties;
  } else if (endMarkerIndex != -1) {
    // If 'end' marker exists, check the next event to see if it's penalties or overtime.
    if (endMarkerIndex > 0) {
      final firstEventAfterEnd = incidents[endMarkerIndex - 1];
      if (firstEventAfterEnd.type == StatTypeChoices.penaltyShootout ||
          firstEventAfterEnd.type == StatTypeChoices.penaltyMissedShootout) {
        currentPeriod = _MatchPeriod.penalties;
      } else {
        currentPeriod = _MatchPeriod.overtime;
      }
    } else {
      // 'end' is the very last event, so we assume the next phase is overtime.
      currentPeriod = _MatchPeriod.overtime;
    }
  } else if (incidents.any((e) => e.type == StatTypeChoices.midfield)) {
    currentPeriod = _MatchPeriod.secondHalf;
  }

  // 3. Iterate through incidents and assign them to the correct period list.
  for (final incident in incidents) {
    // When a marker is hit, switch the state to the previous period.
    if (incident.type == StatTypeChoices.overtimeIsOver) {
      currentPeriod = _MatchPeriod.overtime;
      continue; // Do not add the marker itself to the list.
    }
    if (incident.type == StatTypeChoices.end) {
      currentPeriod = _MatchPeriod.secondHalf;
      continue;
    }
    if (incident.type == StatTypeChoices.midfield) {
      currentPeriod = _MatchPeriod.firstHalf;
      continue;
    }

    // Skip other non-displayable markers.
    const skippableMarkers = [
      StatTypeChoices.start,
      StatTypeChoices.penaltyKickEnded,
    ];
    if (skippableMarkers.contains(incident.type)) {
      continue;
    }

    // Add the incident to the list corresponding to the current state.
    switch (currentPeriod) {
      case _MatchPeriod.penalties:
        penalties.add(incident);
        break;
      case _MatchPeriod.overtime:
        overtime.add(incident);
        break;
      case _MatchPeriod.secondHalf:
        secondHalf.add(incident);
        break;
      case _MatchPeriod.firstHalf:
        firstHalf.add(incident);
        break;
    }
  }

  return _GroupedIncidents(
    firstHalf: firstHalf,
    secondHalf: secondHalf,
    overtime: overtime,
    penalties: penalties,
  );
}

// --- UI Widgets ---

/// The main widget for the "Events" tab, responsible for fetching data.
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
            return _EventsList(incidents: state.incidents, matchId: matchId);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// Displays the categorized list of match events.
class _EventsList extends StatefulWidget {
  final List<IncidentEntity> incidents;
  final String matchId;

  const _EventsList({required this.incidents, required this.matchId});

  @override
  State<_EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<_EventsList> {
  bool _showImportantOnly = false;

  @override
  Widget build(BuildContext context) {
    // Filter incidents if the switch is on.
    final filteredIncidents = _showImportantOnly
        ? widget.incidents.where((incident) {
            return incident.type != StatTypeChoices.substitution &&
                incident.type != StatTypeChoices.yellowCard;
          }).toList()
        : widget.incidents;

    final groupedIncidents = _groupIncidents(filteredIncidents);

    return Column(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 16, 0),
              child: Row(
                children: [
                  Text(S.of(context).importantEvents),
                  const SizedBox(width: 8),
                  Switch(
                    value: _showImportantOnly,
                    onChanged: (value) {
                      setState(() {
                        _showImportantOnly = value;
                      });
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context
                          .read<MatchIncidentsBloc>()
                          .add(GetMatchIncidentsEvent(widget.matchId));
                    },
                    tooltip: S.of(context).refresh,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (groupedIncidents.penalties.isNotEmpty)
                        _EventSection(
                          title: S.of(context).penalties,
                          incidents: groupedIncidents.penalties,
                          period: _MatchPeriod.penalties,
                        ),
                      if (groupedIncidents.overtime.isNotEmpty)
                        _EventSection(
                          title: S.of(context).overtime,
                          incidents: groupedIncidents.overtime,
                          period: _MatchPeriod.overtime,
                        ),
                      if (groupedIncidents.secondHalf.isNotEmpty)
                        _EventSection(
                          title: S.of(context).secondHalf,
                          incidents: groupedIncidents.secondHalf,
                          period: _MatchPeriod.secondHalf,
                        ),
                      if (groupedIncidents.firstHalf.isNotEmpty)
                        _EventSection(
                          title: S.of(context).firstHalf,
                          incidents: groupedIncidents.firstHalf,
                          period: _MatchPeriod.firstHalf,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A card that displays a section of events for a specific match period.
class _EventSection extends StatelessWidget {
  final String title;
  final List<IncidentEntity> incidents;
  final _MatchPeriod period;

  const _EventSection({
    required this.title,
    required this.incidents,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
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

/// Displays a single incident item in the event list.
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
        padding: const EdgeInsets.all(6),
        alignment: Alignment.center,
        child: Stack(
          children: [
            content,
            Center(
              child: Icon(Icons.play_circle_fill,
                  color: primaryColor.withOpacity(0.3), size: 32),
            ),
          ],
        ),
      );
    }

    final bloc = context.read<MatchIncidentsBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (dialogContext) => IncidentMediaDialog(
              incident: incident,
              onSave: (mediaUrl, mediaCover, videoTime) {
                try {
                  bloc.add(
                    UpdateIncidentMediaEvent(
                      matchId: incident.matchId,
                      incidentId: incident.id,
                      mediaUrl: mediaUrl,
                      mediaCover: mediaCover,
                      videoTime: videoTime,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error saving: $e')),
                  );
                }
              },
              onDelete: () {
                try {
                  bloc.add(
                    DeleteIncidentMediaEvent(
                      matchId: incident.matchId,
                      incidentId: incident.id,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting: $e')),
                  );
                }
              },
            ),
          );
        },
        child: content,
      ),
    );
  }
}

/// Displays the formatted time of an incident.
class _TimeDisplay extends StatelessWidget {
  final int time;
  final int? addedTime;
  final _MatchPeriod period;

  const _TimeDisplay(
      {required this.time, this.addedTime, required this.period});

  @override
  Widget build(BuildContext context) {
    String timeStr = '$time\'';

    // Custom time formatting for injury time at the end of a half.
    if (period == _MatchPeriod.firstHalf && time > 45) {
      timeStr = '45+${time - 45}\'';
    } else if (period == _MatchPeriod.secondHalf && time > 90) {
      timeStr = '90+${time - 90}\'';
    } else if (addedTime != null && addedTime! > 0) {
      timeStr += '+$addedTime';
    }

    return SizedBox(
      width: 45, // Fixed width for alignment.
      child: Text(
        timeStr,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.kNeutral600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Displays the appropriate icon for an incident type.
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
        icon = Icons.sports_football;
        color = AppColors.kNeutral700;
        break;
      case StatTypeChoices.penalty:
        customIcon = _buildPenaltyIcon(isMissed: false);
        break;
      case StatTypeChoices.substitution:
        icon = Icons.compare_arrows;
        color = AppColors.kNeutral500;
        break;
      case StatTypeChoices.cardUpgradeConfirmed:
        customIcon = _buildCardUpgradeIcon();
        break;
      case StatTypeChoices.penaltyMissed:
        customIcon = _buildPenaltyIcon(isMissed: true);
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
        customIcon = _buildPenaltyIcon(isMissed: false);
        break;
      case StatTypeChoices.penaltyMissedShootout:
        customIcon = _buildPenaltyIcon(isMissed: true);
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

  Widget _buildPenaltyIcon({required bool isMissed}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.crop_square, size: 24, color: Colors.grey),
        Icon(Icons.circle,
            size: 10, color: isMissed ? AppColors.kError : Colors.green),
      ],
    );
  }

  Widget _buildCardUpgradeIcon() {
    return Stack(
      children: [
        _buildCard(AppColors.kGold),
        Positioned(
          left: 4,
          top: 4,
          child: _buildCard(AppColors.kError),
        ),
      ],
    );
  }
}

/// Displays the details of an incident, like player names.
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

    final alignment =
        isHome ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final textAlign = isHome ? TextAlign.start : TextAlign.end;

    final List<Widget> children = [];

    if (incident.type == StatTypeChoices.substitution) {
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
