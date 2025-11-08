import '../../../data/models/meal.dart';
import '../../../data/models/meal_log.dart';

enum MealTimelineState {
  upcomingFar,
  upcomingSoon,
  dueNow,
  overdue,
  logged,
}

class MealTimelineEntry {
  final Meal meal;
  final MealLog? log;
  final DateTime scheduledTime;
  final MealTimelineState state;
  final Duration timeDifference;

  const MealTimelineEntry({
    required this.meal,
    required this.log,
    required this.scheduledTime,
    required this.state,
    required this.timeDifference,
  });
}

class DashboardMealLogEntry {
  final Meal? meal;
  final MealLog log;

  const DashboardMealLogEntry({
    this.meal,
    required this.log,
  });

  String get mealName {
    if (meal != null) {
      return meal!.name;
    }
    // For unplanned meals, use the alternativeMeal name
    return log.alternativeMeal ?? 'Unplanned meal';
  }
}
