import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/categories.dart';
import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/budget_calculator.dart';
import '../../trips/providers/trip_providers.dart';
import '../providers/budget_providers.dart';
import '../widgets/expense_form_sheet.dart';

/// Budget Module (plan Phase 6) — planned budget per category, multi-currency
/// expenses, and planned-vs-spent totals.
class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripProvider(tripId));
    final categoriesAsync = ref.watch(budgetCategoriesProvider(tripId));
    final expensesAsync = ref.watch(expensesProvider(tripId));

    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),
      body: tripAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (trip) {
          if (trip == null) {
            return const Center(child: Text('Trip not found.'));
          }
          final categories = categoriesAsync.valueOrNull ?? const [];
          final expenses = expensesAsync.valueOrNull ?? const [];
          final money = _money(trip.baseCurrency);

          final totalPlanned = BudgetCalculator.totalPlanned(categories);
          final totalSpent = BudgetCalculator.totalSpent(expenses);
          final remaining =
              BudgetCalculator.remaining(trip.estimatedBudget, expenses);
          final spentByCat = BudgetCalculator.spentByCategory(expenses);
          final plannedByCat = {
            for (final c in categories) c.category: c.plannedAmount,
          };

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              _SummaryCard(
                money: money,
                totalBudget: trip.estimatedBudget,
                totalPlanned: totalPlanned,
                totalSpent: totalSpent,
                remaining: remaining,
              ),
              const SizedBox(height: 24),
              _SectionHeader('Planned vs Spent'),
              const SizedBox(height: 8),
              _CategoryTable(
                money: money,
                plannedByCat: plannedByCat,
                spentByCat: spentByCat,
                onEditPlanned: (category) => _editPlanned(
                  context,
                  ref,
                  category: category,
                  current: plannedByCat[category] ?? 0,
                  baseCurrency: trip.baseCurrency,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _SectionHeader('Expenses')),
                  TextButton.icon(
                    onPressed: () => _addExpense(context, ref, trip),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (expenses.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No expenses recorded yet.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondaryText,
                          ),
                    ),
                  ),
                )
              else
                for (final e in expenses)
                  _ExpenseTile(
                    expense: e,
                    baseCurrency: trip.baseCurrency,
                    onEdit: () => _editExpense(context, ref, trip, e),
                    onDelete: () => _deleteExpense(context, ref, e),
                  ),
            ],
          );
        },
      ),
      floatingActionButton: tripAsync.maybeWhen(
        data: (trip) => trip == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () => _addExpense(context, ref, trip),
                icon: const Icon(Icons.add),
                label: const Text('Expense'),
              ),
        orElse: () => null,
      ),
    );
  }

  static NumberFormat _money(String currency) =>
      NumberFormat.currency(symbol: '$currency ', decimalDigits: 0);

  Future<void> _addExpense(
    BuildContext context,
    WidgetRef ref,
    Trip trip,
  ) async {
    final result = await showModalBottomSheet<ExpenseFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ExpenseFormSheet(
        baseCurrency: trip.baseCurrency,
        tripStart: trip.startDate,
        tripEnd: trip.endDate,
      ),
    );
    if (result == null) return;
    await ref.read(budgetRepositoryProvider).addExpense(
          ExpensesCompanion.insert(
            tripId: tripId,
            title: result.title,
            category: result.category,
            amount: result.amount,
            currency: result.currency,
            exchangeRate: Value(result.exchangeRate),
            date: result.date,
          ),
        );
  }

  Future<void> _editExpense(
    BuildContext context,
    WidgetRef ref,
    Trip trip,
    Expense expense,
  ) async {
    final result = await showModalBottomSheet<ExpenseFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ExpenseFormSheet(
        baseCurrency: trip.baseCurrency,
        existing: expense,
        tripStart: trip.startDate,
        tripEnd: trip.endDate,
      ),
    );
    if (result == null) return;
    await ref.read(budgetRepositoryProvider).updateExpense(
          expense.copyWith(
            title: result.title,
            category: result.category,
            amount: result.amount,
            currency: result.currency,
            exchangeRate: result.exchangeRate,
            date: result.date,
          ),
        );
  }

  Future<void> _deleteExpense(
    BuildContext context,
    WidgetRef ref,
    Expense expense,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete expense?'),
        content: Text('Remove "${expense.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(budgetRepositoryProvider).deleteExpense(expense.id);
  }

  Future<void> _editPlanned(
    BuildContext context,
    WidgetRef ref, {
    required String category,
    required double current,
    required String baseCurrency,
  }) async {
    final controller = TextEditingController(
      text: current == 0 ? '' : current.toStringAsFixed(0),
    );
    final amount = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Planned — $category'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Planned amount',
            prefixText: '$baseCurrency ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, double.tryParse(controller.text.trim()) ?? 0),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (amount == null) return;
    await ref.read(budgetRepositoryProvider).setPlanned(
          tripId: tripId,
          category: category,
          amount: amount,
        );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.money,
    required this.totalBudget,
    required this.totalPlanned,
    required this.totalSpent,
    required this.remaining,
  });

  final NumberFormat money;
  final double totalBudget;
  final double totalPlanned;
  final double totalSpent;
  final double remaining;

  @override
  Widget build(BuildContext context) {
    final overBudget = remaining < 0;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Remaining',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.secondaryText,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              money.format(remaining),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: overBudget ? AppColors.danger : AppColors.primaryAccent,
                  ),
            ),
            const Divider(height: 28, color: AppColors.border),
            _row(context, 'Total budget', money.format(totalBudget)),
            const SizedBox(height: 8),
            _row(context, 'Total planned', money.format(totalPlanned)),
            const SizedBox(height: 8),
            _row(context, 'Total spent', money.format(totalSpent)),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText,
              ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _CategoryTable extends StatelessWidget {
  const _CategoryTable({
    required this.money,
    required this.plannedByCat,
    required this.spentByCat,
    required this.onEditPlanned,
  });

  final NumberFormat money;
  final Map<String, double> plannedByCat;
  final Map<String, double> spentByCat;
  final ValueChanged<String> onEditPlanned;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Row(
                children: [
                  const Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Planned',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.secondaryText,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Spent',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.secondaryText,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            for (final category in AppCategories.expense)
              _CategoryRow(
                category: category,
                planned: plannedByCat[category] ?? 0,
                spent: spentByCat[category] ?? 0,
                money: money,
                onTap: () => onEditPlanned(category),
                isLast: category == AppCategories.expense.last,
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.category,
    required this.planned,
    required this.spent,
    required this.money,
    required this.onTap,
    required this.isLast,
  });

  final String category;
  final double planned;
  final double spent;
  final NumberFormat money;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final over = planned > 0 && spent > planned;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(category)),
            Expanded(
              flex: 2,
              child: Text(
                planned == 0 ? '—' : money.format(planned),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: planned == 0 ? AppColors.secondaryText : null,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                money.format(spent),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: over ? AppColors.danger : null,
                  fontWeight: over ? FontWeight.w700 : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  const _ExpenseTile({
    required this.expense,
    required this.baseCurrency,
    required this.onEdit,
    required this.onDelete,
  });

  final Expense expense;
  final String baseCurrency;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('d MMM');
    final base = BudgetCalculator.inBaseCurrency(expense);
    final baseText =
        NumberFormat.currency(symbol: '$baseCurrency ', decimalDigits: 2)
            .format(base);
    final isForeign = expense.currency != baseCurrency;
    final paidText = isForeign
        ? '${expense.currency} ${expense.amount.toStringAsFixed(2)}'
        : null;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.card,
      child: ListTile(
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${expense.category}  •  ${df.format(expense.date)}'
          '${paidText == null ? '' : '  •  paid $paidText'}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              baseText,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, size: 20),
              onSelected: (v) => v == 'edit' ? onEdit() : onDelete(),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
