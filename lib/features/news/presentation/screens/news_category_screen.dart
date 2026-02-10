import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/presentation/cubit/language_cubit.dart';
import '../../../../core/presentation/widgets/error_view.dart';
import '../../../../injection_container.dart';
import '../bloc/news_category/news_category_bloc.dart';
import '../bloc/news_category/news_category_event.dart';
import '../bloc/news_category/news_category_state.dart';
import '../widgets/add_news_category_dialog.dart';

class NewsCategoryScreen extends StatelessWidget {
  const NewsCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<NewsCategoryBloc>()..add(const GetNewsCategoriesEvent()),
      child: const NewsCategoryView(),
    );
  }
}

class NewsCategoryView extends StatefulWidget {
  const NewsCategoryView({super.key});

  @override
  State<NewsCategoryView> createState() => _NewsCategoryViewState();
}

class _NewsCategoryViewState extends State<NewsCategoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _refresh() {
    context.read<NewsCategoryBloc>().add(const GetNewsCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    final currentLocale = context.watch<LanguageCubit>().state.languageCode;

    // Responsive padding
    final responsivePadding = ResponsiveValue<double>(
      context,
      conditionalValues: [
        const Condition.smallerThan(name: 'MOBILE', value: 2.0),
        const Condition.smallerThan(name: 'TABLET', value: 8.0),
        const Condition.smallerThan(name: 'DESKTOP', value: 12.0),
      ],
      defaultValue: 16.0,
    ).value;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(responsivePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Title and Add Button
            Row(
              children: [
                Text(
                  'News Categories',
                  style: theme.textTheme.titleLarge,
                ),
                const Spacer(),
                SizedBox(
                  width: 38.0,
                  height: 38.0,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.2),
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<NewsCategoryBloc>(),
                          child: const AddNewsCategoryDialog(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.add,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        theme.colorScheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
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
                padding: EdgeInsets.all(isMobile ? 0.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // List Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Title',
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(color: theme.hintColor),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 48.0),
                            child: Text(
                              'Active',
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(color: theme.hintColor),
                            ),
                          ),
                          const SizedBox(width: 40), // Space for delete icon
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    // List
                    Expanded(
                      child: BlocBuilder<NewsCategoryBloc, NewsCategoryState>(
                        builder: (context, state) {
                          if (state is NewsCategoryLoading) {
                            return ListView.separated(
                              itemCount: 5,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (_, __) => SizedBox(
                                width: double.infinity,
                                height: 60.0,
                                child: Shimmer.fromColors(
                                  baseColor:
                                      theme.colorScheme.surfaceContainerHighest,
                                  highlightColor: theme.colorScheme.onSurface
                                      .withOpacity(0.1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (state is NewsCategoryError) {
                            return ErrorView(
                              message: state.message,
                              onRetry: _refresh,
                            );
                          } else if (state is NewsCategoryLoaded) {
                            if (state.categories.isEmpty) {
                              return Center(child: Text('No Data Found'));
                            }
                            return ReorderableListView.builder(
                              scrollController: _scrollController,
                              buildDefaultDragHandles: false,
                              padding: EdgeInsets.zero,
                              itemCount: state.categories.length,
                              onReorder: (oldIndex, newIndex) {
                                if (newIndex > oldIndex) newIndex -= 1;
                                // We need list of IDs in NEW order.
                                final ids =
                                    state.categories.map((c) => c.id).toList();
                                final movedId = ids.removeAt(oldIndex);
                                ids.insert(newIndex, movedId);

                                context.read<NewsCategoryBloc>().add(
                                      ReorderNewsCategoriesEvent(
                                        ids,
                                        oldIndex,
                                        newIndex,
                                      ),
                                    );
                              },
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                final title = category.title[currentLocale] ??
                                    category.title['en'] ??
                                    'Untitled';

                                return Container(
                                  key: ValueKey(category.id),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: theme.colorScheme.outline
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: ReorderableDragStartListener(
                                      index: index,
                                      child: Icon(
                                        Icons.drag_indicator,
                                        color: theme.hintColor,
                                      ),
                                    ),
                                    title: Text(title),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierColor:
                                            Colors.black.withOpacity(0.2),
                                        builder: (dialogContext) =>
                                            BlocProvider.value(
                                          value:
                                              context.read<NewsCategoryBloc>(),
                                          child: AddNewsCategoryDialog(
                                              category: category),
                                        ),
                                      );
                                    },
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Switch(
                                          value: category.isActive,
                                          onChanged: (value) {
                                            context
                                                .read<NewsCategoryBloc>()
                                                .add(
                                                  ToggleNewsCategoryStatusEvent(
                                                    category.id,
                                                    value,
                                                  ),
                                                );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          icon: SvgPicture.asset(
                                            AppIcons.trash,
                                            width: 20,
                                            colorFilter: ColorFilter.mode(
                                              theme.colorScheme.error,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<NewsCategoryBloc>()
                                                .add(
                                                  DeleteNewsCategoryEvent(
                                                      category.id),
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
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
    );
  }
}
