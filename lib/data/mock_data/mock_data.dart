import '../models/client.dart';
import '../models/meal_plan.dart';
import '../models/meal.dart';
import '../models/meal_type.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/time_provider.dart';

class MockData {
  static Client getMockClient() {
    return Client(
      id: AppConstants.mockClientId,
      name: 'Sarah Johnson',
      email: 'sarah@example.com',
      nutritionistId: 'nutr_001',
      mealPlanId: AppConstants.mockMealPlanId,
      createdAt: DateTime(2024, 1, 8),
      lastActiveAt: TimeProvider.now(),
    );
  }

  static MealPlan getMockMealPlan() {
    final startDate = TimeProvider.now().subtract(const Duration(days: 7));
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

    switch (dayOfWeek) {
      case 1: // Monday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: 'Oatmeal with Berries',
            description:
                '1 cup cooked oatmeal, 1/2 cup mixed berries, 1 tbsp almond butter, honey drizzle',
            ingredients: [
              '1 cup cooked oatmeal',
              '1/2 cup mixed berries',
              '1 tbsp almond butter',
              '1 tsp honey',
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
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: 'Grilled Chicken Salad',
            description:
                '4oz grilled chicken breast, mixed greens, cherry tomatoes, cucumber, olive oil dressing',
            ingredients: [
              '4oz grilled chicken breast',
              '2 cups mixed greens',
              '1/2 cup cherry tomatoes',
              '1/2 cucumber',
              '2 tbsp olive oil dressing',
            ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: 'Greek Yogurt with Berries',
            description: '1 cup plain Greek yogurt, 1/4 cup mixed berries',
            ingredients: [
              '1 cup plain Greek yogurt',
              '1/4 cup mixed berries',
            ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: 'Baked Salmon with Vegetables',
            description: '5oz salmon fillet, roasted broccoli and sweet potato',
            ingredients: [
              '5oz salmon fillet',
              '1 cup roasted broccoli',
              '1 medium sweet potato',
              'lemon wedge',
            ],
            timeScheduled: '19:00',
          ),
        ];

      case 2: // Tuesday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: 'Scrambled Eggs with Avocado Toast',
            description:
                '2 eggs scrambled, 1 slice whole grain toast, 1/2 avocado, cherry tomatoes',
            ingredients: [
              '2 large eggs',
              '1 slice whole grain bread',
              '1/2 avocado',
              '4 cherry tomatoes',
            ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: 'Protein Smoothie',
            description: 'Banana, protein powder, almond milk, spinach',
            ingredients: [
              '1 banana',
              '1 scoop protein powder',
              '1 cup almond milk',
              '1 cup spinach',
            ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: 'Turkey Wrap with Hummus',
            description:
                'Whole wheat tortilla, 4oz turkey breast, hummus, lettuce, peppers',
            ingredients: [
              '1 whole wheat tortilla',
              '4oz sliced turkey breast',
              '2 tbsp hummus',
              'lettuce',
              '1/4 cup sliced bell peppers',
            ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: 'Carrot Sticks with Hummus',
            description: '1 cup carrot sticks, 1/4 cup hummus',
            ingredients: [
              '1 cup carrot sticks',
              '1/4 cup hummus',
            ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: 'Chicken Stir-Fry',
            description:
                '5oz chicken breast, mixed vegetables, brown rice, teriyaki sauce',
            ingredients: [
              '5oz chicken breast',
              '2 cups mixed vegetables',
              '1 cup brown rice',
              '2 tbsp teriyaki sauce',
            ],
            timeScheduled: '19:00',
          ),
        ];

      case 3: // Wednesday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: 'Greek Yogurt Parfait',
            description:
                'Greek yogurt layered with granola, berries, and honey',
            ingredients: [
              '1 cup Greek yogurt',
              '1/2 cup granola',
              '1/2 cup mixed berries',
              '1 tsp honey',
            ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: 'Mixed Nuts',
            description: '1/4 cup mixed almonds, cashews, and walnuts',
            ingredients: [
              '1/4 cup mixed nuts',
            ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: 'Quinoa Buddha Bowl',
            description:
                'Quinoa, roasted chickpeas, avocado, vegetables, tahini dressing',
            ingredients: [
              '1 cup cooked quinoa',
              '1/2 cup roasted chickpeas',
              '1/2 avocado',
              '1 cup mixed vegetables',
              '2 tbsp tahini dressing',
            ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: 'Cottage Cheese with Pineapple',
            description:
                '1 cup low-fat cottage cheese, 1/2 cup pineapple chunks',
            ingredients: [
              '1 cup low-fat cottage cheese',
              '1/2 cup pineapple chunks',
            ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: 'Lean Beef Tacos',
            description:
                'Lean ground beef, corn tortillas, lettuce, tomato, salsa',
            ingredients: [
              '5oz lean ground beef',
              '2 corn tortillas',
              'shredded lettuce',
              '1 diced tomato',
              '2 tbsp salsa',
            ],
            timeScheduled: '19:00',
          ),
        ];

      case 4: // Thursday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: 'Whole Grain Pancakes',
            description: '2 whole grain pancakes, fresh berries, maple syrup',
            ingredients: [
              '2 whole grain pancakes',
              '1/2 cup fresh berries',
              '1 tbsp maple syrup',
            ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: 'Pear with String Cheese',
            description: '1 medium pear, 1 string cheese',
            ingredients: [
              '1 medium pear',
              '1 string cheese',
            ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: 'Tuna Salad',
            description:
                'Tuna, mixed greens, hard-boiled egg, olives, olive oil',
            ingredients: [
              '1 can tuna in water',
              '2 cups mixed greens',
              '1 hard-boiled egg',
              '5 olives',
              '2 tbsp olive oil',
            ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: 'Protein Bar',
            description: '1 protein bar (aim for 10g+ protein)',
            ingredients: [
              '1 protein bar',
            ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: 'Baked Chicken with Quinoa',
            description:
                'Herb-crusted chicken breast, quinoa, roasted asparagus',
            ingredients: [
              '5oz chicken breast',
              '1 cup cooked quinoa',
              '1 cup roasted asparagus',
              'herbs and spices',
            ],
            timeScheduled: '19:00',
          ),
        ];

      case 5: // Friday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: 'Veggie Omelet',
            description:
                '3-egg omelet with spinach, mushrooms, and feta cheese',
            ingredients: [
              '3 large eggs',
              '1 cup spinach',
              '1/2 cup mushrooms',
              '2 tbsp feta cheese',
            ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: 'Banana with Peanut Butter',
            description: '1 medium banana, 1 tbsp peanut butter',
            ingredients: [
              '1 medium banana',
              '1 tbsp peanut butter',
            ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: 'Mediterranean Chicken Bowl',
            description:
                'Grilled chicken, brown rice, hummus, cucumber, tomatoes, olives',
            ingredients: [
              '4oz grilled chicken',
              '1 cup brown rice',
              '2 tbsp hummus',
              '1/2 cucumber',
              '1/2 cup tomatoes',
              '5 olives',
            ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: 'Rice Cakes with Avocado',
            description: '2 rice cakes topped with mashed avocado',
            ingredients: [
              '2 rice cakes',
              '1/2 avocado',
            ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: 'Shrimp Pasta Primavera',
            description:
                'Whole wheat pasta, shrimp, mixed vegetables, garlic olive oil',
            ingredients: [
              '2oz whole wheat pasta',
              '5oz shrimp',
              '2 cups mixed vegetables',
              '2 tbsp garlic olive oil',
            ],
            timeScheduled: '19:00',
          ),
        ];

      case 6: // Saturday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: 'Breakfast Burrito',
            description:
                'Scrambled eggs, black beans, cheese, salsa in whole wheat tortilla',
            ingredients: [
              '2 scrambled eggs',
              '1/4 cup black beans',
              '2 tbsp shredded cheese',
              '2 tbsp salsa',
              '1 whole wheat tortilla',
            ],
            timeScheduled: '09:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: 'Trail Mix',
            description: 'Mixed nuts, dried cranberries, dark chocolate chips',
            ingredients: [
              '1/4 cup mixed nuts',
              '2 tbsp dried cranberries',
              '1 tbsp dark chocolate chips',
            ],
            timeScheduled: '11:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: 'Grilled Veggie Sandwich',
            description:
                'Grilled zucchini, peppers, mozzarella on whole grain bread',
            ingredients: [
              '2 slices whole grain bread',
              '1/2 grilled zucchini',
              '1/4 cup grilled peppers',
              '2 slices fresh mozzarella',
              'balsamic glaze',
            ],
            timeScheduled: '13:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: 'Edamame',
            description: '1 cup steamed edamame with sea salt',
            ingredients: [
              '1 cup edamame',
              'sea salt to taste',
            ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: 'Grilled Steak with Vegetables',
            description:
                'Lean sirloin steak, roasted Brussels sprouts and carrots',
            ingredients: [
              '5oz lean sirloin steak',
              '1 cup roasted Brussels sprouts',
              '1 cup roasted carrots',
            ],
            timeScheduled: '19:30',
          ),
        ];

      case 7: // Sunday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: 'French Toast with Fruit',
            description:
                'Whole grain French toast, fresh berries, yogurt drizzle',
            ingredients: [
              '2 slices whole grain bread',
              '1 egg',
              '1/2 cup mixed berries',
              '2 tbsp Greek yogurt',
              'cinnamon',
            ],
            timeScheduled: '09:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: 'Celery with Peanut Butter',
            description: '4 celery sticks with 2 tbsp peanut butter',
            ingredients: [
              '4 celery sticks',
              '2 tbsp peanut butter',
            ],
            timeScheduled: '11:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: 'Chicken Caesar Salad',
            description:
                'Grilled chicken, romaine lettuce, parmesan, light Caesar dressing',
            ingredients: [
              '4oz grilled chicken breast',
              '2 cups romaine lettuce',
              '2 tbsp parmesan cheese',
              '2 tbsp light Caesar dressing',
              'whole grain croutons',
            ],
            timeScheduled: '13:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: 'Smoothie Bowl',
            description:
                'Blended berries, banana, topped with granola and chia seeds',
            ingredients: [
              '1 cup mixed berries',
              '1/2 banana',
              '1/4 cup granola',
              '1 tbsp chia seeds',
            ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: 'Baked Cod with Sweet Potato',
            description:
                'Herb-baked cod, mashed sweet potato, steamed green beans',
            ingredients: [
              '5oz cod fillet',
              '1 medium sweet potato',
              '1 cup green beans',
              'herbs and lemon',
            ],
            timeScheduled: '19:30',
          ),
        ];

      default:
        return [];
    }
  }
}
