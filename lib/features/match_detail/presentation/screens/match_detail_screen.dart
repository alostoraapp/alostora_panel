import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../matches/domain/entities/match_entity.dart';
import '../bloc/match_detail/match_detail_bloc.dart';
import '../bloc/match_detail/match_detail_event.dart';
import '../bloc/match_detail/match_detail_state.dart';
import '../widgets/match_detail_tab_bar.dart';
import '../../../matches/presentation/widgets/match_tile.dart';
import 'package:flutter/material.dart';

class MatchDetailScreen extends StatefulWidget {
  final String matchId;
  final MatchEntity? match;

  const MatchDetailScreen({
    super.key,
    required this.matchId,
    this.match,
  });

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  late MatchEntity? _match;

  @override
  void initState() {
    super.initState();
    _match = widget.match;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<MatchDetailBloc>();
        if (_match == null) {
          bloc.add(GetMatchDetail(widget.matchId));
        }
        return bloc;
      },
      child: BlocBuilder<MatchDetailBloc, MatchDetailState>(
        builder: (context, state) {
          if (state is MatchDetailLoaded) {
            _match = state.match;
          }

          if (_match == null) {
            if (state is MatchDetailLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is MatchDetailError) {
              return Scaffold(
                body: Center(child: Text('Error: ${state.message}')),
              );
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: MatchTile(
                match: _match!,
                isInteractive: false,
              ),
              toolbarHeight: 70,
            ),
            body: MatchDetailTabBar(
              theme: Theme.of(context),
              textTheme: Theme.of(context).textTheme,
              match: _match!,
            ),
          );
        },
      ),
    );
  }
}
