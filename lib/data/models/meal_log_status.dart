enum MealLogStatus {
  followed,
  alternative;

  String get displayName {
    switch (this) {
      case MealLogStatus.followed:
        return 'Followed Plan';
      case MealLogStatus.alternative:
        return 'Alternative Meal';
    }
  }
}

