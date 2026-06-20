import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/trip_providers.dart';

/// Trip Detail / Overview (plan §9, §10). Hub that links to each module.
class TripDetailScreen extends ConsumerWidget {
  const TripDetailScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripProvider(tripId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Overview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete trip',
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: tripAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (trip) {
          if (trip == null) {
            return const Center(child: Text('Trip not found.'));
          }
          final df = DateFormat('d MMM yyyy');
          final days = trip.endDate.difference(trip.startDate).inDays + 1;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                trip.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                '${df.format(trip.startDate)} – ${df.format(trip.endDate)}  •  '
                '$days day${days == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
              ),
              const SizedBox(height: 24),
              ..._modules.map(
                (m) => _ModuleTile(
                  icon: m.icon,
                  label: m.label,
                  onTap: () => context.push('/trips/$tripId/${m.path}'),
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
    _Module('Destinations', Icons.public, 'destinations'),
    _Module('Itinerary', Icons.event_note_outlined, 'itinerary'),
    _Module('Budget', Icons.account_balance_wallet_outlined, 'budget'),
    _Module('Transport', Icons.directions_bus_outlined, 'transport'),
    _Module('Accommodation', Icons.hotel_outlined, 'accommodation'),
    _Module('Packing', Icons.checklist_outlined, 'packing'),
  ];
}

class _Module {
  const _Module(this.label, this.icon, this.path);
  final String label;
  final IconData icon;
  final String path;
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.card,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryAccent),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
