import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Data-access for the Budget module (plan Phase 6).
///
/// Holds two concerns: the *planned* budget per category
/// ([BudgetCategory], one row per trip+category) and *actual* [Expense]s.
/// Planned-vs-actual math lives in `BudgetCalculator`.
class BudgetRepository {
  BudgetRepository(this._db);

  final AppDatabase _db;

  // --- Planned budget per category ---------------------------------------

  Stream<List<BudgetCategory>> watchCategories(int tripId) {
    return (_db.select(_db.budgetCategories)
          ..where((c) => c.tripId.equals(tripId))
          ..orderBy([(c) => OrderingTerm.asc(c.id)]))
        .watch();
  }

  /// Sets the planned amount for a category, inserting the row on first use and
  /// updating it thereafter (one planned row per trip+category).
  Future<void> setPlanned({
    required int tripId,
    required String category,
    required double amount,
  }) async {
    final existing =
        await (_db.select(_db.budgetCategories)..where(
              (c) => c.tripId.equals(tripId) & c.category.equals(category),
            ))
            .getSingleOrNull();

    if (existing == null) {
      await _db
          .into(_db.budgetCategories)
          .insert(
            BudgetCategoriesCompanion.insert(
              tripId: tripId,
              category: category,
              plannedAmount: Value(amount),
            ),
          );
    } else {
      await (_db.update(_db.budgetCategories)
            ..where((c) => c.id.equals(existing.id)))
          .write(BudgetCategoriesCompanion(plannedAmount: Value(amount)));
    }
  }

  // --- Expenses (actual spend) -------------------------------------------

  Stream<List<Expense>> watchExpenses(int tripId) {
    return (_db.select(_db.expenses)
          ..where((e) => e.tripId.equals(tripId))
          ..orderBy([(e) => OrderingTerm.desc(e.date)]))
        .watch();
  }

  Future<int> addExpense(ExpensesCompanion expense) {
    return _db.into(_db.expenses).insert(expense);
  }

  Future<bool> updateExpense(Expense expense) {
    return _db.update(_db.expenses).replace(expense);
  }

  Future<int> deleteExpense(int id) {
    return (_db.delete(_db.expenses)..where((e) => e.id.equals(id))).go();
  }
}
