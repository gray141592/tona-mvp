import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../data/models/meal.dart';
import '../../../data/models/meal_log.dart';
import '../../../data/models/meal_log_status.dart';
import '../../providers/meal_plan_provider.dart';
import '../dashboard/dashboard_meal_details_sheet.dart';
import 'report_preview_meal_log_note.dart';

class ReportPreviewMealLogEntry extends StatelessWidget {
  final MealLog log;

  const ReportPreviewMealLogEntry({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(log.status);
    final meal = context.watch<MealPlanProvider>().getMealById(log.mealId);
    final alternativeText = log.alternativeMeal ?? '';
    final showAlternativeNote = alternativeText.isNotEmpty && meal != null;
    final mealTitle = meal?.name ??
        (alternativeText.isNotEmpty
            ? alternativeText
            : 'Meal details unavailable');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: meal != null ? () => _openMealDetails(context, meal) : null,
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        mealTitle,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        color: meal != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    if (meal != null)
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(_statusIcon(log.status), color: statusColor),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          log.status.displayName,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        Text(
                          date_utils.DateUtils.formatTime(log.loggedTime),
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (log.notes != null && log.notes!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ReportPreviewMealLogNote(
                    icon: Icons.sticky_note_2_outlined,
                    text: log.notes!,
                  ),
                ],
                if (showAlternativeNote) ...[
                  const SizedBox(height: 8),
                  ReportPreviewMealLogNote(
                    icon: Icons.restaurant_menu_outlined,
                    text: alternativeText,
                  ),
                ],
                if (log.containsSugar == true) ...[
                  const SizedBox(height: 8),
                  const ReportPreviewMealLogNote(
                    icon: Icons.cake_outlined,
                    text: 'Alternative meal contained added sugar.',
                  ),
                ],
                if (log.hasHighGlycemicIndex == true) ...[
                  const SizedBox(height: 8),
                  const ReportPreviewMealLogNote(
                    icon: Icons.trending_up_outlined,
                    text: 'Alternative meal was marked as high glycemic index.',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openMealDetails(BuildContext context, Meal meal) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DashboardMealDetailsSheet(meal: meal),
    );
  }

  Color _statusColor(MealLogStatus status) => switch (status) {
        MealLogStatus.followed => AppColors.success,
        MealLogStatus.alternative => AppColors.warning,
        MealLogStatus.skipped => AppColors.error,
      };

  IconData _statusIcon(MealLogStatus status) => switch (status) {
        MealLogStatus.followed => Icons.check_circle,
        MealLogStatus.alternative => Icons.restaurant,
        MealLogStatus.skipped => Icons.remove_circle_outline,
      };
}
