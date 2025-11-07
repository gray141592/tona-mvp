import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../core/utils/time_provider.dart';
import '../../../data/models/daily_progress.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onMenuTap;
  final bool isMenuOpen;
  final DailyProgress dailyProgress;

  const DashboardHeader({
    super.key,
    required this.onMenuTap,
    required this.isMenuOpen,
    required this.dailyProgress,
  });

  @override
  Widget build(BuildContext context) {
    final isToday =
        date_utils.DateUtils.isSameDay(dailyProgress.date, TimeProvider.now());
    final statusLabel = _statusLabel(dailyProgress);

    return Row(
      children: [
        GestureDetector(
          onTap: onMenuTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isMenuOpen ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              isMenuOpen ? Icons.close_rounded : Icons.restaurant_menu,
              color: isMenuOpen ? Colors.white : AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    isToday
                        ? 'Today'
                        : date_utils.DateUtils.formatDate(dailyProgress.date),
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (statusLabel != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        statusLabel,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _greetingMessage(dailyProgress),
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _greetingMessage(DailyProgress progress) {
    if (progress.unloggedDueMeals >= 3) {
      return 'Let’s log a few meals while the details are fresh.';
    }
    if (progress.unloggedDueMeals == 2) {
      return 'Two meals are waiting for a log — quick updates help a ton.';
    }
    if (progress.unloggedDueMeals == 1) {
      return 'One meal needs a quick log to stay on track.';
    }
    if (progress.dueMeals == 0) {
      return 'You’re all set until the next meal.';
    }
    return 'Nice work staying current — keep the momentum going.';
  }

  String? _statusLabel(DailyProgress progress) {
    if (progress.unloggedDueMeals > 0) {
      final count = progress.unloggedDueMeals;
      final mealLabel = count == 1 ? 'meal' : 'meals';
      return '$count $mealLabel overdue';
    }

    if (progress.mealsLogged > 0) {
      final count = progress.mealsLogged;
      final mealLabel = count == 1 ? 'meal' : 'meals';
      return '$count $mealLabel logged';
    }

    return null;
  }
}
