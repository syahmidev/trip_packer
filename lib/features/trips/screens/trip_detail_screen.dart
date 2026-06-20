import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/entrance_fade.dart';
import '../../destinations/widgets/destination_route_text.dart';
import '../providers/trip_providers.dart';

/// Trip Detail / Overview (plan §9, §10). Hub that links to each module.
class TripDetailScreen extends ConsumerWidget {
  const TripDetailScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripProvider(tripId));

    return AppScaffold(
      title: '',
      suffixes: [
        FHeaderAction(
          icon: const Icon(Icons.delete_outline),
          onPress: () => _confirmDelete(context, ref),
        ),
      ],
      child: tripAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (trip) {
          if (trip == null) {
            return const Center(child: Text('Trip not found.'));
          }
          final df = DateFormat('d MMM yyyy');
          final days = trip.endDate.difference(trip.startDate).inDays + 1;

          return ListView(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            children: [
              _TripCover(
                title: trip.title,
                dateLine:
                    '${df.format(trip.startDate)} – ${df.format(trip.endDate)}'
                    '  •  $days day${days == 1 ? '' : 's'}',
                tripId: tripId,
              ),
              const SizedBox(height: 28),
              Text(
                'Plan',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: context.cSecondaryText,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 12),
              ..._modules.indexed.map(
                (e) => EntranceFade(
                  index: e.$1,
                  child: _ModuleTile(
                    icon: e.$2.icon,
                    label: e.$2.label,
                    subtitle: e.$2.subtitle,
                    onTap: () => context.push('/trips/$tripId/${e.$2.path}'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete trip?'),
        content: const Text(
          'This permanently removes the trip and everything in it.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(tripRepositoryProvider).deleteTrip(tripId);
    if (context.mounted) context.go('/');
  }

  static const _modules = <_Module>[
    _Module(
      'Destinations',
      'Your route, in order',
      Icons.public_outlined,
      'destinations',
    ),
    _Module(
      'Itinerary',
      'Day-by-day plan',
      Icons.event_note_outlined,
      'itinerary',
    ),
    _Module(
      'Budget',
      'Planned vs. spent',
      Icons.account_balance_wallet_outlined,
      'budget',
    ),
    _Module(
      'Transport',
      'Buses, trains, flights',
      Icons.directions_bus_outlined,
      'transport',
    ),
    _Module(
      'Accommodation',
      "Where you'll stay",
      Icons.hotel_outlined,
      'accommodation',
    ),
    _Module('Packing', 'Checklist', Icons.checklist_outlined, 'packing'),
  ];
}

/// Gradient "listing cover" hero for the trip identity (Airbnb-style).
class _TripCover extends StatelessWidget {
  const _TripCover({
    required this.title,
    required this.dateLine,
    required this.tripId,
  });

  final String title;
  final String dateLine;
  final int tripId;

  @override
  Widget build(BuildContext context) {
    final colors = AppGradients.colorsFor(tripId);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.last.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                dateLine,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DestinationRouteText(
            tripId: tripId,
            maxLines: 2,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}

class _Module {
  const _Module(this.label, this.subtitle, this.icon, this.path);
  final String label;
  final String subtitle;
  final IconData icon;
  final String path;
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          AppIconChip(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.cSecondaryText,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 20,
            color: context.cSecondaryText.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}
