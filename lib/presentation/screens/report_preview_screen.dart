import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/adherence_utils.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/streak_utils.dart';
import '../../core/utils/time_provider.dart';
import '../../data/models/client.dart';
import '../../data/models/meal_log.dart';
import '../../data/models/meal_log_status.dart';
import '../providers/meal_log_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../widgets/report_preview/report_preview_client_info_card.dart';
import '../widgets/report_preview/report_preview_daily_breakdown_header.dart';
import '../widgets/report_preview/report_preview_daily_breakdown_list.dart';
import '../widgets/report_preview/report_preview_models.dart';
import '../widgets/report_preview/report_preview_summary_card.dart';
import '../widgets/success_toast.dart';

class ReportPreviewScreen extends StatelessWidget {
  final Client client;
  final DateTime startDate;
  final DateTime endDate;

  const ReportPreviewScreen({
    super.key,
    required this.client,
    required this.startDate,
    required this.endDate,
  });

  Future<void> _shareReport(BuildContext context) async {
    try {
      final mealLogProvider = context.read<MealLogProvider>();
      final mealPlanProvider = context.read<MealPlanProvider>();
      final orderedStart =
          startDate.isBefore(endDate) ? startDate : endDate;
      final orderedEnd = startDate.isBefore(endDate) ? endDate : startDate;
      final rangeStart = date_utils.DateUtils.getDateOnly(orderedStart);
      final rangeEnd = date_utils.DateUtils.getDateOnly(orderedEnd);

      final logs = mealLogProvider.getLogsForDateRange(rangeStart, rangeEnd);
      final metrics = _calculateRangeMetrics(
        mealPlanProvider,
        logs,
        rangeStart,
        rangeEnd,
      );

      final reportText = _generateReportText(
        logs,
        metrics,
      );

      final shareSubject =
          'Progress Report - ${date_utils.DateUtils.formatDate(startDate)} to ${date_utils.DateUtils.formatDate(endDate)}';
      await SharePlus.instance.share(
        ShareParams(
          text: reportText,
          subject: shareSubject,
          title: shareSubject,
        ),
      );
    } catch (e) {
      if (context.mounted) {
        SuccessToast.show(
          context,
          'Error sharing report: $e',
          emoji: '⚠️',
          type: ToastType.warning,
        );
      }
    }
  }

