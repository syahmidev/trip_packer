# TripPacker

TripPacker is an offline-first backpacking trip planner built with Flutter. It
helps travellers organize an ordered route, day-by-day itinerary, multi-currency
budget, transport, accommodation, and a packing checklist — all in one app, with
everything stored locally.

## Features

- Create and manage trips
- Plan an ordered route of destinations (drag to reorder)
- Plan a day-by-day itinerary with timed activities
- Track travel expenses with multi-currency support (exchange rate to base)
- Planned-vs-actual budget by category
- Manage transport legs (bus, train, flight, ferry, metro, walk)
- Manage accommodation bookings (hostel/hotel)
- Packing checklist with progress and category filter
- Offline-first local database with cascade deletes
- Clean, feature-based Flutter architecture

## Tech Stack

- Flutter / Dart
- Riverpod (state management)
- GoRouter (navigation)
- Drift SQLite (local database)
- Forui + Google Fonts (UI / typography)
- intl (date & currency formatting)

## Architecture

Feature-based modules under `lib/features/<feature>/` (`data/`, `providers/`,
`screens/`, `widgets/`), with shared infrastructure in `lib/core/`
(`database/`, `router/`, `theme/`, `widgets/`, `constants/`, `utils/`).

Each child table references `trips.id` with `ON DELETE CASCADE` (foreign keys
enforced via `PRAGMA foreign_keys = ON`), so deleting a trip cleanly removes all
of its data.

## Getting Started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generate Drift code
flutter run
```

## Tests

```bash
flutter test
```

Coverage focuses on business logic: repository CRUD + cascade deletes (Drift
in-memory), budget calculations (totals, exchange-rate conversion, remaining),
Riverpod provider/state wiring, and widget tests for the trip list, budget, and
packing screens.

## Roadmap

- [x] Create trip
- [x] Destinations / route
- [x] Itinerary planner
- [x] Budget tracker (planned vs. actual)
- [x] Packing checklist
- [x] Transport tracker
- [x] Accommodation tracker
- [x] Tests
- [ ] Forui UI restyle (Phase 11 polish)
- [ ] Dark mode
- [ ] AI itinerary generator
- [ ] Cloud sync

## Screenshots

Coming soon.

## Purpose

Built for learning, portfolio, and personal backpacking trip planning.
