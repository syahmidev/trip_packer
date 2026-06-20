import 'package:flutter/material.dart';

import '../../../core/constants/categories.dart';
import '../../../core/database/app_database.dart';

/// Result returned from [PackingFormSheet] when the user saves.
class PackingFormResult {
  const PackingFormResult({required this.title, required this.category});

  final String title;
  final String category;
}

/// Bottom-sheet form to add or edit a packing item (plan Phase 9).
class PackingFormSheet extends StatefulWidget {
  const PackingFormSheet({this.existing, this.initialCategory, super.key});

  final PackingItem? existing;

  /// Pre-selected category when adding (e.g. the currently filtered one).
  final String? initialCategory;

  @override
  State<PackingFormSheet> createState() => _PackingFormSheetState();
}

class _PackingFormSheetState extends State<PackingFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late String _category;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existing?.title);
    _category =
        widget.existing?.category ??
        widget.initialCategory ??
        AppCategories.packing.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      PackingFormResult(
        title: _titleController.text.trim(),
        category: _category,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEdit ? 'Edit Item' : 'Add Item',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Item',
                hintText: 'Passport',
              ),
              textCapitalization: TextCapitalization.sentences,
              onFieldSubmitted: (_) => _save(),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: [
                for (final c in AppCategories.packing)
                  DropdownMenuItem(value: c, child: Text(c)),
              ],
              onChanged: (v) => setState(() => _category = v ?? _category),
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: _save,
              child: Text(isEdit ? 'Save Changes' : 'Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
