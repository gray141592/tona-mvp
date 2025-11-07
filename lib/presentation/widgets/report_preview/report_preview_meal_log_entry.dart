import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../data/models/meal_log.dart';
import '../../../data/models/meal_log_status.dart';
import 'report_preview_meal_log_note.dart';

class ReportPreviewMealLogEntry extends StatelessWidget {
  final MealLog log;

  const ReportPreviewMealLogEntry({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(log.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _statusIcon(log.status),
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log.status.displayName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
          if (log.alternativeMeal != null &&
              log.alternativeMeal!.isNotEmpty) ...[
            const SizedBox(height: 8),
            ReportPreviewMealLogNote(
              icon: Icons.restaurant_menu_outlined,
              text: log.alternativeMeal!,
            ),
          ],
        ],
      ),
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
