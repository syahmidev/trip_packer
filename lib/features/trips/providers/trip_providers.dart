import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../data/trip_repository.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  return TripRepository(ref.watch(databaseProvider));
});

/// Streams the full trip list for the Home screen.
final tripsProvider = StreamProvider<List<Trip>>((ref) {
  return ref.watch(tripRepositoryProvider).watchAllTrips();
});

/// Streams a single trip for the Trip Detail screen.
final tripProvider = StreamProvider.family<Trip?, int>((ref, id) {
  return ref.watch(tripRepositoryProvider).watchById(id);
});
