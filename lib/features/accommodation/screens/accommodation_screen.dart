import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../providers/accommodation_providers.dart';
import '../widgets/accommodation_form_sheet.dart';

/// Accommodation Module (plan Phase 8) — hostel/hotel bookings, listed in trip
/// order by check-in date.
class AccommodationScreen extends ConsumerWidget {
  const AccommodationScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stays = ref.watch(accommodationsProvider(tripId));

    return Scaffold(
      appBar: AppBar(title: const Text('Accommodation')),
      body: stays.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.hotel_outlined,
              title: 'No bookings yet',
              message: 'Add the hostels and hotels you have booked.',
              action: FilledButton.icon(
                onPressed: () => _openForm(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Add Accommodation'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
            itemCount: list.length,
            itemBuilder: (context, i) => _AccommodationCard(
              stay: list[i],
              onEdit: () => _openForm(context, ref, existing: list[i]),
              onDelete: () => _confirmDelete(context, ref, list[i]),
            ),
          );
        },
      ),
      floatingActionButton: stays.maybeWhen(
        data: (list) => list.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () => _openForm(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
        orElse: () => null,
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context,
    WidgetRef ref, {
    Accommodation? existing,
  }) async {
    final result = await showModalBottomSheet<AccommodationFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AccommodationFormSheet(existing: existing),
    );
    if (result == null) return;

    final repo = ref.read(accommodationRepositoryProvider);
    if (existing == null) {
      await repo.addAccommodation(
        AccommodationsCompanion.insert(
          tripId: tripId,
          name: result.name,
          city: result.city,
          checkIn: result.checkIn,
          checkOut: result.checkOut,
          cost: Value(result.cost),
          bookingReference: Value(result.bookingReference),
          notes: Value(result.notes),
        ),
      );
    } else {
      await repo.updateAccommodation(
        existing.copyWith(
          name: result.name,
          city: result.city,
          checkIn: result.checkIn,
          checkOut: result.checkOut,
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
    Accommodation a,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete accommodation?'),
        content: Text('Remove ${a.name} in ${a.city}?'),
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
    await ref.read(accommodationRepositoryProvider).deleteAccommodation(a.id);
  }
}

class _AccommodationCard extends StatelessWidget {
  const _AccommodationCard({
    required this.stay,
    required this.onEdit,
    required this.onDelete,
  });

  final Accommodation stay;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('d MMM');
    final nights = stay.checkOut.difference(stay.checkIn).inDays;
    final hasCost = stay.cost > 0;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2, right: 14),
              child: Icon(Icons.hotel_outlined, color: AppColors.primaryAccent),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stay.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stay.city,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${df.format(stay.checkIn)} → ${df.format(stay.checkOut)}'
                    '  •  $nights night${nights == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (hasCost || stay.bookingReference != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      [
                        if (hasCost)
                          NumberFormat.currency(symbol: '', decimalDigits: 0)
                              .format(stay.cost),
                        if (stay.bookingReference != null)
                          'Ref: ${stay.bookingReference}',
                      ].join('  •  '),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  if (stay.notes != null && stay.notes!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      stay.notes!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.secondaryText,
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
      ),
    );
  }
}
