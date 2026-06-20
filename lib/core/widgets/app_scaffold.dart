import 'package:flutter/material.dart' show Material, MaterialType;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

/// Shared Forui page chrome (plan Phase 11 — Forui restyle).
///
/// Wraps [FScaffold] + [FHeader.nested] so every screen gets the Forui look and
/// inherits light/dark colours from [FTheme]. An optional [footer] hosts the
/// primary action (Forui scaffolds have no Material FAB).
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    required this.child,
    this.suffixes = const [],
    this.footer,
    this.showBack = true,
    super.key,
  });

  final String title;
  final Widget child;
  final List<Widget> suffixes;
  final Widget? footer;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: Text(title),
        prefixes: [
          if (showBack) FHeaderAction.back(onPress: () => context.pop()),
        ],
        suffixes: suffixes,
      ),
      footer: footer,
      // Transparent Material so Material content (ListTile, InkWell, Checkbox)
      // still finds a Material ancestor under the Forui scaffold.
      child: Material(type: MaterialType.transparency, child: child),
    );
  }
}
