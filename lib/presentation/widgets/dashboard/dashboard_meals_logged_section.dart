import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/meal_log_status.dart';
import 'dashboard_models.dart';

class DashboardMealsLoggedSection extends StatelessWidget {
  final List<DashboardMealLogEntry> entries;
  final int totalMealsForDay;

  const DashboardMealsLoggedSection({
    super.key,
    required this.entries,
    required this.totalMealsForDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
                  color: AppColors.success.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.verified, color: AppColors.success),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Meals logged',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${entries.length} of $totalMealsForDay logged',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Nothing logged yet. Your updates will appear here.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          else
            ...entries.map((entry) => _buildRow(entry)),
        ],
      ),
    );
  }

  Widget _buildRow(DashboardMealLogEntry entry) {
    final statusInfo = _statusVisuals(entry.log.status);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: statusInfo.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(statusInfo.icon, color: statusInfo.color, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.mealName,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  entry.log.status.displayName,
                  style: AppTypography.bodySmall.copyWith(
                    color: statusInfo.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (entry.log.alternativeMeal != null && entry.meal != null)
                  Text(
                    entry.log.alternativeMeal!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                if (entry.log.containsSugar == true ||
                    entry.log.hasHighGlycemicIndex == true) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      if (entry.log.containsSugar == true)
                        const _ImpactPill(
                          icon: Icons.cake_outlined,
                          label: 'Contains sugar',
                          color: AppColors.error,
                        ),
                      if (entry.log.hasHighGlycemicIndex == true)
                        const _ImpactPill(
                          icon: Icons.trending_up_outlined,
                          label: 'High GI',
                          color: AppColors.warning,
                        ),
                    ],
                  ),
                ],
                if (entry.log.notes != null)
                  Text(
                    entry.log.notes!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            '${entry.log.loggedTime.hour.toString().padLeft(2, '0')}:${entry.log.loggedTime.minute.toString().padLeft(2, '0')}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  _StatusVisuals _statusVisuals(MealLogStatus status) => switch (status) {
        MealLogStatus.followed => const _StatusVisuals(
            color: AppColors.success,
            icon: Icons.check_circle,
          ),
        MealLogStatus.alternative => const _StatusVisuals(
            color: AppColors.warning,
            icon: Icons.restaurant,
          ),
        MealLogStatus.skipped => const _StatusVisuals(
            color: AppColors.error,
            icon: Icons.remove_circle_outline,
          ),
      };
}

class _StatusVisuals {
  final Color color;
  final IconData icon;

  const _StatusVisuals({required this.color, required this.icon});
}

class _ImpactPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ImpactPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
