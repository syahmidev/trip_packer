import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/core/providers/database_provider.dart';
import 'package:trip_packer/core/utils/budget_calculator.dart';
import 'package:trip_packer/features/budget/providers/budget_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ProviderContainer container;
  late int tripId;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
    tripId = await db.into(db.trips).insert(TripsCompanion.insert(
          title: 'Balkans Backpacking 2026',
          startDate: DateTime(2026, 7, 3),
          endDate: DateTime(2026, 7, 16),
          baseCurrency: 'MYR',
          estimatedBudget: const Value(7000),
        ));
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('expenses and planned providers feed BudgetCalculator totals', () async {
    final repo = container.read(budgetRepositoryProvider);
    await repo.setPlanned(tripId: tripId, category: 'Hostel', amount: 900);
    await repo.setPlanned(tripId: tripId, category: 'Food', amount: 300);
    await repo.addExpense(ExpensesCompanion.insert(
      tripId: tripId,
      title: 'Hostel Sofia',
      category: 'Hostel',
      amount: 90,
      currency: 'MYR',
      date: DateTime(2026, 7, 5),
    ));
    await repo.addExpense(ExpensesCompanion.insert(
      tripId: tripId,
      title: 'Dinner',
      category: 'Food',
      amount: 10,
      currency: 'EUR',
      exchangeRate: const Value(5),
      date: DateTime(2026, 7, 5),
    ));

    final expenses = await container.read(expensesProvider(tripId).future);
    final categories =
        await container.read(budgetCategoriesProvider(tripId).future);

    expect(BudgetCalculator.totalPlanned(categories), 1200);
    expect(BudgetCalculator.totalSpent(expenses), 140); // 90 + (10 * 5)
    expect(BudgetCalculator.remaining(7000, expenses), 6860);
    expect(BudgetCalculator.spentByCategory(expenses)['Food'], 50);
  });
}
