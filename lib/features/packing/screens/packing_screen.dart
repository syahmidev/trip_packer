import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../core/constants/categories.dart';
import '../../../core/database/app_database.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../providers/packing_providers.dart';
import '../widgets/packing_form_sheet.dart';

/// Packing Module (plan Phase 9) — checklist grouped by category, with a
/// packed/unpacked toggle and a category filter.
class PackingScreen extends ConsumerStatefulWidget {
  const PackingScreen({required this.tripId, super.key});

  final int tripId;

  @override
  ConsumerState<PackingScreen> createState() => _PackingScreenState();
}

class _PackingScreenState extends ConsumerState<PackingScreen> {
  /// Selected category filter; null means "All".
  String? _filter;

  int get tripId => widget.tripId;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(packingItemsProvider(tripId));

    return AppScaffold(
      title: 'Packing',
      footer: items.maybeWhen(
        data: (all) => all.isEmpty
            ? null
            : FButton(
                onPress: () => _openForm(context),
                prefix: const Icon(Icons.add),
                child: const Text('Add Item'),
              ),
        orElse: () => null,
      ),
      child: items.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (all) {
          if (all.isEmpty) {
            return EmptyState(
              icon: Icons.checklist_outlined,
              title: 'Nothing to pack yet',
              message: 'Add items to build your packing checklist.',
              action: FButton(
                onPress: () => _openForm(context),
                prefix: const Icon(Icons.add),
                child: const Text('Add Item'),
              ),
            );
          }

          final packed = all.where((i) => i.isPacked).length;
          final usedCategories = AppCategories.packing
              .where((c) => all.any((i) => i.category == c))
              .toList();
          final filter = (_filter != null && usedCategories.contains(_filter))
              ? _filter
              : null;
          final visible = filter == null
              ? all
              : all.where((i) => i.category == filter).toList();

          return Column(
            children: [
              _ProgressHeader(packed: packed, total: all.length),
              _FilterBar(
                categories: usedCategories,
                selected: filter,
                onSelected: (c) => setState(() => _filter = c),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  children: [
                    for (final category in AppCategories.packing)
                      if (visible.any((i) => i.category == category))
                        _CategoryGroup(
                          category: category,
                          items: visible
                              .where((i) => i.category == category)
                              .toList(),
                          onToggle: (item, value) => ref
                              .read(packingRepositoryProvider)
                              .setPacked(item.id, value),
                          onEdit: (item) => _openForm(context, existing: item),
                          onDelete: (item) => _delete(context, item),
                        ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {PackingItem? existing}) async {
    final result = await showModalBottomSheet<PackingFormResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) =>
          PackingFormSheet(existing: existing, initialCategory: _filter),
    );
    if (result == null) return;

    final repo = ref.read(packingRepositoryProvider);
    if (existing == null) {
      await repo.addItem(
        tripId: tripId,
        title: result.title,
        category: result.category,
      );
    } else {
      await repo.updateItem(
        existing.copyWith(title: result.title, category: result.category),
      );
    }
  }

  Future<void> _delete(BuildContext context, PackingItem item) async {
    await ref.read(packingRepositoryProvider).deleteItem(item.id);
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.packed, required this.total});

  final int packed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final fraction = total == 0 ? 0.0 : packed / total;
    final done = packed == total;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$packed of $total packed',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              if (done)
                const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: AppColors.success,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'All packed',
                      style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 8,
              backgroundColor: context.cBorder,
              color: done ? AppColors.success : AppColors.primaryAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<String> categories;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: const Text('All'),
              selected: selected == null,
              onSelected: (_) => onSelected(null),
            ),
          ),
          for (final c in categories)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(c),
                selected: selected == c,
                onSelected: (_) => onSelected(c),
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryGroup extends StatelessWidget {
  const _CategoryGroup({
    required this.category,
    required this.items,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final String category;
  final List<PackingItem> items;
  final void Function(PackingItem item, bool value) onToggle;
  final ValueChanged<PackingItem> onEdit;
  final ValueChanged<PackingItem> onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 4),
          child: Text(
            category,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: context.cSecondaryText,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        for (final item in items)
          Dismissible(
            key: ValueKey(item.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => onDelete(item),
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.danger,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_outline, color: Colors.white),
            ),
            child: AppCard(
              margin: const EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.zero,
              child: CheckboxListTile(
                value: item.isPacked,
                onChanged: (v) => onToggle(item, v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primaryAccent,
                title: Text(
                  item.title,
                  style: TextStyle(
                    decoration: item.isPacked
                        ? TextDecoration.lineThrough
                        : null,
                    color: item.isPacked ? context.cSecondaryText : null,
                  ),
                ),
                secondary: IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  tooltip: 'Edit',
                  onPressed: () => onEdit(item),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
