import 'package:flutter/material.dart';
import '../../data/models/weekly_progress.dart';
import '../../data/models/daily_progress.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/time_provider.dart';

class WeeklyCalendar extends StatelessWidget {
  final WeeklyProgress weeklyProgress;
  final Function(DateTime date)? onDayTap;

  const WeeklyCalendar({
    super.key,
    required this.weeklyProgress,
    this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 7; i++)
          _buildDayRow(
            weeklyProgress.weekStartDate.add(Duration(days: i)),
            weeklyProgress.dailyProgress[i + 1]!,
          ),
      ],
    );
  }

  Widget _buildDayRow(DateTime date, DailyProgress dailyProgress) {
    final dayName = date_utils.DateUtils.formatDayOfWeek(date).substring(0, 3);
    final dateStr = date_utils.DateUtils.formatShortDate(date);
    final isToday = date_utils.DateUtils.isSameDay(date, TimeProvider.now());
    final percentage = dailyProgress.adherencePercentage;

    return InkWell(
      onTap: onDayTap != null ? () => onDayTap!(date) : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: isToday
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: isToday
                    ? LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.2),
                          AppColors.primaryLight,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          AppColors.surfaceVariant,
                          AppColors.surface,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayName.toUpperCase(),
                    style: AppTypography.labelMedium.copyWith(
                      color: isToday
                          ? AppColors.primaryDark
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateStr,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildProgressIndicators(dailyProgress),
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: _getPercentageColor(percentage).withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: AppTypography.titleMedium.copyWith(
                      color: _getPercentageColor(percentage),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    _statusLabel(percentage),
                    style: AppTypography.bodySmall.copyWith(
                      color: _getPercentageColor(percentage),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPercentageColor(double percentage) {
    if (percentage >= 80) {
      return AppColors.success;
    }
    if (percentage >= 50) {
      return AppColors.warning;
    }
    return AppColors.error;
  }

  Widget _buildProgressIndicators(DailyProgress dailyProgress) {
    final statusGradients = <Gradient>[
      for (var i = 0; i < dailyProgress.mealsFollowed; i++)
        LinearGradient(
          colors: [AppColors.success, AppColors.secondary],
        ),
      for (var i = 0; i < dailyProgress.mealsWithAlternatives; i++)
        LinearGradient(
          colors: [
            AppColors.warning,
            AppColors.secondary.withValues(alpha: 0.7)
          ],
        ),
      for (var i = 0; i < dailyProgress.mealsSkipped; i++)
        LinearGradient(
          colors: [AppColors.error, AppColors.error.withValues(alpha: 0.7)],
        ),
    ];

    final indicators = <Widget>[];

    for (var i = 0; i < dailyProgress.totalMeals; i++) {
      final gradient = i < statusGradients.length
          ? statusGradients[i]
          : LinearGradient(
              colors: [
                AppColors.surfaceVariant,
                AppColors.surfaceVariant.withValues(alpha: 0.6),
              ],
            );

      indicators.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: 32,
          height: 10,
          margin: const EdgeInsets.only(right: AppSpacing.xs),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: gradient,
          ),
        ),
      );
    }

    return Wrap(children: indicators);
  }

  String _statusLabel(double percentage) {
    if (percentage >= 90) return 'crushing it';
    if (percentage >= 70) return 'on track';
    if (percentage >= 50) return 'getting there';
    return 'new chance';
  }
}
