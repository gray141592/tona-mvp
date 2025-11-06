enum MealType {
  breakfast,
  lunch,
  dinner,
  snack1,
  snack2;

  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack1:
        return 'Snack 1';
      case MealType.snack2:
        return 'Snack 2';
    }
  }

  String get emoji {
    switch (this) {
      case MealType.breakfast:
        return '🌅';
      case MealType.lunch:
        return '🍽️';
      case MealType.dinner:
        return '🍽️';
      case MealType.snack1:
        return '🍎';
      case MealType.snack2:
        return '🍎';
    }
  }
}

