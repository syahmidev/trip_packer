import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/categories.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/date_utils.dart';

/// Result returned from [TransportFormSheet] when the user saves.
class TransportFormResult {
  const TransportFormResult({
    required this.type,
    required this.from,
    required this.to,
    required this.departure,
    this.arrival,
    required this.cost,
    this.bookingReference,
    this.notes,
  });

  final String type;
  final String from;
  final String to;
  final DateTime departure;
  final DateTime? arrival;
  final double cost;
  final String? bookingReference;
  final String? notes;
}

/// Bottom-sheet form to add or edit a transport leg (plan Phase 7).
class TransportFormSheet extends StatefulWidget {
  const TransportFormSheet({
    this.existing,
    this.initialDate,
    this.tripStart,
    this.tripEnd,
    super.key,
  });

  final Transport? existing;
  final DateTime? initialDate;

  /// Optional trip bounds; when set the date pickers are limited to this range.
  final DateTime? tripStart;
  final DateTime? tripEnd;

  @override
  State<TransportFormSheet> createState() => _TransportFormSheetState();
}

class _TransportFormSheetState extends State<TransportFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fromController;
  late final TextEditingController _toController;
  late final TextEditingController _costController;
  late final TextEditingController _refController;
  late final TextEditingController _notesController;

  late String _type;
  late DateTime _departure;
  DateTime? _arrival;

  @override
  void initState() {
    super.initState();
    final t = widget.existing;
    _fromController = TextEditingController(text: t?.from);
    _toController = TextEditingController(text: t?.to);
    _costController = TextEditingController(
      text: t == null ? '' : _trim(t.cost),
    );
    _refController = TextEditingController(text: t?.bookingReference);
    _notesController = TextEditingController(text: t?.notes);
    _type = t?.type ?? AppCategories.transportTypes.first;
    final departure =
        t?.departureDateTime ??
        widget.initialDate ??
        DateTime.now().copyWith(
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
    _departure = AppDateUtils.clamp(
      departure,
      min: widget.tripStart,
      max: widget.tripEnd,
    );
    _arrival = t?.arrivalDateTime;
  }

  static String _trim(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _costController.dispose();
    _refController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDateTime(DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: AppDateUtils.clamp(
        initial,
        min: widget.tripStart,
        max: widget.tripEnd,
      ),
      firstDate: widget.tripStart ?? DateTime(initial.year - 2),
      lastDate: widget.tripEnd ?? DateTime(initial.year + 5),
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (_arrival != null && _arrival!.isBefore(_departure)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Arrival must be after departure.')),
      );
      return;
    }
    final ref = _refController.text.trim();
    final notes = _notesController.text.trim();
    Navigator.pop(
      context,
      TransportFormResult(
        type: _type,
        from: _fromController.text.trim(),
        to: _toController.text.trim(),
        departure: _departure,
        arrival: _arrival,
        cost: double.tryParse(_costController.text.trim()) ?? 0,
        bookingReference: ref.isEmpty ? null : ref,
        notes: notes.isEmpty ? null : notes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    final df = DateFormat('EEE, d MMM • HH:mm');

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEdit ? 'Edit Transport' : 'Add Transport',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: [
                  for (final t in AppCategories.transportTypes)
                    DropdownMenuItem(value: t, child: Text(t)),
                ],
                onChanged: (v) => setState(() => _type = v ?? _type),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fromController,
                      decoration: const InputDecoration(
                        labelText: 'From',
                        hintText: 'Sofia',
                      ),
                      textCapitalization: TextCapitalization.words,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _toController,
                      decoration: const InputDecoration(
                        labelText: 'To',
                        hintText: 'Skopje',
                      ),
                      textCapitalization: TextCapitalization.words,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final picked = await _pickDateTime(_departure);
                  if (picked != null) setState(() => _departure = picked);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Departure',
                    suffixIcon: Icon(Icons.schedule, size: 18),
                  ),
                  child: Text(df.format(_departure)),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final picked = await _pickDateTime(_arrival ?? _departure);
                  if (picked != null) setState(() => _arrival = picked);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Arrival (optional)',
                    suffixIcon: _arrival == null
                        ? const Icon(Icons.schedule, size: 18)
                        : IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            tooltip: 'Clear arrival',
                            onPressed: () => setState(() => _arrival = null),
                          ),
                  ),
                  child: Text(
                    _arrival == null ? 'Not set' : df.format(_arrival!),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Cost (optional)'),
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
                controller: _refController,
                decoration: const InputDecoration(
                  labelText: 'Booking reference (optional)',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _save,
                child: Text(isEdit ? 'Save Changes' : 'Add Transport'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
