import '../models/meal_log.dart';
import '../../core/utils/date_utils.dart';

class MealLogRepository {
  final List<MealLog> _logs = [];

  Future<void> saveMealLog(MealLog log) async {
    _logs.removeWhere((l) => l.mealId == log.mealId && 
        DateUtils.isSameDay(l.loggedDate, log.loggedDate),
    );
    _logs.add(log);
    _logs.sort((a, b) => b.loggedTime.compareTo(a.loggedTime));
  }

  List<MealLog> getLogsForDate(DateTime date) {
    return _logs.where((log) => DateUtils.isSameDay(log.loggedDate, date)).toList();
  }

  List<MealLog> getLogsForWeek(DateTime weekStart, DateTime weekEnd) {
    return _logs.where((log) {
      return log.loggedDate.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          log.loggedDate.isBefore(weekEnd.add(const Duration(days: 1)));
    }).toList();
  }

  List<MealLog> getLogsForDateRange(DateTime startDate, DateTime endDate) {
    return _logs.where((log) {
      return log.loggedDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          log.loggedDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  MealLog? getLogForMeal(String mealId, DateTime date) {
    try {
      return _logs.firstWhere(
        (log) => log.mealId == mealId && DateUtils.isSameDay(log.loggedDate, date),
      );
    } catch (_) {
      return null;
    }
  }

  bool hasLoggedMeal(String mealId, DateTime date) {
    return getLogForMeal(mealId, date) != null;
  }
}

