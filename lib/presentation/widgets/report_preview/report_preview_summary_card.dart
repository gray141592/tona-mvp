import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../core/utils/time_provider.dart';
import 'report_preview_summary_pill.dart';

class ReportPreviewSummaryCard extends StatelessWidget {
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final int mealsSkipped;
  final int dueMeals;
  final int unloggedDueMeals;
  final double adherencePercentage;

  const ReportPreviewSummaryCard({
    super.key,
    required this.totalMeals,
    required this.mealsFollowed,
    required this.mealsWithAlternatives,
    required this.mealsSkipped,
    required this.dueMeals,
    required this.unloggedDueMeals,
    required this.adherencePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final adherenceLabel = '${adherencePercentage.toStringAsFixed(1)}%';
    final adherenceFooter =
        'As of ${date_utils.DateUtils.formatDate(TimeProvider.now())}';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Snapshot summary',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: ReportPreviewSummaryPill(
                  icon: Icons.restaurant_menu,
                  label: 'Total meals',
                  value: totalMeals.toString(),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ReportPreviewSummaryPill(
                  icon: Icons.check_circle,
                  label: 'Followed',
                  value: '$mealsFollowed',
                  footer:
                      '${adherencePercentage.toStringAsFixed(1)}% adherence',
                  accent: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: ReportPreviewSummaryPill(
                  icon: Icons.restaurant,
                  label: 'Alternatives',
                  value: mealsWithAlternatives.toString(),
                  accent: AppColors.warning,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ReportPreviewSummaryPill(
                  icon: Icons.remove_circle_outline,
                  label: 'Skipped',
                  value: mealsSkipped.toString(),
                  accent: AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: ReportPreviewSummaryPill(
                  icon: Icons.timeline_rounded,
                  label: 'Due so far',
                  value: '$dueMeals',
                  accent: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ReportPreviewSummaryPill(
                  icon: Icons.pending_actions_outlined,
                  label: 'Needs log',
                  value: '$unloggedDueMeals',
                  accent: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ReportPreviewSummaryPill(
            icon: Icons.speed_rounded,
            label: 'Adherence',
            value: adherenceLabel,
            footer: adherenceFooter,
            accent: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
