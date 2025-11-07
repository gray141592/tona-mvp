import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  static String formatDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String formatShortDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  static DateTime getWeekStart(DateTime date) {
    final dayOfWeek = date.weekday;
    return date.subtract(Duration(days: dayOfWeek - 1));
  }

  static DateTime getWeekEnd(DateTime date) {
    final weekStart = getWeekStart(date);
    return weekStart.add(const Duration(days: 6));
  }

  static DateTime combineDateWithTimeString(DateTime date, String timeString) {
    final normalized = timeString.trim();
    if (normalized.isEmpty) {
      return DateTime(date.year, date.month, date.day);
    }

    final parts = normalized.split(':');
    if (parts.length < 2) {
      return DateTime(date.year, date.month, date.day);
    }

    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;

    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static DateTime getDateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