  String _generateReportText(
    List<MealLog> logs,
    ReportPreviewMetrics metrics,
  ) {
    final orderedStart =
        startDate.isBefore(endDate) ? startDate : endDate;
    final orderedEnd = startDate.isBefore(endDate) ? endDate : startDate;
    final rangeStart = date_utils.DateUtils.getDateOnly(orderedStart);
    final rangeEnd = date_utils.DateUtils.getDateOnly(orderedEnd);

    final buffer = StringBuffer();
    buffer.writeln('Progress Report');
    buffer.writeln('Client: ${client.name}');
    buffer.writeln('Email: ${client.email}');
    buffer.writeln(
      'Period: ${date_utils.DateUtils.formatDate(rangeStart)} - ${date_utils.DateUtils.formatDate(rangeEnd)}',
    );
    buffer.writeln('');
    buffer.writeln('Summary:');
    buffer.writeln('Total Meals: ${metrics.totalMeals}');
    buffer.writeln('Meals Followed: ${metrics.mealsFollowed}');
    buffer.writeln('Alternative Meals: ${metrics.mealsWithAlternatives}');
    buffer.writeln('Meals Skipped: ${metrics.mealsSkipped}');
    buffer.writeln('Meals due so far: ${metrics.dueMeals}');
    buffer.writeln('Unlogged meals due: ${metrics.unloggedDueMeals}');
    buffer.writeln(
      'Longest streak: ${StreakUtils.formatLongestStreakLabel(
        metrics.longestAdherentDayStreak,
        metrics.longestFollowedMealStreak,
      )}',
    );
    buffer.writeln('Meals with sugar: ${metrics.mealsWithSugar}');
    buffer.writeln(
      'Meals with high glycemic index: ${metrics.mealsWithHighGlycemicIndex}',
    );
    buffer.writeln('');
    buffer.writeln('Daily Breakdown:');

    for (var date = rangeStart;
        !date.isAfter(rangeEnd);
        date = date.add(const Duration(days: 1))) {
      final dayLogs = logs
          .where(
            (log) => date_utils.DateUtils.isSameDay(log.loggedDate, date),
          )
          .toList();

      if (dayLogs.isEmpty) continue;

      buffer.writeln('\n${date_utils.DateUtils.formatDate(date)}:');
      for (final log in dayLogs) {
        buffer.writeln(
          '  ${date_utils.DateUtils.formatTime(log.loggedTime)} - ${log.status.displayName}',
        );
        if (log.notes != null) {
          buffer.writeln('    Notes: ${log.notes}');
        }
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final mealLogProvider = context.watch<MealLogProvider>();
    final mealPlanProvider = context.watch<MealPlanProvider>();
    final orderedStart =
        startDate.isBefore(endDate) ? startDate : endDate;
    final orderedEnd = startDate.isBefore(endDate) ? endDate : startDate;
    final rangeStart = date_utils.DateUtils.getDateOnly(orderedStart);
    final rangeEnd = date_utils.DateUtils.getDateOnly(orderedEnd);

    final logs = mealLogProvider.getLogsForDateRange(rangeStart, rangeEnd);
    final metrics = _calculateRangeMetrics(
      mealPlanProvider,
      logs,
      rangeStart,
      rangeEnd,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Progress report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareReport(context),
            tooltip: 'Share report',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            ReportPreviewClientInfoCard(
              client: client,
              startDate: rangeStart,
              endDate: rangeEnd,
            ),
            const SizedBox(height: AppSpacing.md),
            ReportPreviewSummaryCard(
              mealsFollowed: metrics.mealsFollowed,
              mealsWithAlternatives: metrics.mealsWithAlternatives,
              mealsSkipped: metrics.mealsSkipped,
              mealsWithSugar: metrics.mealsWithSugar,
              mealsWithHighGlycemicIndex: metrics.mealsWithHighGlycemicIndex,
              longestStreakLabel: StreakUtils.formatLongestStreakLabel(
                metrics.longestAdherentDayStreak,
                metrics.longestFollowedMealStreak,
              ),
              hasStreak: StreakUtils.hasStreak(
                metrics.longestAdherentDayStreak,
                metrics.longestFollowedMealStreak,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const ReportPreviewDailyBreakdownHeader(),
            const SizedBox(height: AppSpacing.md),
            ReportPreviewDailyBreakdownList(
              logs: logs,
              startDate: rangeStart,
              endDate: rangeEnd,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  ReportPreviewMetrics _calculateRangeMetrics(
    MealPlanProvider mealPlanProvider,
    List<MealLog> logs,
    DateTime rangeStart,
    DateTime rangeEnd,
  ) {
    var totalMeals = 0;
    var mealsFollowed = 0;
    var mealsWithAlternatives = 0;
    var mealsSkipped = 0;
    var dueMeals = 0;
    var unloggedDueMeals = 0;
    var mealsWithSugar = 0;
    var mealsWithHighGlycemicIndex = 0;

    var currentAdherentDayStreak = 0;
    var longestAdherentDayStreak = 0;
    var longestFollowedMealStreak = 0;
    var currentFollowedMealStreak = 0;

    final now = TimeProvider.now();
    final today = date_utils.DateUtils.getDateOnly(now);
    final startDateOnly = rangeStart;
    final endDateOnly = rangeEnd;
    final sortedLogs = [...logs]
      ..sort(
        (a, b) => StreakUtils.combineLogDateTime(a)
            .compareTo(StreakUtils.combineLogDateTime(b)),
      );

    for (final log in sortedLogs) {
      if (log.containsSugar == true) {
        mealsWithSugar++;
      }
      if (log.hasHighGlycemicIndex == true) {
        mealsWithHighGlycemicIndex++;
      }

      if (log.status == MealLogStatus.followed) {
        currentFollowedMealStreak++;
        if (currentFollowedMealStreak > longestFollowedMealStreak) {
          longestFollowedMealStreak = currentFollowedMealStreak;
        }
      } else {
        currentFollowedMealStreak = 0;
      }
    }

    for (var date = startDateOnly;
        !date.isAfter(endDateOnly);
        date = date.add(const Duration(days: 1))) {
      final dayMeals = mealPlanProvider.getMealsForDate(date);
      final dayLogs = logs
          .where(
            (log) => date_utils.DateUtils.isSameDay(log.loggedDate, date),
          )
          .toList();

      totalMeals += dayMeals.length;
      mealsFollowed +=
          dayLogs.where((log) => log.status.name == 'followed').length;
      mealsWithAlternatives +=
          dayLogs.where((log) => log.status.name == 'alternative').length;
      mealsSkipped +=
          dayLogs.where((log) => log.status.name == 'skipped').length;

      final dailyMetrics = AdherenceUtils.evaluate(
        date: date,
        meals: dayMeals,
        logs: dayLogs,
        now: now,
      );

      dueMeals += dailyMetrics.dueMeals;
      unloggedDueMeals += dailyMetrics.unloggedDueMeals;

      if (date.isAfter(today)) {
        continue;
      }

      if (dailyMetrics.dueMeals == 0) {
        continue;
      }

      final dueMealIds = dayMeals
          .where(
            (meal) =>
                !date_utils.DateUtils
                    .combineDateWithTimeString(date, meal.timeScheduled)
                    .isAfter(now),
          )
          .map((meal) => meal.id)
          .toSet();

      if (dueMealIds.isEmpty) {
        continue;
      }

      final hasNonFollowedLog = dayLogs.any(
        (log) =>
            dueMealIds.contains(log.mealId) &&
            log.status != MealLogStatus.followed,
      );
      final hasMissingFollowed = dueMealIds.any(
        (mealId) => !dayLogs.any(
          (log) =>
              log.mealId == mealId && log.status == MealLogStatus.followed,
        ),
      );

      if (!hasNonFollowedLog && !hasMissingFollowed) {
        currentAdherentDayStreak++;
        if (currentAdherentDayStreak > longestAdherentDayStreak) {
          longestAdherentDayStreak = currentAdherentDayStreak;
        }
      } else {
        currentAdherentDayStreak = 0;
      }
    }

    final adherencePercentage = dueMeals == 0
        ? 100.0
        : ((dueMeals - unloggedDueMeals) / dueMeals) * 100;

    return ReportPreviewMetrics(
      totalMeals: totalMeals,
      mealsFollowed: mealsFollowed,
      mealsWithAlternatives: mealsWithAlternatives,
      mealsSkipped: mealsSkipped,
      dueMeals: dueMeals,
      unloggedDueMeals: unloggedDueMeals,
      adherencePercentage: adherencePercentage,
      mealsWithSugar: mealsWithSugar,
      mealsWithHighGlycemicIndex: mealsWithHighGlycemicIndex,
      longestAdherentDayStreak: longestAdherentDayStreak,
      longestFollowedMealStreak: longestFollowedMealStreak,
    );
  }
}
