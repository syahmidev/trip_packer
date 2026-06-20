import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/features/packing/data/packing_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late PackingRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = PackingRepository(db);
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
          ),
        );
  }

  test('items are ordered by category then title', () async {
    final tripId = await seedTrip();
    await repo.addItem(tripId: tripId, title: 'Passport', category: 'Documents');
    await repo.addItem(tripId: tripId, title: 'Socks', category: 'Clothes');
    await repo.addItem(tripId: tripId, title: 'Jacket', category: 'Clothes');

    final items = await repo.watchForTrip(tripId).first;
    expect(
      items.map((i) => '${i.category}/${i.title}'),
      ['Clothes/Jacket', 'Clothes/Socks', 'Documents/Passport'],
    );
  });

  test('new items default to unpacked', () async {
    final tripId = await seedTrip();
    await repo.addItem(tripId: tripId, title: 'Passport', category: 'Documents');

    final item = (await repo.watchForTrip(tripId).first).single;
    expect(item.isPacked, isFalse);
  });

  test('setPacked toggles the packed flag', () async {
    final tripId = await seedTrip();
    final id =
        await repo.addItem(tripId: tripId, title: 'Passport', category: 'Documents');

    await repo.setPacked(id, true);
    expect((await repo.watchForTrip(tripId).first).single.isPacked, isTrue);

    await repo.setPacked(id, false);
    expect((await repo.watchForTrip(tripId).first).single.isPacked, isFalse);
  });

  test('deleteItem removes the item', () async {
    final tripId = await seedTrip();
    final id =
        await repo.addItem(tripId: tripId, title: 'Passport', category: 'Documents');

    await repo.deleteItem(id);

    expect(await repo.watchForTrip(tripId).first, isEmpty);
  });

  test('packing items cascade-delete with their trip', () async {
    final tripId = await seedTrip();
    await repo.addItem(tripId: tripId, title: 'Passport', category: 'Documents');

    await (db.delete(db.trips)..where((t) => t.id.equals(tripId))).go();

    expect(await repo.watchForTrip(tripId).first, isEmpty);
  });
}
