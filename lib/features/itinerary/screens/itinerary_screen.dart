import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../trips/providers/trip_providers.dart';
import '../providers/itinerary_providers.dart';
import '../widgets/activity_form_sheet.dart';
import '../widgets/day_form_sheet.dart';

/// Itinerary Module (plan Phase 5) — day-by-day timeline. Each day groups its
/// activities, sorted by time.
class ItineraryScreen extends ConsumerWidget {
  const ItineraryScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = ref.watch(itineraryDaysProvider(tripId));

    return Scaffold(
      appBar: AppBar(title: const Text('Itinerary')),
      body: days.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.event_note_outlined,
              title: 'No days planned yet',
              message: 'Add a day, then fill it with activities.',
              action: FilledButton.icon(
                onPressed: () => _addDay(context, ref, list),
                icon: const Icon(Icons.add),
                label: const Text('Add Day'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
            itemCount: list.length,
            itemBuilder: (context, i) => _DaySection(
              tripId: tripId,
              day: list[i],
              dayNumber: i + 1,
            ),
          );
        },
      ),
      floatingActionButton: days.maybeWhen(
        data: (list) => list.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () => _addDay(context, ref, list),
                icon: const Icon(Icons.add),
                label: const Text('Add Day'),
              ),
        orElse: () => null,
      ),
    );
  }

  Future<void> _addDay(
    BuildContext context,
    WidgetRef ref,
    List<ItineraryDay> existing,
  ) async {
    final result = await showModalBottomSheet<DayFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DayFormSheet(initialDate: _nextOpenDate(ref, existing)),
    );
    if (result == null) return;
    await ref.read(itineraryRepositoryProvider).addDay(
          tripId: tripId,
          date: result.date,
          title: result.title,
          notes: result.notes,
        );
  }

  /// Suggests the day after the last planned day, falling back to the trip's
  /// start date, then today.
  DateTime _nextOpenDate(WidgetRef ref, List<ItineraryDay> existing) {
    if (existing.isNotEmpty) {
      return existing.last.date.add(const Duration(days: 1));
    }
    final trip = ref.read(tripProvider(tripId)).valueOrNull;
    return trip?.startDate ?? DateTime.now();
  }
}

class _DaySection extends ConsumerWidget {
  const _DaySection({
    required this.tripId,
    required this.day,
    required this.dayNumber,
  });

  final int tripId;
  final ItineraryDay day;
  final int dayNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(dayActivitiesProvider(day.id));
    final df = DateFormat('EEE, d MMM');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Day $dayNumber  •  ${df.format(day.date)}',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: AppColors.primaryAccent,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        day.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 20),
                  onSelected: (v) {
                    if (v == 'edit') _editDay(context, ref);
                    if (v == 'delete') _deleteDay(context, ref);
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit day')),
                    PopupMenuItem(value: 'delete', child: Text('Delete day')),
                  ],
                ),
              ],
            ),
            if (day.notes != null && day.notes!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  day.notes!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            activities.maybeWhen(
              data: (acts) => Column(
                children: [
                  for (final a in acts)
                    _ActivityTile(
                      activity: a,
                      onEdit: () => _editActivity(context, ref, a),
                      onDelete: () => _deleteActivity(context, ref, a),
                    ),
                ],
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => _addActivity(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add activity'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editDay(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<DayFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DayFormSheet(existing: day),
    );
    if (result == null) return;
    await ref.read(itineraryRepositoryProvider).updateDay(
          day.copyWith(
            date: result.date,
            title: result.title,
            notes: Value(result.notes),
          ),
        );
  }

  Future<void> _deleteDay(BuildContext context, WidgetRef ref) async {
    final ok = await _confirm(
      context,
      title: 'Delete day?',
      message: 'This removes the day and all its activities.',
      confirmLabel: 'Delete',
    );
    if (!ok) return;
    await ref.read(itineraryRepositoryProvider).deleteDay(day.id);
  }

  Future<void> _addActivity(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet<ActivityFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ActivityFormSheet(dayDate: day.date),
    );
    if (result == null) return;
    await ref.read(itineraryRepositoryProvider).addActivity(
          ActivitiesCompanion.insert(
            itineraryDayId: day.id,
            title: result.title,
            location: Value(result.location),
            time: Value(result.time),
            estimatedCost: Value(result.estimatedCost),
            notes: Value(result.notes),
          ),
        );
  }

  Future<void> _editActivity(
    BuildContext context,
    WidgetRef ref,
    Activity activity,
  ) async {
    final result = await showModalBottomSheet<ActivityFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ActivityFormSheet(dayDate: day.date, existing: activity),
    );
    if (result == null) return;
    await ref.read(itineraryRepositoryProvider).updateActivity(
          activity.copyWith(
            title: result.title,
            location: Value(result.location),
            time: Value(result.time),
            estimatedCost: Value(result.estimatedCost),
            notes: Value(result.notes),
          ),
        );
  }

  Future<void> _deleteActivity(
    BuildContext context,
    WidgetRef ref,
    Activity activity,
  ) async {
    final ok = await _confirm(
      context,
      title: 'Delete activity?',
      message: 'Remove "${activity.title}"?',
      confirmLabel: 'Delete',
    );
    if (!ok) return;
    await ref.read(itineraryRepositoryProvider).deleteActivity(activity.id);
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.onEdit,
    required this.onDelete,
  });

  final Activity activity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final subtitleParts = <String>[
      if (activity.location != null && activity.location!.isNotEmpty)
        activity.location!,
      if (activity.estimatedCost != null)
        NumberFormat.currency(symbol: '~', decimalDigits: 0)
            .format(activity.estimatedCost),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                formatActivityTime(context, activity.time),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.warmAccent,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title),
                if (subtitleParts.isNotEmpty)
                  Text(
                    subtitleParts.join('  •  '),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, size: 18),
            padding: EdgeInsets.zero,
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
}

Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok ?? false;
}
