import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ---------------------------------------------------------------------------
// Tables (see plan §12 Data Models & §13 Database Tables)
// ---------------------------------------------------------------------------

class Trips extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 120)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get baseCurrency => text().withLength(min: 3, max: 3)();
  RealColumn get estimatedBudget => real().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
}

class Destinations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tripId =>
      integer().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get country => text()();
  TextColumn get city => text()();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();
}

class ItineraryDays extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tripId =>
      integer().references(Trips, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();
}

class Activities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itineraryDayId =>
      integer().references(ItineraryDays, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get location => text().nullable()();
  DateTimeColumn get time => dateTime().nullable()();
  RealColumn get estimatedCost => real().nullable()();
  TextColumn get notes => text().nullable()();
}

/// Planned budget per category (plan fix #3 — planned vs. actual).
class BudgetCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tripId =>
      integer().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get category => text()();
  RealColumn get plannedAmount => real().withDefault(const Constant(0))();
}

/// Actual spend. Stores the currency paid in plus an exchange rate to the
/// trip's base currency (plan fix #4).
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tripId =>
      integer().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get category => text()();
  RealColumn get amount => real()();
  TextColumn get currency => text().withLength(min: 3, max: 3)();
  RealColumn get exchangeRate => real().withDefault(const Constant(1))();
  DateTimeColumn get date => dateTime()();
}

class Transports extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tripId =>
      integer().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  TextColumn get from => text()();
  TextColumn get to => text()();
  DateTimeColumn get departureDateTime => dateTime()();
  DateTimeColumn get arrivalDateTime => dateTime().nullable()();
  RealColumn get cost => real().withDefault(const Constant(0))();
  TextColumn get bookingReference => text().nullable()();
  TextColumn get notes => text().nullable()();
}

class Accommodations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tripId =>
      integer().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get city => text()();
  DateTimeColumn get checkIn => dateTime()();
  DateTimeColumn get checkOut => dateTime()();
  RealColumn get cost => real().withDefault(const Constant(0))();
  TextColumn get bookingReference => text().nullable()();
  TextColumn get notes => text().nullable()();
}

class PackingItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tripId =>
      integer().references(Trips, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get category => text()();
  BoolColumn get isPacked => boolean().withDefault(const Constant(false))();
}

// ---------------------------------------------------------------------------
// Database
// ---------------------------------------------------------------------------

@DriftDatabase(
  tables: [
    Trips,
    Destinations,
    ItineraryDays,
    Activities,
    BudgetCategories,
    Expenses,
    Transports,
    Accommodations,
    PackingItems,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  /// Injectable executor for tests (use an in-memory [NativeDatabase]).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        beforeOpen: (details) async {
          // Enforce ON DELETE CASCADE foreign keys (plan fix #7).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static QueryExecutor _open() => driftDatabase(name: 'trip_packer');
}
