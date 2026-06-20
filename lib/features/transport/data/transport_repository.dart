import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Data-access for the Transport module (plan Phase 7).
///
/// Legs are listed in travel order — ascending by departure date/time.
class TransportRepository {
  TransportRepository(this._db);

  final AppDatabase _db;

  Stream<List<Transport>> watchForTrip(int tripId) {
    return (_db.select(_db.transports)
          ..where((t) => t.tripId.equals(tripId))
          ..orderBy([(t) => OrderingTerm.asc(t.departureDateTime)]))
        .watch();
  }

  Future<int> addTransport(TransportsCompanion transport) {
    return _db.into(_db.transports).insert(transport);
  }

  Future<bool> updateTransport(Transport transport) {
    return _db.update(_db.transports).replace(transport);
  }

  Future<int> deleteTransport(int id) {
    return (_db.delete(_db.transports)..where((t) => t.id.equals(id))).go();
  }
}
