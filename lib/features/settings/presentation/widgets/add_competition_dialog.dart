import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart' as rf;

import '../../../../core/l10n/s.dart';
import '../../domain/entities/competition_search_entity.dart';
import '../bloc/competition_config_bloc.dart';
import '../bloc/competition_config_event.dart';
import 'competition_search_dropdown.dart';

class AddCompetitionDialog extends StatefulWidget {
  const AddCompetitionDialog({super.key});

  @override
  State<AddCompetitionDialog> createState() => _AddCompetitionDialogState();
}

class _AddCompetitionDialogState extends State<AddCompetitionDialog> {
  CompetitionSearchEntity? _selectedCompetition;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final _sizeInfo = rf.ResponsiveValue<_SizeInfo>(
      context,
      conditionalValues: [
        const rf.Condition.between(
          start: 0,
          end: 480,
          value: _SizeInfo(
            alertFontSize: 12,
            padding: EdgeInsets.all(16),
            innerSpacing: 16,
          ),
        ),
        const rf.Condition.between(
          start: 481,
          end: 576,
          value: _SizeInfo(
            alertFontSize: 14,
            padding: EdgeInsets.all(16),
            innerSpacing: 16,
          ),
        ),
        const rf.Condition.between(
          start: 577,
          end: 992,
          value: _SizeInfo(
            alertFontSize: 14,
            padding: EdgeInsets.all(16),
            innerSpacing: 16,
          ),
        ),
      ],
      defaultValue: const _SizeInfo(),
    ).value;
    TextTheme textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///---------------- header section
              DialogHeader(headerTitle: s.addNewCompetition),

              ///---------------- body section
              Padding(
                padding: EdgeInsets.all(_sizeInfo.innerSpacing),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 400, maxWidth: 610),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.competitionId, style: textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        CompetitionSearchDropdown(
                          onSelected: (competition) {
                            setState(() {
                              _selectedCompetition = competition;
                            });
                          },
                        ),
                        if (_selectedCompetition == null) // A simple validation display
                           Padding(
                             padding: const EdgeInsets.only(top: 4.0, left: 12),
                             child: Text(
                               '', // Can add validation text if form submission fails, but checking on submit
                               style: textTheme.bodySmall?.copyWith(color: Colors.red),
                             ),
                           ),
                        const SizedBox(height: 20),

                        ///---------------- Submit Button section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _sizeInfo.innerSpacing),
                                  backgroundColor:
                                      theme.colorScheme.primaryContainer,
                                  textStyle: textTheme.bodySmall
                                      ?.copyWith(color: Colors.red),
                                  side: const BorderSide(
                                      color: Colors.red)),
                              onPressed: () => Navigator.pop(context),
                              label: Text(
                                s.cancel,
                                style: textTheme.bodySmall
                                    ?.copyWith(color: Colors.red),
                              ),
                            ),
                            SizedBox(width: _sizeInfo.innerSpacing),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _sizeInfo.innerSpacing),
                              ),
                              onPressed: () {
                                if (_selectedCompetition != null) {
                                  context.read<CompetitionConfigBloc>().add(
                                    AddCompetitionConfigEvent(_selectedCompetition!.id),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  // Show validation error or snackbar? 
                                  // For now, maybe just nothing or a snackbar.
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(content: Text(s.pleaseEnterCompetitionId)),
                                   );
                                }
                              },
                              label: Text(s.save), 
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SizeInfo {
  final double? alertFontSize;
  final EdgeInsetsGeometry padding;
  final double innerSpacing;
  final double? fonstSize; // Merged from the second definition

  const _SizeInfo({
    this.alertFontSize = 18,
    this.padding = const EdgeInsets.all(24),
    this.innerSpacing = 24,
    this.fonstSize = 20, // Default value for DialogHeader usage
  });
}

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    super.key,
    this.headerTitle,
    this.richHeaderText,
    this.headerStyle,
    this.leading,
    this.headerPadding,
    this.decoration,
    this.onClose,
    this.showCloseButton = true,
    this.trailing,
    this.trailingConstraints,
  }) : assert(!showCloseButton || trailing == null);

  final String? headerTitle;
  final TextSpan? richHeaderText;
  final TextStyle? headerStyle;
  final Widget? leading;
  final EdgeInsetsGeometry? headerPadding;
  final BoxDecoration? decoration;

  final void Function()? onClose;
  final bool showCloseButton;
  final Widget? trailing;
  final BoxConstraints? trailingConstraints;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    final _sizeInfo = rf.ResponsiveValue<_SizeInfo>(
      context,
      conditionalValues: const [
        rf.Condition.between(
          start: 0,
          end: 350,
          value: _SizeInfo(
            fonstSize: 16,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        rf.Condition.between(
          start: 351,
          end: 410,
          value: _SizeInfo(
            fonstSize: 18,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        rf.Condition.between(
          start: 411,
          end: 675,
          value: _SizeInfo(
            fonstSize: 18,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
      defaultValue: const _SizeInfo(),
    ).value;

    return Container(
      decoration: (decoration ?? const BoxDecoration()).copyWith(
        border: decoration?.border == null
            ? Border(bottom: BorderSide(color: _theme.colorScheme.outline))
            : null,
      ),
      padding: headerPadding ?? _sizeInfo.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) leading!,
          if (headerTitle != null || richHeaderText != null)
            Expanded(
              child: Text.rich(
                richHeaderText ?? TextSpan(text: headerTitle),
                style: _theme.textTheme.titleLarge?.copyWith(
                  fontSize: _sizeInfo.fonstSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // Close Button
          if (showCloseButton)
            IconButton(
              onPressed: () {
                onClose?.call();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              color: _theme.colorScheme.error,
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(
                horizontal: -4,
                vertical: -4,
              ),
            )
          else if (trailing != null)
            ConstrainedBox(
              constraints: trailingConstraints ??
                  BoxConstraints.loose(
                    const Size.fromHeight(48),
                  ),
              child: trailing!,
            ),
        ],
      ),
    );
  }
}
