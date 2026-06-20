import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Data-access for the Accommodation module (plan Phase 8).
///
/// Stays are listed in trip order — ascending by check-in date.
class AccommodationRepository {
  AccommodationRepository(this._db);

  final AppDatabase _db;

  Stream<List<Accommodation>> watchForTrip(int tripId) {
    return (_db.select(_db.accommodations)
          ..where((a) => a.tripId.equals(tripId))
          ..orderBy([(a) => OrderingTerm.asc(a.checkIn)]))
        .watch();
  }

  Future<int> addAccommodation(AccommodationsCompanion accommodation) {
    return _db.into(_db.accommodations).insert(accommodation);
  }

  Future<bool> updateAccommodation(Accommodation accommodation) {
    return _db.update(_db.accommodations).replace(accommodation);
  }

  Future<int> deleteAccommodation(int id) {
    return (_db.delete(_db.accommodations)..where((a) => a.id.equals(id))).go();
  }
}
