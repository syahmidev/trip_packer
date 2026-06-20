import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Wraps a card so it can be swiped left to delete, revealing a rounded red
/// background (plan Phase 11 — consistent list interactions).
///
/// [margin] should match the wrapped card's margin so the red background aligns
/// with the card rather than the gap below it.
class SwipeToDelete extends StatelessWidget {
  const SwipeToDelete({
    required this.itemKey,
    required this.onDelete,
    required this.child,
    this.margin = const EdgeInsets.only(bottom: 14),
    this.radius = 20,
    super.key,
  });

  final Key itemKey;
  final VoidCallback onDelete;
  final Widget child;
  final EdgeInsets margin;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: itemKey,
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        margin: margin,
        padding: const EdgeInsets.only(right: 22),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: child,
    );
  }
}
