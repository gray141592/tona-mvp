import 'package:flutter/foundation.dart';
import '../../data/models/meal_plan.dart';
import '../../data/models/meal.dart';
import '../../data/repositories/meal_plan_repository.dart';

class MealPlanProvider extends ChangeNotifier {
  final MealPlanRepository _repository;

  MealPlanProvider(this._repository);

  MealPlan? get currentMealPlan => _repository.getCurrentMealPlan();

  void loadMealPlan(MealPlan mealPlan) {
    _repository.setMealPlan(mealPlan);
    notifyListeners();
  }

  List<Meal> getMealsForDate(DateTime date) {
    return _repository.getMealsForDate(date);
  }

  Meal? getMealById(String mealId) {
    return _repository.getMealById(mealId);
  }
}
