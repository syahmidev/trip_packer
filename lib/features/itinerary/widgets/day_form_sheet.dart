import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/date_utils.dart';

/// Result returned from [DayFormSheet] when the user saves.
class DayFormResult {
  const DayFormResult({required this.date, required this.title, this.notes});

  final DateTime date;
  final String title;
  final String? notes;
}

/// Bottom-sheet form to add or edit an itinerary day (plan Phase 5).
class DayFormSheet extends StatefulWidget {
  const DayFormSheet({
    this.existing,
    this.initialDate,
    this.tripStart,
    this.tripEnd,
    super.key,
  });

  final ItineraryDay? existing;

  /// Date the picker opens on when adding (typically the trip's next open day).
  final DateTime? initialDate;

  /// Optional trip bounds; when set the date picker is limited to this range.
  final DateTime? tripStart;
  final DateTime? tripEnd;

  @override
  State<DayFormSheet> createState() => _DayFormSheetState();
}

class _DayFormSheetState extends State<DayFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _notesController;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existing?.title);
    _notesController = TextEditingController(text: widget.existing?.notes);
    final initial =
        widget.existing?.date ?? widget.initialDate ?? DateTime.now();
    _date = AppDateUtils.clamp(initial,
        min: widget.tripStart, max: widget.tripEnd);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: widget.tripStart ?? DateTime(_date.year - 2),
      lastDate: widget.tripEnd ?? DateTime(_date.year + 5),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final notes = _notesController.text.trim();
    Navigator.pop(
      context,
      DayFormResult(
        date: _date,
        title: _titleController.text.trim(),
        notes: notes.isEmpty ? null : notes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    final df = DateFormat('EEE, d MMM yyyy');

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
              isEdit ? 'Edit Day' : 'Add Day',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                ),
                child: Text(df.format(_date)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Sofia — old town & free walking tour',
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
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
              child: Text(isEdit ? 'Save Changes' : 'Add Day'),
            ),
          ],
        ),
      ),
    );
  }
}
