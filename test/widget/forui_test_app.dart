import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:trip_packer/core/theme/app_theme.dart';

/// Wraps a screen in the same Material + Forui ([FTheme]) + localizations setup
/// the real app provides, so Forui widgets (FScaffold, FHeader, FButton) have
/// the ancestors they require during widget tests.
class ForuiTestApp extends StatelessWidget {
  const ForuiTestApp({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.materialLight,
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      home: FTheme(data: AppTheme.foruiLight, child: child),
    );
  }
}
