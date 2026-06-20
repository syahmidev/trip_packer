import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
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

  test('insert and read back a trip', () async {
    final id = await seedTrip();
    final trip = await (db.select(db.trips)..where((t) => t.id.equals(id)))
        .getSingle();
    expect(trip.title, 'Balkans Backpacking 2026');
    expect(trip.baseCurrency, 'MYR');
  });

  test('deleting a trip cascades to child rows', () async {
    final tripId = await seedTrip();

    await db.into(db.expenses).insert(
          ExpensesCompanion.insert(
            tripId: tripId,
            title: 'Hostel Sofia',
            category: 'Hostel',
            amount: 90,
            currency: 'MYR',
            date: DateTime(2026, 7, 5),
          ),
        );
    await db.into(db.packingItems).insert(
          PackingItemsCompanion.insert(
            tripId: tripId,
            title: 'Passport',
            category: 'Documents',
          ),
        );

    expect((await db.select(db.expenses).get()).length, 1);
    expect((await db.select(db.packingItems).get()).length, 1);

    await (db.delete(db.trips)..where((t) => t.id.equals(tripId))).go();

    // Cascade must have removed all children (PRAGMA foreign_keys = ON).
    expect((await db.select(db.expenses).get()), isEmpty);
    expect((await db.select(db.packingItems).get()), isEmpty);
  });
}
