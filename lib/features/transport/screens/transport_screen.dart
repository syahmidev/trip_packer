import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/entrance_fade.dart';
import '../../trips/providers/trip_providers.dart';
import '../providers/transport_providers.dart';
import '../widgets/transport_form_sheet.dart';

/// Transport Module (plan Phase 7) — bus/train/flight/ferry/metro/walk legs,
/// listed in travel order by departure date/time.
class TransportScreen extends ConsumerWidget {
  const TransportScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transports = ref.watch(transportsProvider(tripId));

    return AppScaffold(
      title: 'Transport',
      footer: transports.maybeWhen(
        data: (list) => list.isEmpty
            ? null
            : FButton(
                onPress: () => _openForm(context, ref),
                prefix: const Icon(Icons.add),
                child: const Text('Add Transport'),
              ),
        orElse: () => null,
      ),
      child: transports.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.directions_bus_outlined,
              title: 'No transport yet',
              message: 'Add the buses, trains, and flights for your route.',
              action: FButton(
                onPress: () => _openForm(context, ref),
                prefix: const Icon(Icons.add),
                child: const Text('Add Transport'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: list.length,
            itemBuilder: (context, i) => EntranceFade(
              index: i,
              child: _TransportCard(
                transport: list[i],
                onEdit: () => _openForm(context, ref, existing: list[i]),
                onDelete: () => _confirmDelete(context, ref, list[i]),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context,
    WidgetRef ref, {
    Transport? existing,
  }) async {
    final trip = ref.read(tripProvider(tripId)).valueOrNull;
    final result = await showModalBottomSheet<TransportFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => TransportFormSheet(
        existing: existing,
        tripStart: trip?.startDate,
        tripEnd: trip?.endDate,
      ),
    );
    if (result == null) return;

    final repo = ref.read(transportRepositoryProvider);
    if (existing == null) {
      await repo.addTransport(
        TransportsCompanion.insert(
          tripId: tripId,
          type: result.type,
          from: result.from,
          to: result.to,
          departureDateTime: result.departure,
          arrivalDateTime: Value(result.arrival),
          cost: Value(result.cost),
          bookingReference: Value(result.bookingReference),
          notes: Value(result.notes),
        ),
      );
    } else {
      await repo.updateTransport(
        existing.copyWith(
          type: result.type,
          from: result.from,
          to: result.to,
          departureDateTime: result.departure,
          arrivalDateTime: Value(result.arrival),
          cost: result.cost,
          bookingReference: Value(result.bookingReference),
          notes: Value(result.notes),
        ),
      );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Transport t,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete transport?'),
        content: Text('Remove ${t.type} ${t.from} → ${t.to}?'),
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
    await ref.read(transportRepositoryProvider).deleteTransport(t.id);
  }
}

class _TransportCard extends StatelessWidget {
  const _TransportCard({
    required this.transport,
    required this.onEdit,
    required this.onDelete,
  });

  final Transport transport;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final dt = DateFormat('EEE, d MMM • HH:mm');
    final t = DateFormat('HH:mm');
    final hasCost = transport.cost > 0;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIconChip(icon: _iconFor(transport.type)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${transport.from} → ${transport.to}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    _TypePill(label: transport.type),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  dt.format(transport.departureDateTime) +
                      (transport.arrivalDateTime == null
                          ? ''
                          : '  →  ${t.format(transport.arrivalDateTime!)}'),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.cSecondaryText,
                  ),
                ),
                if (hasCost || transport.bookingReference != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    [
                      if (hasCost)
                        NumberFormat.currency(
                          symbol: '',
                          decimalDigits: 0,
                        ).format(transport.cost),
                      if (transport.bookingReference != null)
                        'Ref: ${transport.bookingReference}',
                    ].join('  •  '),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                if (transport.notes != null && transport.notes!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    transport.notes!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.cSecondaryText,
                    ),
                  ),
                ],
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            onSelected: (v) => v == 'edit' ? onEdit() : onDelete(),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  static IconData _iconFor(String type) {
    switch (type) {
      case 'Bus':
        return Icons.directions_bus_outlined;
      case 'Train':
        return Icons.train_outlined;
      case 'Flight':
        return Icons.flight_outlined;
      case 'Ferry':
        return Icons.directions_boat_outlined;
      case 'Metro':
        return Icons.subway_outlined;
      case 'Walk':
        return Icons.directions_walk_outlined;
      default:
        return Icons.commute_outlined;
    }
  }
}

class _TypePill extends StatelessWidget {
  const _TypePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primaryAccent,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
