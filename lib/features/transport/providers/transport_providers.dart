import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../data/transport_repository.dart';

final transportRepositoryProvider = Provider<TransportRepository>((ref) {
  return TransportRepository(ref.watch(databaseProvider));
});

/// Streams the trip's transport legs, ordered by departure date/time.
final transportsProvider = StreamProvider.family<List<Transport>, int>((
  ref,
  tripId,
) {
  return ref.watch(transportRepositoryProvider).watchForTrip(tripId);
});
