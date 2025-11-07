import 'meal_ingredient.dart';
import 'meal_type.dart';

class Meal {
  final String id;
  final String mealPlanId;
  final int dayOfWeek;
  final MealType mealType;
  final String name;
  final String description;
  final List<MealIngredient> ingredients;
  final List<String> preparationInstructions;
  final String timeScheduled;

  const Meal({
    required this.id,
    required this.mealPlanId,
    required this.dayOfWeek,
    required this.mealType,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.preparationInstructions,
    required this.timeScheduled,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_plan_id': mealPlanId,
      'day': dayOfWeek,
      'meal_type': mealType.name,
      'name': name,
      'description': description,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'preparation_instructions': preparationInstructions,
      'scheduled_time': timeScheduled,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as String,
      mealPlanId: json['meal_plan_id'] as String,
      dayOfWeek: json['day'] as int,
      mealType: MealType.values.firstWhere(
        (e) => e.name == json['meal_type'],
      ),
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List)
          .map(
            (ingredient) =>
                MealIngredient.fromJson(ingredient as Map<String, dynamic>),
          )
          .toList(),
      preparationInstructions:
          (json['preparation_instructions'] as List).cast<String>(),
      timeScheduled: json['scheduled_time'] as String,
    );
  }
}
