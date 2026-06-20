import 'package:go_router/go_router.dart';

import '../../features/accommodation/screens/accommodation_screen.dart';
import '../../features/budget/screens/budget_screen.dart';
import '../../features/destinations/screens/destinations_screen.dart';
import '../../features/itinerary/screens/itinerary_screen.dart';
import '../../features/packing/screens/packing_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/transport/screens/transport_screen.dart';
import '../../features/trips/screens/create_trip_screen.dart';
import '../../features/trips/screens/home_screen.dart';
import '../../features/trips/screens/trip_detail_screen.dart';

/// App navigation (plan §10). Trip-scoped modules live under /trips/:id/*.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/trips/create',
      builder: (context, state) => const CreateTripScreen(),
    ),
    GoRoute(
      path: '/trips/:id',
      builder: (context, state) =>
          TripDetailScreen(tripId: _id(state.pathParameters['id'])),
      routes: [
        GoRoute(
          path: 'destinations',
          builder: (context, state) =>
              DestinationsScreen(tripId: _id(state.pathParameters['id'])),
        ),
        GoRoute(
          path: 'itinerary',
          builder: (context, state) =>
              ItineraryScreen(tripId: _id(state.pathParameters['id'])),
        ),
        GoRoute(
          path: 'budget',
          builder: (context, state) =>
              BudgetScreen(tripId: _id(state.pathParameters['id'])),
        ),
        GoRoute(
          path: 'transport',
          builder: (context, state) =>
              TransportScreen(tripId: _id(state.pathParameters['id'])),
        ),
        GoRoute(
          path: 'accommodation',
          builder: (context, state) =>
              AccommodationScreen(tripId: _id(state.pathParameters['id'])),
        ),
        GoRoute(
          path: 'packing',
          builder: (context, state) =>
              PackingScreen(tripId: _id(state.pathParameters['id'])),
        ),
      ],
    ),
  ],
);

int _id(String? raw) => int.tryParse(raw ?? '') ?? 0;
