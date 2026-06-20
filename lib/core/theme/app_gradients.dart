import 'package:flutter/widgets.dart';

/// Curated gradient palette for trip cover art (plan Phase 11 — visual polish).
///
/// Each pair is tuned to carry white text. A trip is assigned one
/// deterministically from its id, so its cover and avatar always match and the
/// trip list reads like a set of colourful listings rather than one flat colour.
abstract final class AppGradients {
  static const List<List<Color>> _pairs = [
    [Color(0xFF357A72), Color(0xFF1E4A45)], // teal
    [Color(0xFFC1714A), Color(0xFF8A4A2B)], // terracotta
    [Color(0xFF5B6CB8), Color(0xFF3A468A)], // indigo
    [Color(0xFF9B5A8A), Color(0xFF6E3A63)], // plum
    [Color(0xFF4F7C5A), Color(0xFF31543B)], // forest
    [Color(0xFFC2993B), Color(0xFF8F6E1E)], // ochre
    [Color(0xFF4A8C9B), Color(0xFF2C5C68)], // ocean
    [Color(0xFFB85C6E), Color(0xFF84404E)], // rose
  ];

  static List<Color> colorsFor(int seed) => _pairs[seed.abs() % _pairs.length];

  static LinearGradient of(int seed) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: colorsFor(seed),
  );
}
