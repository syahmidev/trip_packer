import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../data/destination_repository.dart';

final destinationRepositoryProvider = Provider<DestinationRepository>((ref) {
  return DestinationRepository(ref.watch(databaseProvider));
});

/// Streams the ordered destination route for a trip.
final destinationsProvider = StreamProvider.family<List<Destination>, int>((
  ref,
  tripId,
) {
  return ref.watch(destinationRepositoryProvider).watchForTrip(tripId);
});
