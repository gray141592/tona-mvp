import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/meal.dart';
import 'dashboard_models.dart';
import 'dashboard_utils.dart';

class DashboardUpcomingMealsPreview extends StatelessWidget {
  final List<MealTimelineEntry> entries;
  final ValueChanged<Meal> onViewDetails;

  const DashboardUpcomingMealsPreview({
    super.key,
    required this.entries,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.schedule, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Coming up',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...entries.take(3).map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _buildTile(entry),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildTile(MealTimelineEntry entry) {
    final meal = entry.meal;
    final isSoon = entry.state == MealTimelineState.upcomingSoon;
    final accentColor = isSoon ? AppColors.primary : AppColors.textSecondary;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
          ),
          child:
              Text(meal.mealType.emoji, style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal.name,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${meal.timeScheduled} • ${relativeTimeLabel(entry.timeDifference)}',
                style: AppTypography.bodySmall.copyWith(
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => onViewDetails(meal),
          icon: const Icon(Icons.visibility_outlined),
          color: AppColors.primary,
        ),
      ],
    );
  }
}
