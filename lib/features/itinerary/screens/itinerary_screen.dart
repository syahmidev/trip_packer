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

    return AppScaffold(
      title: 'Itinerary',
      footer: days.maybeWhen(
        data: (list) => list.isEmpty
            ? null
            : FButton(
                onPress: () => _addDay(context, ref, list),
                prefix: const Icon(Icons.add),
                child: const Text('Add Day'),
              ),
        orElse: () => null,
      ),
      child: days.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.event_note_outlined,
              title: 'No days planned yet',
              message: 'Add a day, then fill it with activities.',
              action: FButton(
                onPress: () => _addDay(context, ref, list),
                prefix: const Icon(Icons.add),
                child: const Text('Add Day'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: list.length,
            itemBuilder: (context, i) => EntranceFade(
              index: i,
              child: _DaySection(
                tripId: tripId,
                day: list[i],
                dayNumber: i + 1,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _addDay(
    BuildContext context,
    WidgetRef ref,
    List<ItineraryDay> existing,
  ) async {
    final trip = ref.read(tripProvider(tripId)).valueOrNull;
    final result = await showModalBottomSheet<DayFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DayFormSheet(
        initialDate: _nextOpenDate(ref, existing),
        tripStart: trip?.startDate,
        tripEnd: trip?.endDate,
      ),
    );
    if (result == null) return;
    await ref
        .read(itineraryRepositoryProvider)
        .addDay(
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Padding(
          padding: EdgeInsets.zero,
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
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: AppColors.primaryAccent,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          day.title,
                          style: Theme.of(context).textTheme.titleMedium
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
                      color: context.cSecondaryText,
                    ),
                  ),
                ),
              ],
              activities.maybeWhen(
                data: (acts) => Column(
                  children: [
                    if (acts.isNotEmpty)
                      Divider(height: 20, color: context.cBorder),
                    for (final (i, a) in acts.indexed)
                      _ActivityTile(
                        activity: a,
                        isFirst: i == 0,
                        isLast: i == acts.length - 1,
                        onEdit: () => _editActivity(context, ref, a),
                        onDelete: () => ref
                            .read(itineraryRepositoryProvider)
                            .deleteActivity(a.id),
                      ),
                  ],
                ),
                orElse: () => const SizedBox.shrink(),
              ),
              const SizedBox(height: 4),
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
      ),
    );
  }

  Future<void> _editDay(BuildContext context, WidgetRef ref) async {
    final trip = ref.read(tripProvider(tripId)).valueOrNull;
    final result = await showModalBottomSheet<DayFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DayFormSheet(
        existing: day,
        tripStart: trip?.startDate,
        tripEnd: trip?.endDate,
      ),
    );
    if (result == null) return;
    await ref
        .read(itineraryRepositoryProvider)
        .updateDay(
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
    await ref
        .read(itineraryRepositoryProvider)
        .addActivity(
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
    await ref
        .read(itineraryRepositoryProvider)
        .updateActivity(
          activity.copyWith(
            title: result.title,
            location: Value(result.location),
            time: Value(result.time),
            estimatedCost: Value(result.estimatedCost),
            notes: Value(result.notes),
          ),
        );
  }
}

/// A single activity rendered as a timeline row: time column, a connecting
/// rail with a dot, then tap-to-edit content. Swipe left to delete.
class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.isFirst,
    required this.isLast,
    required this.onEdit,
    required this.onDelete,
  });

  final Activity activity;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final timed = activity.time != null;
    final subtitleParts = <String>[
      if (activity.location != null && activity.location!.isNotEmpty)
        activity.location!,
      if (activity.estimatedCost != null)
        NumberFormat.currency(
          symbol: '~',
          decimalDigits: 0,
        ).format(activity.estimatedCost),
    ];

    return Dismissible(
      key: ValueKey(activity.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Color(0xFFFFFFFF),
          size: 20,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  formatActivityTime(context, activity.time),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: timed
                        ? AppColors.warmAccent
                        : context.cSecondaryText,
                    fontWeight: timed ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
            _Rail(isFirst: isFirst, isLast: isLast),
            Expanded(
              child: InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 8, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (subtitleParts.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitleParts.join('  •  '),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: context.cSecondaryText),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vertical timeline rail with a dot, connecting consecutive activities.
class _Rail extends StatelessWidget {
  const _Rail({required this.isFirst, required this.isLast});

  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final line = context.cBorder;
    return SizedBox(
      width: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 12,
            child: Center(
              child: Container(
                width: 2,
                color: isFirst ? Colors.transparent : line,
              ),
            ),
          ),
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryAccent, width: 2.5),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 2,
                color: isLast ? Colors.transparent : line,
              ),
            ),
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
