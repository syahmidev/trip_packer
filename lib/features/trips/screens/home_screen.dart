import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../destinations/widgets/destination_route_text.dart';
import '../providers/trip_providers.dart';

/// Home screen — lists all trips (plan §9, §15).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripsProvider);

    return AppScaffold(
      title: '${_greeting()} 👋',
      showBack: false,
      footer: FButton(
        onPress: () => context.push('/trips/create'),
        prefix: const Icon(Icons.add),
        child: const Text('New Trip'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Plan your next backpacking trip.',
              style: TextStyle(color: context.cSecondaryText),
            ),
          ),
          Expanded(
            child: trips.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (list) {
                if (list.isEmpty) {
                  return EmptyState(
                    icon: Icons.luggage_outlined,
                    title: 'No trips yet',
                    message:
                        'Create your first backpacking trip to get started.',
                    action: FButton(
                      onPress: () => context.push('/trips/create'),
                      prefix: const Icon(Icons.add),
                      child: const Text('Create Trip'),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 16),
                  itemCount: list.length,
                  itemBuilder: (context, i) => _TripCard(trip: list[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('d MMM');
    final range = '${df.format(trip.startDate)} - ${df.format(trip.endDate)}';
    final money = NumberFormat.currency(
      symbol: '${trip.baseCurrency} ',
      decimalDigits: 0,
    );

    final initial = trip.title.trim().isEmpty
        ? '?'
        : trip.title.trim()[0].toUpperCase();

    return AppCard(
      onTap: () => context.push('/trips/${trip.id}'),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GradientAvatar(letter: initial, seed: trip.id),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: context.cSecondaryText,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      range,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.cSecondaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DestinationRouteText(tripId: trip.id),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${money.format(trip.estimatedBudget)} planned',
                    style: const TextStyle(
                      color: AppColors.primaryAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded gradient tile showing a trip's initial — stands in for cover imagery.
class _GradientAvatar extends StatelessWidget {
  const _GradientAvatar({required this.letter, required this.seed});

  final String letter;
  final int seed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: AppGradients.of(seed),
      ),
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 22,
        ),
      ),
    );
  }
}
