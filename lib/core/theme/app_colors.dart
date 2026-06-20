import 'package:flutter/material.dart';

/// Centralised colour palette for TripPacker, taken from the project plan
/// (section 7 — UI Direction).
abstract final class AppColors {
  static const Color background = Color(0xFFFAF8F3);
  static const Color card = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF111827);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color primaryAccent = Color(0xFF2F6F68);
  static const Color warmAccent = Color(0xFFC17C3A);
  static const Color border = Color(0xFFE5E1D8);
  static const Color success = Color(0xFF3F7D58);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);

  // Dark mode counterparts (approximate, tuned later in the Polish phase).
  static const Color darkBackground = Color(0xFF14110D);
  static const Color darkCard = Color(0xFF1F1B16);
  static const Color darkPrimaryText = Color(0xFFF5F3EE);
  static const Color darkSecondaryText = Color(0xFF9CA3AF);
  static const Color darkBorder = Color(0xFF332D25);
}
