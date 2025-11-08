import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/streak_utils.dart';
import '../providers/progress_provider.dart';
import '../widgets/dashboard_page_shell.dart';
import '../widgets/report_preview/report_preview_day_card.dart';
import '../widgets/report_preview/report_preview_models.dart';
import '../widgets/report_preview/report_preview_summary_card.dart';
import '../../data/models/daily_progress.dart';
import '../../data/models/meal_log_status.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();
    final history = progressProvider.getProgressHistory();
    final metrics = _buildProgressMetrics(history);

    final hasHistory = history.isNotEmpty;
    final latestDate = hasHistory ? history.first.date : null;
    final earliestDate = hasHistory ? history.last.date : null;

    final longestStreakLabel = StreakUtils.formatLongestStreakLabel(
      metrics.longestAdherentDayStreak,
      metrics.longestFollowedMealStreak,
    );
    final longestStreakHeadline = StreakUtils.formatLongestStreakHeadline(
      metrics.longestAdherentDayStreak,
      metrics.longestFollowedMealStreak,
    );
    final hasStreak = StreakUtils.hasStreak(
      metrics.longestAdherentDayStreak,
      metrics.longestFollowedMealStreak,
    );

    final subtitle = hasHistory
        ? '${date_utils.DateUtils.formatDate(earliestDate!)} → ${date_utils.DateUtils.formatDate(latestDate!)}'
        : 'Log your meals to unlock progress insights';

    return DashboardPageShell(
      title: 'Progress',
      subtitle: subtitle,
      bodyPadding: const EdgeInsets.all(AppSpacing.md),
      child: ListView(
        children: [
          const SizedBox(height: AppSpacing.md),
          _LongestStreakCard(
            headline: longestStreakHeadline,
            detailLabel:
                hasStreak ? longestStreakLabel : 'Log your meals to start a streak',
            message: _streakMessage(
              metrics.longestAdherentDayStreak,
              metrics.longestFollowedMealStreak,
            ),
            hasStreak: hasStreak,
          ),
          const SizedBox(height: AppSpacing.lg),
          ReportPreviewSummaryCard(
            mealsFollowed: metrics.mealsFollowed,
            mealsWithAlternatives: metrics.mealsWithAlternatives,
            mealsSkipped: metrics.mealsSkipped,
            mealsWithSugar: metrics.mealsWithSugar,
            mealsWithHighGlycemicIndex: metrics.mealsWithHighGlycemicIndex,
            longestStreakLabel: longestStreakLabel,
            hasStreak: hasStreak,
            showLongestStreak: false,
          ),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(
            icon: Icons.calendar_view_week,
            title: 'Daily history',
            subtitle: 'All of your logs',
          ),
          const SizedBox(height: AppSpacing.md),
          if (hasHistory)
            _DailyHistoryList(history: history)
          else
            const _HistoryEmptyState(),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  ReportPreviewMetrics _buildProgressMetrics(List<DailyProgress> history) {
    if (history.isEmpty) {
      return const ReportPreviewMetrics(
        totalMeals: 0,
        mealsFollowed: 0,
        mealsWithAlternatives: 0,
        mealsSkipped: 0,
        dueMeals: 0,
        unloggedDueMeals: 0,
        adherencePercentage: 0,
        mealsWithSugar: 0,
        mealsWithHighGlycemicIndex: 0,
        longestAdherentDayStreak: 0,
        longestFollowedMealStreak: 0,
      );
    }

    final logs = history
        .expand((daily) => daily.mealLogs)
        .toList()
      ..sort(
        (a, b) => StreakUtils.combineLogDateTime(a)
            .compareTo(StreakUtils.combineLogDateTime(b)),
      );

    var mealsWithSugar = 0;
    var mealsWithHighGlycemicIndex = 0;
    var currentMealStreak = 0;
    var longestMealStreak = 0;

    for (final log in logs) {
      if (log.containsSugar == true) {
        mealsWithSugar++;
      }
      if (log.hasHighGlycemicIndex == true) {
        mealsWithHighGlycemicIndex++;
      }
      if (log.status == MealLogStatus.followed) {
        currentMealStreak++;
        if (currentMealStreak > longestMealStreak) {
          longestMealStreak = currentMealStreak;
        }
      } else {
        currentMealStreak = 0;
      }
    }

    final totals = history.fold(
      (total: 0, followed: 0, alternatives: 0, skipped: 0, due: 0, unlogged: 0),
      (previous, daily) => (
        total: previous.total + daily.totalMeals,
        followed: previous.followed + daily.mealsFollowed,
        alternatives: previous.alternatives + daily.mealsWithAlternatives,
        skipped: previous.skipped + daily.mealsSkipped,
        due: previous.due + daily.dueMeals,
        unlogged: previous.unlogged + daily.unloggedDueMeals,
      ),
    );

    final ascendingDays = [...history]
      ..sort((a, b) => a.date.compareTo(b.date));
    var currentDayStreak = 0;
    var longestDayStreak = 0;

    for (final daily in ascendingDays) {
      if (_isAdherentDay(daily)) {
        currentDayStreak++;
        if (currentDayStreak > longestDayStreak) {
          longestDayStreak = currentDayStreak;
        }
      } else {
        currentDayStreak = 0;
      }
    }

    final adherencePercentage = totals.due == 0
        ? 100.0
        : ((totals.due - totals.unlogged) / totals.due) * 100;

    return ReportPreviewMetrics(
      totalMeals: totals.total,
      mealsFollowed: totals.followed,
      mealsWithAlternatives: totals.alternatives,
      mealsSkipped: totals.skipped,
      dueMeals: totals.due,
      unloggedDueMeals: totals.unlogged,
      adherencePercentage: adherencePercentage,
      mealsWithSugar: mealsWithSugar,
      mealsWithHighGlycemicIndex: mealsWithHighGlycemicIndex,
      longestAdherentDayStreak: longestDayStreak,
      longestFollowedMealStreak: longestMealStreak,
    );
  }

  bool _isAdherentDay(DailyProgress daily) {
    if (daily.dueMeals == 0) return false;
    if (daily.unloggedDueMeals > 0) return false;
    if (daily.mealsSkipped > 0) return false;
    if (daily.mealsWithAlternatives > 0) return false;
    return daily.mealsFollowed >= daily.dueMeals;
  }

  String _streakMessage(int dayStreak, int mealStreak) {
    if (dayStreak >= 7) return 'Incredible run! Keep the fire going! 🔥';
    if (dayStreak >= 3) return 'Amazing consistency — keep stacking days! 💪';
    if (dayStreak >= 1) return 'Strong start — let\'s stretch it further! 🚀';
    if (mealStreak >= 5) return 'Meal-by-meal, you\'re owning this week! 🍽️';
    if (mealStreak >= 1) return 'One meal at a time — keep that momentum! 🙌';
    return 'Fresh day, fresh opportunity to shine! 🌟';
  }
}

class _LongestStreakCard extends StatelessWidget {
  final String headline;
  final String detailLabel;
  final String message;
  final bool hasStreak;

  const _LongestStreakCard({
    required this.headline,
    required this.detailLabel,
    required this.message,
    required this.hasStreak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.2),
            AppColors.accent.withValues(alpha: 0.15),
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 36,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Longest streak',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    headline,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                          color: hasStreak
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  detailLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: hasStreak
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: hasStreak
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.local_fire_department_rounded,
              color: hasStreak ? AppColors.primary : AppColors.textSecondary,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyHistoryList extends StatelessWidget {
  final List<DailyProgress> history;

  const _DailyHistoryList({required this.history});

  @override
  Widget build(BuildContext context) {
    final daysWithLogs =
        history.where((daily) => daily.mealLogs.isNotEmpty).toList();

    if (daysWithLogs.isEmpty) {
      return const _HistoryEmptyState();
    }

    return Column(
      children: [
        for (final daily in daysWithLogs)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: ReportPreviewDayCard(
              key: ValueKey(daily.date.toIso8601String()),
              date: daily.date,
              logs: daily.mealLogs,
            ),
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const _SectionHeader({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _HistoryEmptyState extends StatelessWidget {
  const _HistoryEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No meals logged yet',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Log your first meal to start building your progress timeline.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

