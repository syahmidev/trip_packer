import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Data-access for the Destinations module (plan Phase 4).
///
/// Destinations form an *ordered* route per trip. [orderIndex] is the source of
/// truth for ordering; new destinations are appended to the end and reordering
/// rewrites the indices to stay dense (0..n-1).
class DestinationRepository {
  DestinationRepository(this._db);

  final AppDatabase _db;

  Stream<List<Destination>> watchForTrip(int tripId) {
    return (_db.select(_db.destinations)
          ..where((d) => d.tripId.equals(tripId))
          ..orderBy([(d) => OrderingTerm.asc(d.orderIndex)]))
        .watch();
  }

  /// Appends a destination to the end of the trip's route.
  Future<int> addDestination({
    required int tripId,
    required String country,
    required String city,
  }) async {
    final existing = await (_db.select(
      _db.destinations,
    )..where((d) => d.tripId.equals(tripId))).get();
    return _db
        .into(_db.destinations)
        .insert(
          DestinationsCompanion.insert(
            tripId: tripId,
            country: country,
            city: city,
            orderIndex: Value(existing.length),
          ),
        );
  }

  Future<bool> updateDestination(Destination destination) {
    return _db.update(_db.destinations).replace(destination);
  }

  Future<int> deleteDestination(int id) {
    return (_db.delete(_db.destinations)..where((d) => d.id.equals(id))).go();
  }

  /// Persists a new ordering by rewriting [orderIndex] to match list position.
  /// Pass the destinations in their desired display order.
  Future<void> persistOrder(List<Destination> ordered) {
    return _db.transaction(() async {
      for (var i = 0; i < ordered.length; i++) {
        await (_db.update(_db.destinations)
              ..where((d) => d.id.equals(ordered[i].id)))
            .write(DestinationsCompanion(orderIndex: Value(i)));
      }
    });
  }
}
