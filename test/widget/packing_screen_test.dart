import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/core/providers/database_provider.dart';
import 'package:trip_packer/features/packing/screens/packing_screen.dart';

import 'forui_test_app.dart';

Future<void> drain(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
}

void main() {
  testWidgets('lists items with progress and toggles packed on tap',
      (tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    final tripId = await db.into(db.trips).insert(TripsCompanion.insert(
          title: 'Balkans Backpacking 2026',
          startDate: DateTime(2026, 7, 3),
          endDate: DateTime(2026, 7, 16),
          baseCurrency: 'MYR',
        ));
    await db.into(db.packingItems).insert(PackingItemsCompanion.insert(
          tripId: tripId,
          title: 'Passport',
          category: 'Documents',
        ));
    await db.into(db.packingItems).insert(PackingItemsCompanion.insert(
          tripId: tripId,
          title: 'Socks',
          category: 'Clothes',
        ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: ForuiTestApp(child: PackingScreen(tripId: tripId)),
      ),
    );
    await drain(tester);

    // Progress header + items + filter.
    expect(find.text('0 of 2 packed'), findsOneWidget);
    expect(find.text('Passport'), findsOneWidget);
    expect(find.text('Socks'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);

    // Tapping a checkbox persists the packed flag.
    await tester.tap(find.byType(Checkbox).first);
    await drain(tester);

    final packedCount = (await (db.select(db.packingItems)
              ..where((p) => p.isPacked.equals(true)))
            .get())
        .length;
    expect(packedCount, 1);
    expect(find.text('1 of 2 packed'), findsOneWidget);

    await disposeStreams(tester);
  });
}

/// Tears down the widget tree so Drift's stream-cleanup timer fires inside the
/// test's fake-async zone (otherwise it lingers as a "pending timer").
Future<void> disposeStreams(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 100));
}
