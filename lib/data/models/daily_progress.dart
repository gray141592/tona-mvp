import 'meal_log.dart';

class DailyProgress {
  final int dayOfWeek;
  final DateTime date;
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final double adherencePercentage;
  final List<MealLog> mealLogs;

  const DailyProgress({
    required this.dayOfWeek,
    required this.date,
    required this.totalMeals,
    required this.mealsFollowed,
    required this.mealsWithAlternatives,
    required this.adherencePercentage,
    required this.mealLogs,
  });
}

