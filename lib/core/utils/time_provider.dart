class TimeProvider {
  static DateTime? _overrideNow = DateTime(2025, 11, 6, 17, 0, 0);

  TimeProvider._();

  /// Returns the current time, respecting any active override.
  static DateTime now() {
    return _overrideNow ?? DateTime.now();
  }

  /// Sets an override for the current time. Pass `null` to clear the override.
  static void setOverride(DateTime? dateTime) {
    _overrideNow = dateTime;
  }

  /// Whether the current time is currently being overridden.
  static bool get isOverridden => _overrideNow != null;
}
