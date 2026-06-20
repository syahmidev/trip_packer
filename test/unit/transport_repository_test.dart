import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/features/transport/data/transport_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late TransportRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = TransportRepository(db);
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

  Future<int> addLeg(
    int tripId, {
    required String type,
    required String from,
    required String to,
    required DateTime departure,
  }) {
    return repo.addTransport(TransportsCompanion.insert(
      tripId: tripId,
      type: type,
      from: from,
      to: to,
      departureDateTime: departure,
    ));
  }

  test('legs are ordered by departure date/time', () async {
    final tripId = await seedTrip();
    await addLeg(tripId,
        type: 'Bus',
        from: 'Sofia',
        to: 'Skopje',
        departure: DateTime(2026, 7, 6, 18, 0));
    await addLeg(tripId,
        type: 'Flight',
        from: 'Istanbul',
        to: 'Sofia',
        departure: DateTime(2026, 7, 3, 9, 30));
    await addLeg(tripId,
        type: 'Train',
        from: 'Skopje',
        to: 'Prizren',
        departure: DateTime(2026, 7, 4, 14, 0));

    final legs = await repo.watchForTrip(tripId).first;
    expect(legs.map((l) => l.from), ['Istanbul', 'Skopje', 'Sofia']);
  });

  test('updateTransport persists changes', () async {
    final tripId = await seedTrip();
    final id = await addLeg(tripId,
        type: 'Bus',
        from: 'Sofia',
        to: 'Skopje',
        departure: DateTime(2026, 7, 6, 18, 0));
    final leg = await (db.select(db.transports)
          ..where((t) => t.id.equals(id)))
        .getSingle();

    await repo.updateTransport(leg.copyWith(cost: 45, type: 'Train'));

    final updated = await (db.select(db.transports)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    expect(updated.type, 'Train');
    expect(updated.cost, 45);
  });

  test('deleteTransport removes the leg', () async {
    final tripId = await seedTrip();
    final id = await addLeg(tripId,
        type: 'Bus',
        from: 'Sofia',
        to: 'Skopje',
        departure: DateTime(2026, 7, 6, 18, 0));

    await repo.deleteTransport(id);

    expect(await repo.watchForTrip(tripId).first, isEmpty);
  });

  test('transport cascade-deletes with its trip', () async {
    final tripId = await seedTrip();
    await addLeg(tripId,
        type: 'Bus',
        from: 'Sofia',
        to: 'Skopje',
        departure: DateTime(2026, 7, 6, 18, 0));

    await (db.delete(db.trips)..where((t) => t.id.equals(tripId))).go();

    expect(await repo.watchForTrip(tripId).first, isEmpty);
  });
}
