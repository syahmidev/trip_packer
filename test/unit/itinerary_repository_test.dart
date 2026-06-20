import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/features/itinerary/data/itinerary_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ItineraryRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ItineraryRepository(db);
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

  test('watchDays returns days ordered by date', () async {
    final tripId = await seedTrip();
    await repo.addDay(tripId: tripId, date: DateTime(2026, 7, 5), title: 'Sofia');
    await repo.addDay(tripId: tripId, date: DateTime(2026, 7, 3), title: 'Istanbul');
    await repo.addDay(tripId: tripId, date: DateTime(2026, 7, 4), title: 'Travel');

    final days = await repo.watchDays(tripId).first;
    expect(days.map((d) => d.title), ['Istanbul', 'Travel', 'Sofia']);
  });

  test('activities sort by time with untimed first', () async {
    final tripId = await seedTrip();
    final dayId =
        await repo.addDay(tripId: tripId, date: DateTime(2026, 7, 3), title: 'Day 1');

    await repo.addActivity(ActivitiesCompanion.insert(
      itineraryDayId: dayId,
      title: 'Bus to Skopje',
      time: Value(DateTime(2026, 7, 3, 18, 0)),
    ));
    await repo.addActivity(ActivitiesCompanion.insert(
      itineraryDayId: dayId,
      title: 'Free walking tour',
      time: Value(DateTime(2026, 7, 3, 10, 0)),
    ));
    await repo.addActivity(ActivitiesCompanion.insert(
      itineraryDayId: dayId,
      title: 'Anytime — buy SIM',
    ));

    final acts = await repo.watchActivities(dayId).first;
    expect(
      acts.map((a) => a.title),
      ['Anytime — buy SIM', 'Free walking tour', 'Bus to Skopje'],
    );
  });

  test('deleting a day cascades to its activities', () async {
    final tripId = await seedTrip();
    final dayId =
        await repo.addDay(tripId: tripId, date: DateTime(2026, 7, 3), title: 'Day 1');
    await repo.addActivity(ActivitiesCompanion.insert(
      itineraryDayId: dayId,
      title: 'Free walking tour',
    ));

    await repo.deleteDay(dayId);

    expect(await repo.watchActivities(dayId).first, isEmpty);
  });

  test('deleting a trip cascades through days to activities', () async {
    final tripId = await seedTrip();
    final dayId =
        await repo.addDay(tripId: tripId, date: DateTime(2026, 7, 3), title: 'Day 1');
    await repo.addActivity(ActivitiesCompanion.insert(
      itineraryDayId: dayId,
      title: 'Free walking tour',
    ));

    await (db.delete(db.trips)..where((t) => t.id.equals(tripId))).go();

    expect(await repo.watchDays(tripId).first, isEmpty);
    expect(await repo.watchActivities(dayId).first, isEmpty);
  });
}
