import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';

/// Result returned from [ActivityFormSheet] when the user saves.
class ActivityFormResult {
  const ActivityFormResult({
    required this.title,
    this.location,
    this.time,
    this.estimatedCost,
    this.notes,
  });

  final String title;
  final String? location;
  final DateTime? time;
  final double? estimatedCost;
  final String? notes;
}

/// Bottom-sheet form to add or edit an activity (plan Phase 5).
///
/// Time-of-day is stored against the parent day's date so activities sort
/// chronologically (plan §12 note).
class ActivityFormSheet extends StatefulWidget {
  const ActivityFormSheet({required this.dayDate, this.existing, super.key});

  /// Date of the parent itinerary day — the chosen time is anchored to it.
  final DateTime dayDate;
  final Activity? existing;

  @override
  State<ActivityFormSheet> createState() => _ActivityFormSheetState();
}

class _ActivityFormSheetState extends State<ActivityFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _locationController;
  late final TextEditingController _costController;
  late final TextEditingController _notesController;
  TimeOfDay? _time;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _titleController = TextEditingController(text: existing?.title);
    _locationController = TextEditingController(text: existing?.location);
    _costController = TextEditingController(
      text: existing?.estimatedCost?.toString() ?? '',
    );
    _notesController = TextEditingController(text: existing?.notes);
    _time = existing?.time == null
        ? null
        : TimeOfDay.fromDateTime(existing!.time!);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _time = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    DateTime? time;
    if (_time != null) {
      final d = widget.dayDate;
      time = DateTime(d.year, d.month, d.day, _time!.hour, _time!.minute);
    }
    final location = _locationController.text.trim();
    final notes = _notesController.text.trim();
    final costText = _costController.text.trim();

    Navigator.pop(
      context,
      ActivityFormResult(
        title: _titleController.text.trim(),
        location: location.isEmpty ? null : location,
        time: time,
        estimatedCost: costText.isEmpty ? null : double.tryParse(costText),
        notes: notes.isEmpty ? null : notes,
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
              isEdit ? 'Edit Activity' : 'Add Activity',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Activity',
                hintText: 'Free walking tour',
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location (optional)',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickTime,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Time (optional)',
                  suffixIcon: _time == null
                      ? const Icon(Icons.schedule, size: 18)
                      : IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          tooltip: 'Clear time',
                          onPressed: () => setState(() => _time = null),
                        ),
                ),
                child: Text(_time == null ? 'All day' : _time!.format(context)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _costController,
              decoration: const InputDecoration(
                labelText: 'Estimated cost (optional)',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final n = double.tryParse(v.trim());
                if (n == null) return 'Enter a valid number';
                if (n < 0) return 'Must be 0 or more';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
              maxLines: 2,
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: _save,
              child: Text(isEdit ? 'Save Changes' : 'Add Activity'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shared time formatter for activity rows ("18:00" / "All day").
String formatActivityTime(BuildContext context, DateTime? time) {
  if (time == null) return 'All day';
  return DateFormat.Hm().format(time);
}
