import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/features/accommodation/data/accommodation_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late AccommodationRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = AccommodationRepository(db);
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

  Future<int> addStay(
    int tripId, {
    required String name,
    required String city,
    required DateTime checkIn,
    required DateTime checkOut,
  }) {
    return repo.addAccommodation(AccommodationsCompanion.insert(
      tripId: tripId,
      name: name,
      city: city,
      checkIn: checkIn,
      checkOut: checkOut,
    ));
  }

  test('stays are ordered by check-in date', () async {
    final tripId = await seedTrip();
    await addStay(tripId,
        name: 'Hostel Skopje',
        city: 'Skopje',
        checkIn: DateTime(2026, 7, 6),
        checkOut: DateTime(2026, 7, 8));
    await addStay(tripId,
        name: 'Hostel Mostel',
        city: 'Sofia',
        checkIn: DateTime(2026, 7, 3),
        checkOut: DateTime(2026, 7, 6));

    final stays = await repo.watchForTrip(tripId).first;
    expect(stays.map((s) => s.city), ['Sofia', 'Skopje']);
  });

  test('updateAccommodation persists changes', () async {
    final tripId = await seedTrip();
    final id = await addStay(tripId,
        name: 'Hostel Mostel',
        city: 'Sofia',
        checkIn: DateTime(2026, 7, 3),
        checkOut: DateTime(2026, 7, 6));
    final stay = await (db.select(db.accommodations)
          ..where((a) => a.id.equals(id)))
        .getSingle();

    await repo.updateAccommodation(stay.copyWith(cost: 135, city: 'Plovdiv'));

    final updated = await (db.select(db.accommodations)
          ..where((a) => a.id.equals(id)))
        .getSingle();
    expect(updated.city, 'Plovdiv');
    expect(updated.cost, 135);
  });

  test('deleteAccommodation removes the stay', () async {
    final tripId = await seedTrip();
    final id = await addStay(tripId,
        name: 'Hostel Mostel',
        city: 'Sofia',
        checkIn: DateTime(2026, 7, 3),
        checkOut: DateTime(2026, 7, 6));

    await repo.deleteAccommodation(id);

    expect(await repo.watchForTrip(tripId).first, isEmpty);
  });

  test('accommodation cascade-deletes with its trip', () async {
    final tripId = await seedTrip();
    await addStay(tripId,
        name: 'Hostel Mostel',
        city: 'Sofia',
        checkIn: DateTime(2026, 7, 3),
        checkOut: DateTime(2026, 7, 6));

    await (db.delete(db.trips)..where((t) => t.id.equals(tripId))).go();

    expect(await repo.watchForTrip(tripId).first, isEmpty);
  });
}
