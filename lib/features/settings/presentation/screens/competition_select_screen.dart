import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/l10n/s.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../injection_container.dart';
import '../bloc/competition_config_bloc.dart';
import '../bloc/competition_config_event.dart';
import '../bloc/competition_config_state.dart';
import '../widgets/add_competition_dialog.dart';
import '../widgets/competition_config_item.dart';

class CompetitionSelectScreen extends StatelessWidget {
  const CompetitionSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CompetitionConfigBloc>()..add(const GetCompetitionConfigsEvent()),
      child: const CompetitionSelectView(),
    );
  }
}

class CompetitionSelectView extends StatefulWidget {
  const CompetitionSelectView({super.key});

  @override
  State<CompetitionSelectView> createState() => _CompetitionSelectViewState();
}

class _CompetitionSelectViewState extends State<CompetitionSelectView> {
  late final TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CompetitionConfigBloc>().add(
        SearchCompetitionConfigsEvent(_searchController.text),
      );
    });
  }

  void _refreshConfigs() {
    if (_searchController.text.isNotEmpty) {
      context.read<CompetitionConfigBloc>().add(
        SearchCompetitionConfigsEvent(_searchController.text),
      );
    } else {
      context.read<CompetitionConfigBloc>().add(const GetCompetitionConfigsEvent());
    }
  }


  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    // Responsive padding calculation (halved for mobile)
    final responsivePadding = ResponsiveValue<double>(
      context,
      conditionalValues: [
        const Condition.smallerThan(name: 'TABLET', value: 8.0),
        const Condition.smallerThan(name: 'DESKTOP', value: 16.0),
      ],
      defaultValue: 24.0,
    ).value;

    return BlocListener<LanguageCubit, Locale>(
      listener: (context, locale) {
        _refreshConfigs();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(responsivePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.competitionSelect,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveValue<double>(
                        context,
                        conditionalValues: [
                          const Condition.smallerThan(name: 'TABLET', value: 20.0),
                        ],
                        defaultValue: 24.0,
                      ).value,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.2),
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<CompetitionConfigBloc>(),
                          child: const AddCompetitionDialog(),
                        ),
                      );
                    },
                    icon: SvgPicture.asset(
                      AppIcons.add,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        theme.colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsivePadding),
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '${s.search}...',
                  prefixIcon: Icon(Icons.search, size: 20, color: theme.hintColor),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: responsivePadding),
              // Content Container
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header inside card
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              s.competitionSelect,
                              style: theme.textTheme.titleSmall?.copyWith(color: theme.hintColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 48.0),
                            child: Text(
                              s.active,
                              style: theme.textTheme.titleSmall?.copyWith(color: theme.hintColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      // List
                      Expanded(
                        child: BlocBuilder<CompetitionConfigBloc, CompetitionConfigState>(
                          builder: (context, state) {
                            if (state is CompetitionConfigLoading) {
                              return ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: 8,
                                  itemBuilder: (context, index) => const _ShimmerCompetitionItem(),
                                ),
                              );
                            } else if (state is CompetitionConfigError) {
                              return Center(child: Text(state.message));
                            } else if (state is CompetitionConfigLoaded) {
                              return ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                child: ReorderableListView.builder(
                                  scrollController: _scrollController,
                                  buildDefaultDragHandles: false,
                                  padding: EdgeInsets.zero,
                                  itemCount: state.configs.length,
                                  onReorder: (oldIndex, newIndex) {
                                    context.read<CompetitionConfigBloc>().add(
                                      ReorderCompetitionConfigsEvent(
                                        state.configs.map((e) => e.id).toList(),
                                        oldIndex,
                                        newIndex,
                                      ),
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    final config = state.configs[index];
                                    return CompetitionConfigItem(
                                      key: ValueKey(config.id),
                                      config: config,
                                      index: index,
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerCompetitionItem extends StatelessWidget {
  const _ShimmerCompetitionItem();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
      ),
      child: Shimmer.fromColors(
        baseColor: theme.colorScheme.surfaceContainerHighest,
        highlightColor: theme.colorScheme.onSurface.withOpacity(0.1),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 150, height: 14, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(width: 80, height: 10, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(width: 30, height: 20, color: Colors.white),
            const SizedBox(width: 12),
            Container(width: 20, height: 20, color: Colors.white),
          ],
        ),
      ),
    );
  }
}