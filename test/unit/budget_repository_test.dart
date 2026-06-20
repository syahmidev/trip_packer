import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/features/budget/data/budget_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late BudgetRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = BudgetRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> seedTrip() {
    return db.into(db.trips).insert(
          TripsCompanion.insert(
            title: 'Balkans Backpacking 2026',
            startDate: DateTime(2026, 7, 3),
            endDate: DateTime(2026, 7, 16),
            baseCurrency: 'MYR',
            estimatedBudget: const Value(7000),
          ),
        );
  }

  test('setPlanned inserts then updates the same category row', () async {
    final tripId = await seedTrip();

    await repo.setPlanned(tripId: tripId, category: 'Hostel', amount: 900);
    var cats = await repo.watchCategories(tripId).first;
    expect(cats.length, 1);
    expect(cats.single.plannedAmount, 900);

    // Setting again must update, not insert a second row.
    await repo.setPlanned(tripId: tripId, category: 'Hostel', amount: 1200);
    cats = await repo.watchCategories(tripId).first;
    expect(cats.length, 1);
    expect(cats.single.plannedAmount, 1200);
  });

  test('expenses stream is ordered newest first', () async {
    final tripId = await seedTrip();
    await repo.addExpense(ExpensesCompanion.insert(
      tripId: tripId,
      title: 'Old',
      category: 'Food',
      amount: 10,
      currency: 'MYR',
      date: DateTime(2026, 7, 3),
    ));
    await repo.addExpense(ExpensesCompanion.insert(
      tripId: tripId,
      title: 'New',
      category: 'Food',
      amount: 20,
      currency: 'MYR',
      date: DateTime(2026, 7, 10),
    ));

    final expenses = await repo.watchExpenses(tripId).first;
    expect(expenses.map((e) => e.title), ['New', 'Old']);
  });

  test('deleteExpense removes the row', () async {
    final tripId = await seedTrip();
    final id = await repo.addExpense(ExpensesCompanion.insert(
      tripId: tripId,
      title: 'Hostel',
      category: 'Hostel',
      amount: 90,
      currency: 'MYR',
      date: DateTime(2026, 7, 5),
    ));

    await repo.deleteExpense(id);

    expect(await repo.watchExpenses(tripId).first, isEmpty);
  });

  test('planned categories and expenses cascade-delete with the trip', () async {
    final tripId = await seedTrip();
    await repo.setPlanned(tripId: tripId, category: 'Food', amount: 300);
    await repo.addExpense(ExpensesCompanion.insert(
      tripId: tripId,
      title: 'Lunch',
      category: 'Food',
      amount: 12,
      currency: 'MYR',
      date: DateTime(2026, 7, 5),
    ));

    await (db.delete(db.trips)..where((t) => t.id.equals(tripId))).go();

    expect(await repo.watchCategories(tripId).first, isEmpty);
    expect(await repo.watchExpenses(tripId).first, isEmpty);
  });
}
