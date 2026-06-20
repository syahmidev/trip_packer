import 'package:flutter_test/flutter_test.dart';
import 'package:trip_packer/core/utils/date_utils.dart';

void main() {
  group('AppDateUtils.clamp', () {
    final start = DateTime(2026, 7, 3);
    final end = DateTime(2026, 7, 16);

    test('returns the value when already inside the range', () {
      final v = DateTime(2026, 7, 10);
      expect(AppDateUtils.clamp(v, min: start, max: end), v);
    });

    test('snaps up to min when before the range', () {
      expect(AppDateUtils.clamp(DateTime(2026, 1, 1), min: start, max: end),
          start);
    });

    test('snaps down to max when after the range', () {
      expect(AppDateUtils.clamp(DateTime(2026, 12, 1), min: start, max: end),
          end);
    });

    test('leaves the value untouched when bounds are null', () {
      final v = DateTime(2026, 1, 1);
      expect(AppDateUtils.clamp(v), v);
    });
  });
}
