import 'daily_progress.dart';

class WeeklyProgress {
  final DateTime weekStartDate;
  final DateTime weekEndDate;
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final double adherencePercentage;
  final Map<int, DailyProgress> dailyProgress;

  const WeeklyProgress({
    required this.weekStartDate,
    required this.weekEndDate,
    required this.totalMeals,
    required this.mealsFollowed,
    required this.mealsWithAlternatives,
    required this.adherencePercentage,
    required this.dailyProgress,
  });
}

