import 'package:tona_mvp/l10n/app_localizations.dart';

String relativeTimeLabel(Duration difference, AppLocalizations localizations) {
  final isFuture = !difference.isNegative;
  final absolute = difference.abs();

  if (absolute.inMinutes == 0) {
    return isFuture
        ? localizations.time_underMinuteFuture
        : localizations.time_underMinutePast;
  }

  if (absolute.inMinutes < 60) {
    final minutes = absolute.inMinutes;
    return isFuture
        ? localizations.time_minutesFuture(minutes)
        : localizations.time_minutesPast(minutes);
  }

  final hours = absolute.inHours;
  final minutes = absolute.inMinutes % 60;

  if (minutes == 0) {
    return isFuture
        ? localizations.time_hoursFuture(hours)
        : localizations.time_hoursPast(hours);
  }

  return isFuture
      ? localizations.time_hoursMinutesFuture(hours, minutes)
      : localizations.time_hoursMinutesPast(hours, minutes);
}
