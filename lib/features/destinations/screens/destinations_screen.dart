import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../providers/destination_providers.dart';
import '../widgets/destination_form_sheet.dart';

/// Destinations Module (plan Phase 4) — the ordered route of countries/cities.
/// Supports add, edit, delete, and drag-to-reorder.
class DestinationsScreen extends ConsumerWidget {
  const DestinationsScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = ref.watch(destinationsProvider(tripId));

    return Scaffold(
      appBar: AppBar(title: const Text('Destinations')),
      body: destinations.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.public,
              title: 'No destinations yet',
              message: 'Add the countries and cities on your route, in order.',
              action: FilledButton.icon(
                onPressed: () => _openForm(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Add Destination'),
              ),
            );
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
            itemCount: list.length,
            onReorderItem: (oldIndex, newIndex) =>
                _onReorder(ref, list, oldIndex, newIndex),
            itemBuilder: (context, i) {
              final d = list[i];
              return _DestinationTile(
                key: ValueKey(d.id),
                destination: d,
                position: i + 1,
                onEdit: () => _openForm(context, ref, existing: d),
                onDelete: () => _confirmDelete(context, ref, d),
              );
            },
          );
        },
      ),
      floatingActionButton: destinations.maybeWhen(
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
    Destination? existing,
  }) async {
    final result = await showModalBottomSheet<DestinationFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DestinationFormSheet(existing: existing),
    );
    if (result == null) return;

    final repo = ref.read(destinationRepositoryProvider);
    if (existing == null) {
      await repo.addDestination(
        tripId: tripId,
        country: result.country,
        city: result.city,
      );
    } else {
      await repo.updateDestination(
        existing.copyWith(country: result.country, city: result.city),
      );
    }
  }

  Future<void> _onReorder(
    WidgetRef ref,
    List<Destination> list,
    int oldIndex,
    int newIndex,
  ) async {
    // onReorderItem already adjusts newIndex for the removed item.
    final reordered = [...list];
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(newIndex, moved);
    await ref.read(destinationRepositoryProvider).persistOrder(reordered);
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Destination d,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove destination?'),
        content: Text('Remove ${d.city}, ${d.country} from the route?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (ok != true) return;

    final repo = ref.read(destinationRepositoryProvider);
    await repo.deleteDestination(d.id);
    // Keep orderIndex dense after a removal.
    final remaining = await ref.read(destinationsProvider(d.tripId).future);
    await repo.persistOrder(remaining);
  }
}

class _DestinationTile extends StatelessWidget {
  const _DestinationTile({
    required this.destination,
    required this.position,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Destination destination;
  final int position;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
        leading: CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.primaryAccent.withValues(alpha: 0.12),
          child: Text(
            '$position',
            style: const TextStyle(
              color: AppColors.primaryAccent,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        title: Text(
          destination.city,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(destination.country),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              tooltip: 'Edit',
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              tooltip: 'Remove',
              onPressed: onDelete,
            ),
            ReorderableDragStartListener(
              index: position - 1,
              child: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.drag_handle, color: AppColors.secondaryText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
