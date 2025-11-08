class AppConstants {
  static const String appName = 'IRresistible';
  static const String databaseName = 'tona_mvp.db';
  static const int databaseVersion = 1;

  static const int mealsPerDay = 5;
  static const int daysPerWeek = 7;

  static const String mockClientId = 'client_001';
  static const String mockMealPlanId = 'plan_001';
  static const Duration consultationReminderLeadTime = Duration(days: 1);
  static const Duration consultationFollowUpWindow = Duration(days: 3);

  /// Set to true to skip onboarding flow (splash, upload, processing, review)
  /// and go directly to the dashboard with mock data
  static const bool skipOnboarding = true;

  static const String hasSeenNextMealSwipeHintKey =
      'has_seen_next_meal_swipe_hint';
}
