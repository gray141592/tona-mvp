import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../data/models/meal_log.dart';
import 'report_preview_meal_log_entry.dart';

class ReportPreviewDayCard extends StatelessWidget {
  final DateTime date;
  final List<MealLog> logs;

  const ReportPreviewDayCard({
    super.key,
    required this.date,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date_utils.DateUtils.formatDate(date),
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...logs.map(
            (log) => ReportPreviewMealLogEntry(log: log),
          ),
        ],
      ),
    );
  }
}
