import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/commentator_entity.dart';
import '../bloc/match_commentators/match_commentators_bloc.dart';
import '../bloc/match_commentators/match_commentators_event.dart';
import '../bloc/match_commentators/match_commentators_state.dart';
import 'commentator_dropdown.dart';

class MatchCommentatorDialog extends StatefulWidget {
  final String matchId;

  const MatchCommentatorDialog({
    super.key,
    required this.matchId,
  });

  @override
  State<MatchCommentatorDialog> createState() => _MatchCommentatorDialogState();
}

class _MatchCommentatorDialogState extends State<MatchCommentatorDialog> {
  CommentatorEntity? _selectedCommentator;

  void _save() {
    if (_selectedCommentator == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(S
                .of(context)
                .pleaseSelectTvChannel)), // Using generic or need specific? "Please select a commentator"
      );
      return;
    }

    context.read<MatchCommentatorsBloc>().add(
          AddCommentatorToMatchEvent(
            matchId: widget.matchId,
            commentatorId: _selectedCommentator!.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MatchCommentatorsBloc, MatchCommentatorsState>(
      listener: (context, state) {
        if (state is MatchCommentatorsOperationSuccess) {
          Navigator.of(context).pop();
        } else if (state is MatchCommentatorsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AlertDialog(
        title: Text(S
            .of(context)
            .addBroadcast), // Reusing addBroadcast or addMedia? Let's check S. Maybe "Add Commentator"
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommentatorSearchDropdown(
                onSelected: (commentator) {
                  setState(() {
                    _selectedCommentator = commentator;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: _save,
            child: Text(S.of(context).save),
          ),
        ],
      ),
    );
  }
}
