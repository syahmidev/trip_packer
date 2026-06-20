import '../database/app_database.dart';

/// Pure budget math (plan §15). Kept free of Flutter/Drift IO so it is easy to
/// unit-test (plan Phase 10).
abstract final class BudgetCalculator {
  /// Converts an expense to the trip's base currency.
  static double inBaseCurrency(Expense e) => e.amount * e.exchangeRate;

  /// Total actually spent, summed in base currency across mixed currencies.
  static double totalSpent(Iterable<Expense> expenses) =>
      expenses.fold(0, (sum, e) => sum + inBaseCurrency(e));

  /// Total planned across all budget categories.
  static double totalPlanned(Iterable<BudgetCategory> categories) =>
      categories.fold(0, (sum, c) => sum + c.plannedAmount);

  /// Remaining against the trip's estimated budget.
  static double remaining(double estimatedBudget, Iterable<Expense> expenses) =>
      estimatedBudget - totalSpent(expenses);

  /// Spent per category (base currency), keyed by category name.
  static Map<String, double> spentByCategory(Iterable<Expense> expenses) {
    final map = <String, double>{};
    for (final e in expenses) {
      map[e.category] = (map[e.category] ?? 0) + inBaseCurrency(e);
    }
    return map;
  }
}
