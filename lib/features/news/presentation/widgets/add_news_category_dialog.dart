import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/s.dart';
import '../bloc/news_category/news_category_bloc.dart';
import '../bloc/news_category/news_category_event.dart';

import '../../domain/entities/news_category.dart';

class AddNewsCategoryDialog extends StatefulWidget {
  final NewsCategory? category;

  const AddNewsCategoryDialog({super.key, this.category});

  @override
  State<AddNewsCategoryDialog> createState() => _AddNewsCategoryDialogState();
}

class _AddNewsCategoryDialogState extends State<AddNewsCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleEnController = TextEditingController();
  final _titleArController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _titleEnController.text = widget.category!.title['en'] ?? '';
      _titleArController.text = widget.category!.title['ar'] ?? '';
    }
  }

  @override
  void dispose() {
    _titleEnController.dispose();
    _titleArController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': {
          'en': _titleEnController.text,
          'ar': _titleArController.text,
        },
        'is_active': true,
      };

      if (widget.category != null) {
        context
            .read<NewsCategoryBloc>()
            .add(UpdateNewsCategoryEvent(widget.category!.id, body));
      } else {
        context.read<NewsCategoryBloc>().add(AddNewsCategoryEvent(body));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(widget.category != null
          ? 'Edit Category'
          : 'Add Category'), // Fallback if s.addCategory missing
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleEnController,
                decoration: InputDecoration(
                  labelText: 'Title (EN)',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required Field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleArController,
                decoration: InputDecoration(
                  labelText: 'Title (AR)',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required Field';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(widget.category != null ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
