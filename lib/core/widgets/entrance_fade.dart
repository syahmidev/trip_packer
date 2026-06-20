import 'package:flutter/widgets.dart';

/// Staggered fade + slide-up entrance for list items (plan Phase 11 — polish).
///
/// Plays once when the item first mounts. In a `ListView.builder` the [State]
/// is reused per position, so data changes (e.g. a toggle) don't replay it.
/// [index] staggers the start; it's capped so long lists don't delay forever.
class EntranceFade extends StatefulWidget {
  const EntranceFade({required this.child, this.index = 0, super.key});

  final Widget child;
  final int index;

  @override
  State<EntranceFade> createState() => _EntranceFadeState();
}

class _EntranceFadeState extends State<EntranceFade>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 380),
  );
  late final Animation<double> _anim = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    final delayMs = widget.index.clamp(0, 8) * 55;
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, (1 - _anim.value) * 16),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
