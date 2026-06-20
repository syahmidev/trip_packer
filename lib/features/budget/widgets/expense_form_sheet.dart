import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/categories.dart';
import '../../../core/database/app_database.dart';

/// Result returned from [ExpenseFormSheet] when the user saves.
class ExpenseFormResult {
  const ExpenseFormResult({
    required this.title,
    required this.category,
    required this.amount,
    required this.currency,
    required this.exchangeRate,
    required this.date,
  });

  final String title;
  final String category;
  final double amount;
  final String currency;
  final double exchangeRate;
  final DateTime date;
}

/// Bottom-sheet form to add or edit an expense (plan Phase 6).
///
/// Expenses are recorded in the currency actually paid plus an exchange rate to
/// the trip's base currency. When the expense currency *is* the base currency
/// the rate is locked to 1.0 (plan §12).
class ExpenseFormSheet extends StatefulWidget {
  const ExpenseFormSheet({
    required this.baseCurrency,
    this.existing,
    super.key,
  });

  final String baseCurrency;
  final Expense? existing;

  @override
  State<ExpenseFormSheet> createState() => _ExpenseFormSheetState();
}

class _ExpenseFormSheetState extends State<ExpenseFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late final TextEditingController _rateController;

  late String _category;
  late String _currency;
  late DateTime _date;

  bool get _isBaseCurrency => _currency == widget.baseCurrency;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _titleController = TextEditingController(text: e?.title);
    _amountController =
        TextEditingController(text: e == null ? '' : _trim(e.amount));
    _rateController = TextEditingController(
      text: e == null ? '1.0' : _trim(e.exchangeRate),
    );
    _category = e?.category ?? AppCategories.expense.first;
    _currency = e?.currency ?? widget.baseCurrency;
    _date = e?.date ?? DateTime.now();
  }

  static String _trim(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _onCurrencyChanged(String? value) {
    if (value == null) return;
    setState(() {
      _currency = value;
      if (_isBaseCurrency) _rateController.text = '1.0';
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(_date.year - 2),
      lastDate: DateTime(_date.year + 5),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final rate = _isBaseCurrency
        ? 1.0
        : (double.tryParse(_rateController.text.trim()) ?? 1.0);
    Navigator.pop(
      context,
      ExpenseFormResult(
        title: _titleController.text.trim(),
        category: _category,
        amount: double.parse(_amountController.text.trim()),
        currency: _currency,
        exchangeRate: rate,
        date: _date,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    final df = DateFormat('d MMM yyyy');
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    final rate = double.tryParse(_rateController.text.trim()) ?? 1;
    final converted = amount * (_isBaseCurrency ? 1 : rate);

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
                isEdit ? 'Edit Expense' : 'Add Expense',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Hostel Sofia',
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: [
                  for (final c in AppCategories.expense)
                    DropdownMenuItem(value: c, child: Text(c)),
                ],
                onChanged: (v) => setState(() => _category = v ?? _category),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      onChanged: (_) => setState(() {}),
                      validator: (v) {
                        final n = double.tryParse((v ?? '').trim());
                        if (n == null) return 'Enter a number';
                        if (n < 0) return 'Must be 0 or more';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _currency,
                      decoration: const InputDecoration(labelText: 'Currency'),
                      items: [
                        for (final c in AppCategories.currencies)
                          DropdownMenuItem(value: c, child: Text(c)),
                      ],
                      onChanged: _onCurrencyChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rateController,
                enabled: !_isBaseCurrency,
                decoration: InputDecoration(
                  labelText: 'Exchange rate to ${widget.baseCurrency}',
                  helperText: _isBaseCurrency
                      ? 'Same as base currency — rate is 1.0'
                      : '1 $_currency = rate × ${widget.baseCurrency}',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  if (_isBaseCurrency) return null;
                  final n = double.tryParse((v ?? '').trim());
                  if (n == null) return 'Enter a number';
                  if (n <= 0) return 'Must be greater than 0';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Text(
                '= ${NumberFormat.currency(symbol: '${widget.baseCurrency} ', decimalDigits: 2).format(converted)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _save,
                child: Text(isEdit ? 'Save Changes' : 'Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
