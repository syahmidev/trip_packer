import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../data/packing_repository.dart';

final packingRepositoryProvider = Provider<PackingRepository>((ref) {
  return PackingRepository(ref.watch(databaseProvider));
});

/// Streams the trip's packing items, ordered by category then title.
final packingItemsProvider = StreamProvider.family<List<PackingItem>, int>((
  ref,
  tripId,
) {
  return ref.watch(packingRepositoryProvider).watchForTrip(tripId);
});
