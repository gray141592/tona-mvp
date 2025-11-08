import 'package:flutter/material.dart';

import '../../../data/models/meal.dart';
import '../meal_plan/meal_drawer.dart';

class DashboardMealDetailsSheet extends StatelessWidget {
  final Meal meal;

  const DashboardMealDetailsSheet({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return MealDrawer(meal: meal);
  }
}
