import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/database/app_database.dart';
import 'package:trip_packer/core/providers/database_provider.dart';
import 'package:trip_packer/features/budget/screens/budget_screen.dart';

Future<void> drain(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
}

void main() {
  testWidgets('renders summary, category table, and expenses', (tester) async {
    // Tall surface so the whole scrollable (incl. the Expenses section) builds.
    tester.view.physicalSize = const Size(1000, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    final tripId = await db.into(db.trips).insert(TripsCompanion.insert(
          title: 'Balkans Backpacking 2026',
          startDate: DateTime(2026, 7, 3),
          endDate: DateTime(2026, 7, 16),
          baseCurrency: 'MYR',
          estimatedBudget: const Value(7000),
        ));
    await db.into(db.expenses).insert(ExpensesCompanion.insert(
          tripId: tripId,
          title: 'Hostel Sofia',
          category: 'Hostel',
          amount: 140,
          currency: 'MYR',
          date: DateTime(2026, 7, 5),
        ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp(home: BudgetScreen(tripId: tripId)),
      ),
    );
    await drain(tester);

    // Summary + sections.
    expect(find.text('Remaining'), findsOneWidget);
    expect(find.text('Planned vs Spent'), findsOneWidget);
    expect(find.text('Expenses'), findsOneWidget);

    // Remaining = 7000 - 140 = 6860.
    expect(find.textContaining('6,860'), findsOneWidget);

    // The expense is listed.
    expect(find.text('Hostel Sofia'), findsOneWidget);

    await disposeStreams(tester);
  });
}

/// Tears down the widget tree so Drift's stream-cleanup timer fires inside the
/// test's fake-async zone (otherwise it lingers as a "pending timer").
Future<void> disposeStreams(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 100));
}
