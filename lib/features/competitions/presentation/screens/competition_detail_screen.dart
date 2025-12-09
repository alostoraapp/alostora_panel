import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/competition_detail_bloc.dart';
import '../bloc/competition_detail_event.dart';
import '../widgets/competition_detail_tab_bar.dart';

class CompetitionDetailScreen extends StatelessWidget {
  final String competitionId;

  const CompetitionDetailScreen({super.key, required this.competitionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CompetitionDetailBloc>()
        ..add(GetCompetitionDetailEvent(competitionId: competitionId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Competition Details'),
        ),
        body: const CompetitionDetailTabBar(),
      ),
    );
  }
}
