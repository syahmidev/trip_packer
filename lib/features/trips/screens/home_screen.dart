import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../destinations/widgets/destination_route_text.dart';
import '../providers/trip_providers.dart';

/// Home screen — lists all trips (plan §9, §15).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripsProvider);
    final greeting = _greeting();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting 👋',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Plan your next backpacking trip.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: trips.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (list) {
                  if (list.isEmpty) {
                    return EmptyState(
                      icon: Icons.luggage_outlined,
                      title: 'No trips yet',
                      message:
                          'Create your first backpacking trip to get started.',
                      action: FilledButton.icon(
                        onPressed: () => context.push('/trips/create'),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Trip'),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
                    itemCount: list.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, i) => _TripCard(trip: list[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/trips/create'),
        icon: const Icon(Icons.add),
        label: const Text('New Trip'),
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

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.card,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/trips/${trip.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trip.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                range,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryText,
                    ),
              ),
              const SizedBox(height: 8),
              DestinationRouteText(tripId: trip.id),
              const SizedBox(height: 12),
              Text(
                '${money.format(trip.estimatedBudget)} planned',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryAccent,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
