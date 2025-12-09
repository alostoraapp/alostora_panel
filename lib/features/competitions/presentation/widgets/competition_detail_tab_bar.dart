import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/app_colors.dart';

import 'competition_detail_widgets.dart';

import '../bloc/competition_detail_bloc.dart';
import '../bloc/competition_detail_event.dart';
import '../bloc/competition_detail_state.dart';
import '../../domain/entities/competition_detail_entity.dart';

class CompetitionDetailTabBar extends StatefulWidget {
  const CompetitionDetailTabBar({super.key});

  @override
  State<CompetitionDetailTabBar> createState() =>
      _CompetitionDetailTabBarState();
}

class _CompetitionDetailTabBarState extends State<CompetitionDetailTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          splashBorderRadius: BorderRadius.circular(12),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColors.kPrimary600,
          indicatorWeight: 2.0,
          dividerColor: Theme.of(context).colorScheme.outline,
          unselectedLabelColor: Theme.of(context).colorScheme.onTertiary,
          tabs: const [
            Tab(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Details'))),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDetailsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsTab() {
    return BlocConsumer<CompetitionDetailBloc, CompetitionDetailState>(
      listener: (context, state) {
        if (state is CompetitionDetailUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Competition updated successfully')),
          );
          Navigator.of(context, rootNavigator: true).pop(); // Close dialog
        } else if (state is CompetitionDetailUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is CompetitionDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CompetitionDetailError) {
          return Center(child: Text(state.message));
        } else if (state is CompetitionDetailLoaded ||
            state is CompetitionDetailUpdated ||
            state is CompetitionDetailUpdating) {
          final competition = (state is CompetitionDetailLoaded)
              ? state.competition
              : (state is CompetitionDetailUpdated)
                  ? state.competition
                  : (state as CompetitionDetailUpdating).competition!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoCard(context, competition),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildInfoCard(
      BuildContext context, CompetitionDetailEntity competition) {
    return InfoCard(
      title: 'Competition Info',
      icon: Icons.info_outline,
      onTap: () => _showEditDialog(context, competition),
      children: [
        LabeledValue(label: 'Name', values: competition.name),
        LabeledValue(label: 'Short Name', values: competition.shortName),
      ],
    );
  }

  void _showEditDialog(
      BuildContext context, CompetitionDetailEntity competition) {
    showDialog(
      context: context,
      builder: (dialogContext) => EditCompetitionDialog(
        competition: competition,
        onSave: (body) {
          context.read<CompetitionDetailBloc>().add(
                UpdateCompetitionDetailEvent(
                  competitionId: competition.id,
                  body: body,
                ),
              );
        },
      ),
    );
  }
}
