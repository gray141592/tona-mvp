import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../core/utils/time_provider.dart';
import 'report_preview_adherence_pie_chart.dart';
import 'report_preview_summary_pill.dart';

class ReportPreviewSummaryCard extends StatelessWidget {
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final int mealsSkipped;
  final int mealsWithSugar;
  final int mealsWithHighGlycemicIndex;
  final String longestStreakLabel;
  final bool hasStreak;
  final bool showLongestStreak;

  const ReportPreviewSummaryCard({
    super.key,
    required this.mealsFollowed,
    required this.mealsWithAlternatives,
    required this.mealsSkipped,
    required this.mealsWithSugar,
    required this.mealsWithHighGlycemicIndex,
    required this.longestStreakLabel,
    required this.hasStreak,
    this.showLongestStreak = true,
  });

  @override
  Widget build(BuildContext context) {
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
          if (showLongestStreak) ...[
            ReportPreviewSummaryPill(
              icon: Icons.local_fire_department_rounded,
              label: 'Longest streak',
              value: longestStreakLabel,
              accent: hasStreak ? AppColors.primary : AppColors.textSecondary,
              footer: hasStreak
                  ? 'As of ${date_utils.DateUtils.formatDate(TimeProvider.now())}'
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          ReportPreviewAdherencePieChart(
            followed: mealsFollowed,
            alternatives: mealsWithAlternatives,
            skipped: mealsSkipped,
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - AppSpacing.md) / 2;
              return Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: ReportPreviewSummaryPill(
                      icon: Icons.check_circle,
                      label: 'Followed',
                      value: '$mealsFollowed',
                      accent: AppColors.success,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: ReportPreviewSummaryPill(
                      icon: Icons.restaurant,
                      label: 'Alternatives',
                      value: mealsWithAlternatives.toString(),
                      accent: AppColors.warning,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: ReportPreviewSummaryPill(
                      icon: Icons.cake_outlined,
                      label: 'Meals with sugar',
                      value: mealsWithSugar.toString(),
                      accent: AppColors.accent,
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: ReportPreviewSummaryPill(
                      icon: Icons.trending_up_outlined,
                      label: 'High G index meals',
                      value: mealsWithHighGlycemicIndex.toString(),
                      accent: AppColors.primaryDark,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
