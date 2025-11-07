import '../models/meal_plan.dart';
import '../models/meal.dart';

class MealPlanRepository {
  MealPlan? _currentMealPlan;

  MealPlan? getCurrentMealPlan() {
    return _currentMealPlan;
  }

  void setMealPlan(MealPlan mealPlan) {
    _currentMealPlan = mealPlan;
  }

  List<Meal> getMealsForDate(DateTime date) {
    if (_currentMealPlan == null) return [];

    final dayOfWeek = date.weekday;
    return _currentMealPlan!.meals
        .where((meal) => meal.dayOfWeek == dayOfWeek)
        .toList()
      ..sort((a, b) => a.timeScheduled.compareTo(b.timeScheduled));
  }

  List<Meal> getMealsForWeek(DateTime weekStart, DateTime weekEnd) {
    if (_currentMealPlan == null) return [];

    final meals = <Meal>[];
    for (var date = weekStart;
        date.isBefore(weekEnd.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      meals.addAll(getMealsForDate(date));
    }
    return meals;
  }

  Meal? getMealById(String mealId) {
    if (_currentMealPlan == null) return null;
    try {
      return _currentMealPlan!.meals.firstWhere(
        (meal) => meal.id == mealId,
      );
    } catch (_) {
      return null;
    }
  }
}
