import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/core/providers/database_provider.dart';
import 'package:trip_packer/features/trips/screens/home_screen.dart';

import 'forui_test_app.dart';

/// Pumps a few fixed frames so Drift's query stream can deliver without
/// hanging on the loading spinner (which never settles).
Future<void> drain(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
}

void main() {
  testWidgets('shows empty state, then the trip once one exists',
      (tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const ForuiTestApp(child: HomeScreen()),
      ),
    );
    await drain(tester);

    expect(find.text('No trips yet'), findsOneWidget);

    await db.into(db.trips).insert(TripsCompanion.insert(
          title: 'Balkans Backpacking 2026',
          startDate: DateTime(2026, 7, 3),
          endDate: DateTime(2026, 7, 16),
          baseCurrency: 'MYR',
          estimatedBudget: const Value(7000),
        ));
    await drain(tester);

    expect(find.text('No trips yet'), findsNothing);
    expect(find.text('Balkans Backpacking 2026'), findsOneWidget);
    expect(find.textContaining('7,000'), findsOneWidget);

    await disposeStreams(tester);
  });
}

/// Tears down the widget tree so Drift's stream-cleanup timer fires inside the
/// test's fake-async zone (otherwise it lingers as a "pending timer").
Future<void> disposeStreams(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 100));
}
