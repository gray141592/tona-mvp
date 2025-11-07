import 'meal_log.dart';

class DailyProgress {
  final int dayOfWeek;
  final DateTime date;
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final int mealsSkipped;
  final int mealsLogged;
  final double adherencePercentage;
  final int dueMeals;
  final int unloggedDueMeals;
  final List<MealLog> mealLogs;

  const DailyProgress({
    required this.dayOfWeek,
    required this.date,
    required this.totalMeals,
    required this.mealsFollowed,
    required this.mealsWithAlternatives,
    required this.mealsSkipped,
    required this.mealsLogged,
    required this.adherencePercentage,
    required this.dueMeals,
    required this.unloggedDueMeals,
    required this.mealLogs,
  });
}
