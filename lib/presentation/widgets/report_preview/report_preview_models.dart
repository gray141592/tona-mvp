class ReportPreviewMetrics {
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final int mealsSkipped;
  final int dueMeals;
  final int unloggedDueMeals;
  final double adherencePercentage;
  final int mealsWithSugar;
  final int mealsWithHighGlycemicIndex;
  final int longestAdherentDayStreak;
  final int longestFollowedMealStreak;

  const ReportPreviewMetrics({
    required this.totalMeals,
    required this.mealsFollowed,
    required this.mealsWithAlternatives,
    required this.mealsSkipped,
    required this.dueMeals,
    required this.unloggedDueMeals,
    required this.adherencePercentage,
    required this.mealsWithSugar,
    required this.mealsWithHighGlycemicIndex,
    required this.longestAdherentDayStreak,
    required this.longestFollowedMealStreak,
  });
}
