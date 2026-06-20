import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds the Forui themes and the Material themes for TripPacker.
///
/// Forui drives the design-system look (cards, buttons, forms), while the
/// Material [ThemeData] is kept in sync so any Material widgets used during the
/// build (e.g. [TextFormField]) inherit the same warm palette and typography.
abstract final class AppTheme {
  /// Plus Jakarta Sans, per the plan's font recommendation.
  static TextTheme _textTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? ThemeData.light().textTheme
        : ThemeData.dark().textTheme;
    return GoogleFonts.plusJakartaSansTextTheme(base);
  }

  static FThemeData get foruiLight => FThemeData(
    touch: true,
    colors: FColors.zincLight.copyWith(
      background: AppColors.background,
      foreground: AppColors.primaryText,
      card: AppColors.card,
      border: AppColors.border,
      primary: AppColors.primaryAccent,
      primaryForeground: Colors.white,
      mutedForeground: AppColors.secondaryText,
      error: AppColors.danger,
    ),
  );

  static FThemeData get foruiDark => FThemeData(
    touch: true,
    colors: FColors.zincDark.copyWith(
      background: AppColors.darkBackground,
      foreground: AppColors.darkPrimaryText,
      card: AppColors.darkCard,
      border: AppColors.darkBorder,
      primary: AppColors.primaryAccent,
      primaryForeground: Colors.white,
      mutedForeground: AppColors.darkSecondaryText,
      error: AppColors.danger,
    ),
  );

  static ThemeData get materialLight {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryAccent,
      brightness: Brightness.light,
    ).copyWith(surface: AppColors.card, error: AppColors.danger);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme(Brightness.light),
    );
  }

  static ThemeData get materialDark {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryAccent,
      brightness: Brightness.dark,
    ).copyWith(surface: AppColors.darkCard, error: AppColors.danger);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _textTheme(Brightness.dark),
    );
  }
}
