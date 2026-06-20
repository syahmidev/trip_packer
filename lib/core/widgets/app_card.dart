import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Airbnb-style surface (plan Phase 11 — Forui restyle / visual polish).
///
/// Soft shadow instead of a hard border, large radius, an ink ripple and a
/// subtle press-scale when [onTap] is set. Theme-aware: a soft shadow in light
/// mode, a hairline border in dark mode where shadows read poorly.
class AppCard extends StatefulWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin = const EdgeInsets.only(bottom: 14),
    this.onTap,
    this.radius = 20,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;
  final double radius;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadius = BorderRadius.circular(widget.radius);

    Widget surface = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: isDark
            ? null
            : const [
                BoxShadow(
                  color: Color(0x14111827), // ~8% slate
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
                BoxShadow(
                  color: Color(0x0A111827), // faint ambient
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
      ),
      child: Material(
        color: context.cCard,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        shape: isDark
            ? RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(color: context.cBorder),
              )
            : null,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );

    if (widget.onTap != null) {
      // Listener is passive — it reads pointer events for the press-scale
      // without claiming the gesture, so InkWell still fires the tap + ripple.
      surface = Listener(
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: AnimatedScale(
          scale: _pressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 110),
          curve: Curves.easeOut,
          child: surface,
        ),
      );
    }

    return Padding(padding: widget.margin, child: surface);
  }
}

/// Small tinted square that holds a leading icon — the Airbnb-style "chip"
/// used on list rows and module tiles.
class AppIconChip extends StatelessWidget {
  const AppIconChip({
    required this.icon,
    this.color = AppColors.primaryAccent,
    this.size = 44,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}
