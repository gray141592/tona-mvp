import '../models/client.dart';
import '../models/meal_plan.dart';
import '../models/meal.dart';
import '../models/meal_type.dart';
import '../../core/constants/app_constants.dart';

class MockData {
  static Client getMockClient() {
    return Client(
      id: AppConstants.mockClientId,
      name: 'Sarah Johnson',
      email: 'sarah@example.com',
      nutritionistId: 'nutr_001',
      mealPlanId: AppConstants.mockMealPlanId,
      createdAt: DateTime(2024, 1, 8),
      lastActiveAt: DateTime.now(),
    );
  }

  static MealPlan getMockMealPlan() {
    final startDate = DateTime.now().subtract(const Duration(days: 7));
    final endDate = startDate.add(const Duration(days: 6));
    
    final meals = <Meal>[];
    
    for (var day = 1; day <= 7; day++) {
      meals.addAll(_getDayMeals(day));
    }
    
    return MealPlan(
      id: AppConstants.mockMealPlanId,
      clientId: AppConstants.mockClientId,
      name: 'Week 1 Meal Plan',
      startDate: startDate,
      endDate: endDate,
      meals: meals,
    );
  }

  static List<Meal> _getDayMeals(int dayOfWeek) {
    final planId = AppConstants.mockMealPlanId;
    
    return [
      Meal(
        id: 'meal_${dayOfWeek}_breakfast',
        mealPlanId: planId,
        dayOfWeek: dayOfWeek,
        mealType: MealType.breakfast,
        name: 'Oatmeal with Berries',
        description: '1 cup cooked oatmeal, 1/2 cup mixed berries, 1 tbsp almond butter',
        ingredients: [
          '1 cup cooked oatmeal',
          '1/2 cup mixed berries',
          '1 tbsp almond butter',
        ],
        timeScheduled: '08:00',
      ),
      Meal(
        id: 'meal_${dayOfWeek}_snack1',
        mealPlanId: planId,
        dayOfWeek: dayOfWeek,
        mealType: MealType.snack1,
        name: 'Apple with Almond Butter',
        description: '1 medium apple, 1 tbsp almond butter',
        ingredients: [
          '1 medium apple',
          '1 tbsp almond butter',
        ],
        timeScheduled: '10:00',
      ),
      Meal(
        id: 'meal_${dayOfWeek}_lunch',
        mealPlanId: planId,
        dayOfWeek: dayOfWeek,
        mealType: MealType.lunch,
        name: 'Grilled Chicken Salad',
        description: '4oz grilled chicken, mixed greens, vegetables, olive oil dressing',
        ingredients: [
          '4oz grilled chicken',
          'mixed greens',
          'vegetables',
          'olive oil dressing',
        ],
        timeScheduled: '13:00',
      ),
      Meal(
        id: 'meal_${dayOfWeek}_snack2',
        mealPlanId: planId,
        dayOfWeek: dayOfWeek,
        mealType: MealType.snack2,
        name: 'Greek Yogurt',
        description: '1 cup plain Greek yogurt, 1/4 cup berries',
        ingredients: [
          '1 cup plain Greek yogurt',
          '1/4 cup berries',
        ],
        timeScheduled: '16:00',
      ),
      Meal(
        id: 'meal_${dayOfWeek}_dinner',
        mealPlanId: planId,
        dayOfWeek: dayOfWeek,
        mealType: MealType.dinner,
        name: 'Baked Salmon with Vegetables',
        description: '5oz salmon, roasted broccoli and sweet potato',
        ingredients: [
          '5oz salmon',
          'roasted broccoli',
          'sweet potato',
        ],
        timeScheduled: '19:00',
      ),
    ];
  }
}

