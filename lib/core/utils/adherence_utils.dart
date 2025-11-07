import '../../data/models/meal.dart';
import '../../data/models/meal_log.dart';
import 'date_utils.dart';

class AdherenceMetrics {
  final int dueMeals;
  final int unloggedDueMeals;
  final double adherencePercentage;

  const AdherenceMetrics({
    required this.dueMeals,
    required this.unloggedDueMeals,
    required this.adherencePercentage,
  });
}

class AdherenceUtils {
  const AdherenceUtils._();

  static AdherenceMetrics evaluate({
    required DateTime date,
    required Iterable<Meal> meals,
    required Iterable<MealLog> logs,
    required DateTime now,
  }) {
    final dateOnly = DateUtils.getDateOnly(date);
    final logsByMealId = {
      for (final log in logs) log.mealId: log,
    };

    var dueMeals = 0;
    var unloggedDueMeals = 0;

    for (final meal in meals) {
      final scheduled =
          DateUtils.combineDateWithTimeString(dateOnly, meal.timeScheduled);
      if (!scheduled.isBefore(now)) {
        continue;
      }

      dueMeals++;
      if (!logsByMealId.containsKey(meal.id)) {
        unloggedDueMeals++;
      }
    }

    final adherencePercentage = dueMeals == 0
        ? 100.0
        : ((dueMeals - unloggedDueMeals) / dueMeals) * 100;

    return AdherenceMetrics(
      dueMeals: dueMeals,
      unloggedDueMeals: unloggedDueMeals,
      adherencePercentage: adherencePercentage,
    );
  }
}
