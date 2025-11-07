import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/meal.dart';
import 'dashboard_models.dart';
import 'dashboard_utils.dart';

class DashboardPendingMealRow extends StatelessWidget {
  final MealTimelineEntry entry;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const DashboardPendingMealRow({
    super.key,
    required this.entry,
    required this.isLogging,
    required this.onFollowed,
    required this.onSkipped,
    required this.onAlternative,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final meal = entry.meal;
    final isOverdue = entry.state == MealTimelineState.overdue;
    final tintColor = isOverdue ? AppColors.error : AppColors.warning;
    final scheduleLine =
        'Scheduled ${meal.timeScheduled} • ${relativeTimeLabel(entry.timeDifference)}';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: tintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  meal.mealType.emoji,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      scheduleLine,
                      style: AppTypography.bodySmall.copyWith(
                        color: tintColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => onViewDetails(meal),
                icon: const Icon(Icons.visibility_outlined),
                color: tintColor,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              OutlinedButton.icon(
                onPressed: isLogging ? null : () => onFollowed(meal),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('Followed'),
              ),
              OutlinedButton.icon(
                onPressed: isLogging ? null : () => onSkipped(meal),
                icon: const Icon(Icons.remove_circle_outline, size: 18),
                label: const Text('Skipped'),
              ),
              TextButton.icon(
                onPressed: isLogging ? null : () => onAlternative(meal),
                icon: const Icon(Icons.edit_note_outlined, size: 18),
                label: const Text('Something else'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
