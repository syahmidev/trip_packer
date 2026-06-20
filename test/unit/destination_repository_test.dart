import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/features/destinations/data/destination_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late DestinationRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = DestinationRepository(db);
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

  Future<List<Destination>> orderedFor(int tripId) {
    return (db.select(db.destinations)
          ..where((d) => d.tripId.equals(tripId))
          ..orderBy([(d) => OrderingTerm.asc(d.orderIndex)]))
        .get();
  }

  test('addDestination appends with an incrementing orderIndex', () async {
    final tripId = await seedTrip();

    await repo.addDestination(
        tripId: tripId, country: 'Turkey', city: 'Istanbul');
    await repo.addDestination(
        tripId: tripId, country: 'Bulgaria', city: 'Sofia');
    await repo.addDestination(
        tripId: tripId, country: 'North Macedonia', city: 'Skopje');

    final list = await orderedFor(tripId);
    expect(list.map((d) => d.city), ['Istanbul', 'Sofia', 'Skopje']);
    expect(list.map((d) => d.orderIndex), [0, 1, 2]);
  });

  test('persistOrder rewrites indices to match the new order', () async {
    final tripId = await seedTrip();
    await repo.addDestination(
        tripId: tripId, country: 'Turkey', city: 'Istanbul');
    await repo.addDestination(
        tripId: tripId, country: 'Bulgaria', city: 'Sofia');
    await repo.addDestination(
        tripId: tripId, country: 'North Macedonia', city: 'Skopje');

    final list = await orderedFor(tripId);
    // Move the last item (Skopje) to the front.
    final reordered = [list[2], list[0], list[1]];
    await repo.persistOrder(reordered);

    final result = await orderedFor(tripId);
    expect(result.map((d) => d.city), ['Skopje', 'Istanbul', 'Sofia']);
    expect(result.map((d) => d.orderIndex), [0, 1, 2]);
  });

  test('deleteDestination removes the row', () async {
    final tripId = await seedTrip();
    await repo.addDestination(
        tripId: tripId, country: 'Turkey', city: 'Istanbul');
    final list = await orderedFor(tripId);

    await repo.deleteDestination(list.first.id);

    expect(await orderedFor(tripId), isEmpty);
  });

  test('destinations cascade-delete with their trip', () async {
    final tripId = await seedTrip();
    await repo.addDestination(
        tripId: tripId, country: 'Turkey', city: 'Istanbul');

    await (db.delete(db.trips)..where((t) => t.id.equals(tripId))).go();

    expect(await orderedFor(tripId), isEmpty);
  });
}
