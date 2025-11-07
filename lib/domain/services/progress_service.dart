import '../../data/models/daily_progress.dart';
import '../../data/models/meal_log_status.dart';
import '../../data/models/weekly_progress.dart';
import '../../data/repositories/meal_log_repository.dart';
import '../../data/repositories/meal_plan_repository.dart';
import '../../core/utils/adherence_utils.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/time_provider.dart';

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
    final todayDate = DateUtils.getDateOnly(date);
    final now = TimeProvider.now();

    final totalMeals = meals.length;
    final mealsFollowed =
        logs.where((log) => log.status == MealLogStatus.followed).length;
    final mealsWithAlternatives =
        logs.where((log) => log.status == MealLogStatus.alternative).length;
    final mealsSkipped =
        logs.where((log) => log.status == MealLogStatus.skipped).length;
    final mealsLogged = logs.length;

    final adherence = AdherenceUtils.evaluate(
      date: todayDate,
      meals: meals,
      logs: logs,
      now: now,
    );

    return DailyProgress(
      dayOfWeek: date.weekday,
      date: todayDate,
      totalMeals: totalMeals,
      mealsFollowed: mealsFollowed,
      mealsWithAlternatives: mealsWithAlternatives,
      mealsSkipped: mealsSkipped,
      mealsLogged: mealsLogged,
      adherencePercentage: adherence.adherencePercentage,
      dueMeals: adherence.dueMeals,
      unloggedDueMeals: adherence.unloggedDueMeals,
      mealLogs: logs,
    );
  }

  WeeklyProgress calculateWeeklyProgress(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 6));

    final dailyProgress = <int, DailyProgress>{};
    var totalMeals = 0;
    var mealsFollowed = 0;
    var mealsWithAlternatives = 0;
    var mealsSkipped = 0;
    var mealsLogged = 0;
    var dueMeals = 0;
    var unloggedDueMeals = 0;

    for (var i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      final dayOfWeek = date.weekday;
      final daily = calculateDailyProgress(date);
      dailyProgress[dayOfWeek] = daily;

      totalMeals += daily.totalMeals;
      mealsFollowed += daily.mealsFollowed;
      mealsWithAlternatives += daily.mealsWithAlternatives;
      mealsSkipped += daily.mealsSkipped;
      mealsLogged += daily.mealsLogged;
      dueMeals += daily.dueMeals;
      unloggedDueMeals += daily.unloggedDueMeals;
    }

    final adherencePercentage = dueMeals == 0
        ? 100.0
        : ((dueMeals - unloggedDueMeals) / dueMeals) * 100;

    return WeeklyProgress(
      weekStartDate: weekStart,
      weekEndDate: weekEnd,
      totalMeals: totalMeals,
      mealsFollowed: mealsFollowed,
      mealsWithAlternatives: mealsWithAlternatives,
      mealsSkipped: mealsSkipped,
      mealsLogged: mealsLogged,
      adherencePercentage: adherencePercentage,
      dueMeals: dueMeals,
      unloggedDueMeals: unloggedDueMeals,
      dailyProgress: dailyProgress,
    );
  }
}
