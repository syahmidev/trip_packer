import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../data/budget_repository.dart';

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepository(ref.watch(databaseProvider));
});

/// Streams the planned budget categories for a trip.
final budgetCategoriesProvider =
    StreamProvider.family<List<BudgetCategory>, int>((ref, tripId) {
      return ref.watch(budgetRepositoryProvider).watchCategories(tripId);
    });

/// Streams the trip's expenses, newest first.
final expensesProvider = StreamProvider.family<List<Expense>, int>((
  ref,
  tripId,
) {
  return ref.watch(budgetRepositoryProvider).watchExpenses(tripId);
});
