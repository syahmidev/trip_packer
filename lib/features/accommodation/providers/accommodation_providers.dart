import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../data/accommodation_repository.dart';

final accommodationRepositoryProvider = Provider<AccommodationRepository>((
  ref,
) {
  return AccommodationRepository(ref.watch(databaseProvider));
});

/// Streams the trip's accommodation, ordered by check-in date.
final accommodationsProvider = StreamProvider.family<List<Accommodation>, int>((
  ref,
  tripId,
) {
  return ref.watch(accommodationRepositoryProvider).watchForTrip(tripId);
});
