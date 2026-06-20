import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';

/// Result returned from [DestinationFormSheet] when the user saves.
class DestinationFormResult {
  const DestinationFormResult({required this.country, required this.city});

  final String country;
  final String city;
}

/// Bottom-sheet form to add or edit a destination (plan Phase 4).
class DestinationFormSheet extends StatefulWidget {
  const DestinationFormSheet({this.existing, super.key});

  /// When non-null the sheet is in edit mode and pre-fills the fields.
  final Destination? existing;

  @override
  State<DestinationFormSheet> createState() => _DestinationFormSheetState();
}

class _DestinationFormSheetState extends State<DestinationFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _countryController;
  late final TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController(text: widget.existing?.country);
    _cityController = TextEditingController(text: widget.existing?.city);
  }

  @override
  void dispose() {
    _countryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      DestinationFormResult(
        country: _countryController.text.trim(),
        city: _cityController.text.trim(),
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
              isEdit ? 'Edit Destination' : 'Add Destination',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _cityController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'City',
                hintText: 'Istanbul',
              ),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Country',
                hintText: 'Turkey',
              ),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: _save,
              child: Text(isEdit ? 'Save Changes' : 'Add Destination'),
            ),
          ],
        ),
      ),
    );
  }
}
