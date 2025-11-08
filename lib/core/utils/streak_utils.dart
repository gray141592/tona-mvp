import '../../data/models/meal_log.dart';

class StreakUtils {
  const StreakUtils._();

  static DateTime combineLogDateTime(MealLog log) {
    final date = log.loggedDate;
    final time = log.loggedTime;
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
      time.second,
      time.millisecond,
      time.microsecond,
    );
  }

  static String formatLongestStreakLabel(
    int dayStreak,
    int mealStreak,
  ) {
    if (dayStreak >= 14) {
      final weeks = dayStreak ~/ 7;
      final remainingDays = dayStreak % 7;
      final weekLabel = '$weeks ${weeks == 1 ? 'week' : 'weeks'}';
      if (remainingDays == 0) {
        return '$weekLabel total adherence with the plan';
      }
      final dayLabel =
          '$remainingDays ${remainingDays == 1 ? 'day' : 'days'} on plan';
      return '$weekLabel + $dayLabel';
    }

    if (dayStreak >= 1) {
      return '$dayStreak ${dayStreak == 1 ? 'day' : 'days'} streak';
    }

    if (mealStreak >= 1) {
      return '$mealStreak ${mealStreak == 1 ? 'meal' : 'meals'} streak!';
    }

    return 'Let\'s make a streak!';
  }

  static String formatLongestStreakHeadline(
    int dayStreak,
    int mealStreak,
  ) {
    if (dayStreak >= 14) {
      final weeks = dayStreak ~/ 7;
      final remainingDays = dayStreak % 7;
      final weekLabel = '$weeks ${weeks == 1 ? 'week' : 'weeks'}';
      if (remainingDays == 0) {
        return weekLabel;
      }
      final dayLabel =
          '$remainingDays ${remainingDays == 1 ? 'day' : 'days'}';
      return '$weekLabel + $dayLabel';
    }

    if (dayStreak >= 1) {
      return '$dayStreak ${dayStreak == 1 ? 'day' : 'days'}';
    }

    if (mealStreak >= 1) {
      return '$mealStreak ${mealStreak == 1 ? 'meal' : 'meals'}';
    }

    return 'No streak yet';
  }

  static bool hasStreak(int dayStreak, int mealStreak) {
    return dayStreak > 0 || mealStreak > 0;
  }
}

