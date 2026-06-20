import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/core/providers/database_provider.dart';
import 'package:trip_packer/features/trips/data/trip_repository.dart';
import 'package:trip_packer/features/trips/providers/trip_providers.dart';

class MockTripRepository extends Mock implements TripRepository {}

Trip _trip(int id, String title) => Trip(
      id: id,
      title: title,
      startDate: DateTime(2026, 7, 3),
      endDate: DateTime(2026, 7, 16),
      baseCurrency: 'MYR',
      estimatedBudget: 7000,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('tripsProvider with a real in-memory database', () {
    late AppDatabase db;
    late ProviderContainer container;

    setUp(() {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      container = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('emits inserted trips, newest start date first', () async {
      // Keep the stream alive while we mutate the database.
      container.listen(tripsProvider, (_, _) {});

      await db.into(db.trips).insert(TripsCompanion.insert(
            title: 'Old trip',
            startDate: DateTime(2026, 1, 1),
            endDate: DateTime(2026, 1, 10),
            baseCurrency: 'MYR',
          ));
      await db.into(db.trips).insert(TripsCompanion.insert(
            title: 'New trip',
            startDate: DateTime(2026, 9, 1),
            endDate: DateTime(2026, 9, 10),
            baseCurrency: 'MYR',
          ));

      // Re-read the stream's latest value.
      final trips = await container.read(tripRepositoryProvider).watchAllTrips().first;
      expect(trips.map((t) => t.title), ['New trip', 'Old trip']);
    });
  });

  group('tripsProvider with a mocked repository (mocktail)', () {
    test('surfaces the repository stream through the provider', () async {
      final repo = MockTripRepository();
      when(() => repo.watchAllTrips())
          .thenAnswer((_) => Stream.value([_trip(1, 'Balkans')]));

      final container = ProviderContainer(
        overrides: [tripRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);

      final value = await container.read(tripsProvider.future);

      expect(value.single.title, 'Balkans');
      verify(() => repo.watchAllTrips()).called(1);
    });
  });
}
