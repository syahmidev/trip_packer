import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../data/itinerary_repository.dart';

final itineraryRepositoryProvider = Provider<ItineraryRepository>((ref) {
  return ItineraryRepository(ref.watch(databaseProvider));
});

/// Streams the trip's itinerary days, ordered by date.
final itineraryDaysProvider = StreamProvider.family<List<ItineraryDay>, int>((
  ref,
  tripId,
) {
  return ref.watch(itineraryRepositoryProvider).watchDays(tripId);
});

/// Streams a single day's activities, ordered by time.
final dayActivitiesProvider = StreamProvider.family<List<Activity>, int>((
  ref,
  dayId,
) {
  return ref.watch(itineraryRepositoryProvider).watchActivities(dayId);
});
