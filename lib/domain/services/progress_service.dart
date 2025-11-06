import '../../data/models/weekly_progress.dart';
import '../../data/models/daily_progress.dart';
import '../../data/models/meal_log_status.dart';
import '../../data/repositories/meal_plan_repository.dart';
import '../../data/repositories/meal_log_repository.dart';
import '../../core/utils/date_utils.dart';

class ProgressService {
  final MealPlanRepository mealPlanRepository;
  final MealLogRepository mealLogRepository;

  ProgressService({
    required this.mealPlanRepository,
    required this.mealLogRepository,
  });

  DailyProgress calculateDailyProgress(DateTime date) {
    final meals = mealPlanRepository.getMealsForDate(date);
    final logs = mealLogRepository.getLogsForDate(date);
    
    final totalMeals = meals.length;
    final mealsFollowed = logs.where(
      (log) => log.status == MealLogStatus.followed,
    ).length;
    final mealsWithAlternatives = logs.where(
      (log) => log.status == MealLogStatus.alternative,
    ).length;
    
    final adherencePercentage = totalMeals > 0
        ? (mealsFollowed / totalMeals) * 100
        : 0.0;
    
    return DailyProgress(
      dayOfWeek: date.weekday,
      date: DateUtils.getDateOnly(date),
      totalMeals: totalMeals,
      mealsFollowed: mealsFollowed,
      mealsWithAlternatives: mealsWithAlternatives,
      adherencePercentage: adherencePercentage,
      mealLogs: logs,
    );
  }

  WeeklyProgress calculateWeeklyProgress(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final meals = mealPlanRepository.getMealsForWeek(weekStart, weekEnd);
    final logs = mealLogRepository.getLogsForWeek(weekStart, weekEnd);
    
    final totalMeals = meals.length;
    final mealsFollowed = logs.where(
      (log) => log.status == MealLogStatus.followed,
    ).length;
    final mealsWithAlternatives = logs.where(
      (log) => log.status == MealLogStatus.alternative,
    ).length;
    
    final adherencePercentage = totalMeals > 0
        ? (mealsFollowed / totalMeals) * 100
        : 0.0;
    
    final dailyProgress = <int, DailyProgress>{};
    for (var i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      final dayOfWeek = date.weekday;
      dailyProgress[dayOfWeek] = calculateDailyProgress(date);
    }
    
    return WeeklyProgress(
      weekStartDate: weekStart,
      weekEndDate: weekEnd,
      totalMeals: totalMeals,
      mealsFollowed: mealsFollowed,
      mealsWithAlternatives: mealsWithAlternatives,
      adherencePercentage: adherencePercentage,
      dailyProgress: dailyProgress,
    );
  }
}

