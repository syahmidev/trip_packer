import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forui/forui.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Root widget. Material drives routing/inputs; Forui's [FTheme] wraps every
/// page so Forui design-system components can be dropped into any screen.
class TripPackerApp extends StatelessWidget {
  const TripPackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TripPacker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.materialLight,
      darkTheme: AppTheme.materialDark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      localizationsDelegates: const [
        FLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: FLocalizations.supportedLocales,
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return FTheme(
          data: isDark ? AppTheme.foruiDark : AppTheme.foruiLight,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
