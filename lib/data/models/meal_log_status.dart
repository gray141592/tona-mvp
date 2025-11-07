enum MealLogStatus {
  followed,
  alternative,
  skipped;

  String get displayName {
    switch (this) {
      case MealLogStatus.followed:
        return 'Followed Plan';
      case MealLogStatus.alternative:
        return 'Alternative Meal';
      case MealLogStatus.skipped:
        return 'Skipped Meal';
    }
  }
}
