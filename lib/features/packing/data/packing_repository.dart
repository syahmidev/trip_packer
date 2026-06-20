import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Data-access for the Packing module (plan Phase 9).
///
/// Items are grouped by category in the UI; the stream is ordered by category
/// then title for a stable layout.
class PackingRepository {
  PackingRepository(this._db);

  final AppDatabase _db;

  Stream<List<PackingItem>> watchForTrip(int tripId) {
    return (_db.select(_db.packingItems)
          ..where((p) => p.tripId.equals(tripId))
          ..orderBy([
            (p) => OrderingTerm.asc(p.category),
            (p) => OrderingTerm.asc(p.title),
          ]))
        .watch();
  }

  Future<int> addItem({
    required int tripId,
    required String title,
    required String category,
  }) {
    return _db.into(_db.packingItems).insert(
          PackingItemsCompanion.insert(
            tripId: tripId,
            title: title,
            category: category,
          ),
        );
  }

  /// Toggles the packed state of a single item.
  Future<void> setPacked(int id, bool isPacked) {
    return (_db.update(_db.packingItems)..where((p) => p.id.equals(id)))
        .write(PackingItemsCompanion(isPacked: Value(isPacked)));
  }

  Future<bool> updateItem(PackingItem item) {
    return _db.update(_db.packingItems).replace(item);
  }

  Future<int> deleteItem(int id) {
    return (_db.delete(_db.packingItems)..where((p) => p.id.equals(id))).go();
  }
}
