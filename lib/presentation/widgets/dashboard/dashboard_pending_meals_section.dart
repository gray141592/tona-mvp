import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/meal.dart';
import 'dashboard_models.dart';
import 'dashboard_pending_meal_row.dart';

class DashboardPendingMealsSection extends StatelessWidget {
  final List<MealTimelineEntry> entries;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const DashboardPendingMealsSection({
    super.key,
    required this.entries,
    required this.isLogging,
    required this.onFollowed,
    required this.onSkipped,
    required this.onAlternative,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final severityMessage = switch (entries.length) {
      >= 3 =>
        'Several meals are waiting — capturing them now keeps your data accurate.',
      2 => 'Two meals need attention — a couple quick logs will close the gap.',
      1 => 'One meal is ready to log — take a moment to record it.',
      _ => null,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
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
                  color: AppColors.warning.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child:
                    const Icon(Icons.timer_outlined, color: AppColors.warning),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Needs attention',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (severityMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                severityMessage,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: DashboardPendingMealRow(
                entry: entry,
                isLogging: isLogging,
                onFollowed: onFollowed,
                onSkipped: onSkipped,
                onAlternative: onAlternative,
                onViewDetails: onViewDetails,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
