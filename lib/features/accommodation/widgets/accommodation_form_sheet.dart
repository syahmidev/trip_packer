import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/date_utils.dart';

/// Result returned from [AccommodationFormSheet] when the user saves.
class AccommodationFormResult {
  const AccommodationFormResult({
    required this.name,
    required this.city,
    required this.checkIn,
    required this.checkOut,
    required this.cost,
    this.bookingReference,
    this.notes,
  });

  final String name;
  final String city;
  final DateTime checkIn;
  final DateTime checkOut;
  final double cost;
  final String? bookingReference;
  final String? notes;
}

/// Bottom-sheet form to add or edit an accommodation booking (plan Phase 8).
class AccommodationFormSheet extends StatefulWidget {
  const AccommodationFormSheet({
    this.existing,
    this.initialDate,
    this.tripStart,
    this.tripEnd,
    super.key,
  });

  final Accommodation? existing;
  final DateTime? initialDate;

  /// Optional trip bounds; when set the check-in picker is limited to this range.
  final DateTime? tripStart;
  final DateTime? tripEnd;

  @override
  State<AccommodationFormSheet> createState() => _AccommodationFormSheetState();
}

class _AccommodationFormSheetState extends State<AccommodationFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _cityController;
  late final TextEditingController _costController;
  late final TextEditingController _refController;
  late final TextEditingController _notesController;

  late DateTime _checkIn;
  late DateTime _checkOut;

  @override
  void initState() {
    super.initState();
    final a = widget.existing;
    _nameController = TextEditingController(text: a?.name);
    _cityController = TextEditingController(text: a?.city);
    _costController =
        TextEditingController(text: a == null ? '' : _trim(a.cost));
    _refController = TextEditingController(text: a?.bookingReference);
    _notesController = TextEditingController(text: a?.notes);
    final base = widget.initialDate ?? DateTime.now();
    _checkIn = AppDateUtils.clamp(a?.checkIn ?? base,
        min: widget.tripStart, max: widget.tripEnd);
    _checkOut = a?.checkOut ?? _checkIn.add(const Duration(days: 1));
  }

  static String _trim(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _costController.dispose();
    _refController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickCheckIn() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkIn,
      firstDate: widget.tripStart ?? DateTime(_checkIn.year - 2),
      lastDate: widget.tripEnd ?? DateTime(_checkIn.year + 5),
    );
    if (picked == null) return;
    setState(() {
      _checkIn = picked;
      // Keep check-out strictly after check-in.
      if (!_checkOut.isAfter(_checkIn)) {
        _checkOut = _checkIn.add(const Duration(days: 1));
      }
    });
  }

  Future<void> _pickCheckOut() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkOut,
      firstDate: _checkIn.add(const Duration(days: 1)),
      lastDate: DateTime(_checkIn.year + 5),
    );
    if (picked != null) setState(() => _checkOut = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final ref = _refController.text.trim();
    final notes = _notesController.text.trim();
    Navigator.pop(
      context,
      AccommodationFormResult(
        name: _nameController.text.trim(),
        city: _cityController.text.trim(),
        checkIn: _checkIn,
        checkOut: _checkOut,
        cost: double.tryParse(_costController.text.trim()) ?? 0,
        bookingReference: ref.isEmpty ? null : ref,
        notes: notes.isEmpty ? null : notes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    final df = DateFormat('EEE, d MMM yyyy');
    final nights = _checkOut.difference(_checkIn).inDays;

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
                isEdit ? 'Edit Accommodation' : 'Add Accommodation',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Hostel Mostel',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'Sofia',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickCheckIn,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Check-in',
                          suffixIcon:
                              Icon(Icons.calendar_today_outlined, size: 18),
                        ),
                        child: Text(df.format(_checkIn)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: _pickCheckOut,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Check-out',
                          suffixIcon:
                              Icon(Icons.calendar_today_outlined, size: 18),
                        ),
                        child: Text(df.format(_checkOut)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '$nights night${nights == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Cost (optional)'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                decoration:
                    const InputDecoration(labelText: 'Notes (optional)'),
                maxLines: 2,
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _save,
                child: Text(isEdit ? 'Save Changes' : 'Add Accommodation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
