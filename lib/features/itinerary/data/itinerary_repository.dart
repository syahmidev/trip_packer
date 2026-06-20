import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Data-access for the Itinerary module (plan Phase 5).
///
/// A trip has many [ItineraryDay]s (ordered by date); each day has many
/// [Activity]s (ordered by time-of-day). Activities cascade-delete with their
/// day, days cascade-delete with their trip.
class ItineraryRepository {
  ItineraryRepository(this._db);

  final AppDatabase _db;

  // --- Days ---------------------------------------------------------------

  Stream<List<ItineraryDay>> watchDays(int tripId) {
    return (_db.select(_db.itineraryDays)
          ..where((d) => d.tripId.equals(tripId))
          ..orderBy([(d) => OrderingTerm.asc(d.date)]))
        .watch();
  }

  Future<int> addDay({
    required int tripId,
    required DateTime date,
    required String title,
    String? notes,
  }) {
    return _db
        .into(_db.itineraryDays)
        .insert(
          ItineraryDaysCompanion.insert(
            tripId: tripId,
            date: date,
            title: title,
            notes: Value(notes),
          ),
        );
  }

  Future<bool> updateDay(ItineraryDay day) {
    return _db.update(_db.itineraryDays).replace(day);
  }

  Future<int> deleteDay(int id) {
    return (_db.delete(_db.itineraryDays)..where((d) => d.id.equals(id))).go();
  }

  // --- Activities ---------------------------------------------------------

  /// Activities for a day, ordered by time. Untimed activities (null `time`)
  /// sort first, which keeps "all-day" items at the top of the timeline.
  Stream<List<Activity>> watchActivities(int dayId) {
    return (_db.select(_db.activities)
          ..where((a) => a.itineraryDayId.equals(dayId))
          ..orderBy([(a) => OrderingTerm.asc(a.time)]))
        .watch();
  }

  Future<int> addActivity(ActivitiesCompanion activity) {
    return _db.into(_db.activities).insert(activity);
  }

  Future<bool> updateActivity(Activity activity) {
    return _db.update(_db.activities).replace(activity);
  }

  Future<int> deleteActivity(int id) {
    return (_db.delete(_db.activities)..where((a) => a.id.equals(id))).go();
  }
}
