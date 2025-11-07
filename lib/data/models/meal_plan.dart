import 'meal.dart';

class MealPlan {
  final String id;
  final String clientId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<Meal> meals;

  const MealPlan({
    required this.id,
    required this.clientId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.meals,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'name': name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'meals': meals.map((m) => m.toJson()).toList(),
    };
  }

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      meals: (json['meals'] as List)
          .map((m) => Meal.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }
}
