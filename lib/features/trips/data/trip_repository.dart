import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Data-access for the Trip module (plan Phase 3).
class TripRepository {
  TripRepository(this._db);

  final AppDatabase _db;

  Stream<List<Trip>> watchAllTrips() {
    return (_db.select(_db.trips)
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
        .watch();
  }

  Future<Trip?> findById(int id) {
    return (_db.select(_db.trips)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<Trip?> watchById(int id) {
    return (_db.select(_db.trips)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<int> createTrip(TripsCompanion trip) {
    return _db.into(_db.trips).insert(trip);
  }

  Future<bool> updateTrip(Trip trip) {
    return _db.update(_db.trips).replace(trip);
  }

  /// Deleting a trip cascades to all child rows (FKs + PRAGMA foreign_keys).
  Future<int> deleteTrip(int id) {
    return (_db.delete(_db.trips)..where((t) => t.id.equals(id))).go();
  }
}
