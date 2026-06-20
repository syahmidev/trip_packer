/// Small date helpers shared by the form sheets (plan Phase 11 — validation).
abstract final class AppDateUtils {
  /// Clamps [value] into the inclusive `[min, max]` range. A null bound means
  /// that side is unconstrained. Used to keep a picker's `initialDate` valid
  /// when defaults (e.g. "today") fall outside a trip's date range.
  static DateTime clamp(DateTime value, {DateTime? min, DateTime? max}) {
    var result = value;
    if (min != null && result.isBefore(min)) result = min;
    if (max != null && result.isAfter(max)) result = max;
    return result;
  }
}
