import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/adherence_utils.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/time_provider.dart';
import '../../data/models/client.dart';
import '../../data/models/meal_log.dart';
import '../providers/meal_log_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../widgets/report_preview/report_preview_client_info_card.dart';
import '../widgets/report_preview/report_preview_daily_breakdown_header.dart';
import '../widgets/report_preview/report_preview_daily_breakdown_list.dart';
import '../widgets/report_preview/report_preview_models.dart';
import '../widgets/report_preview/report_preview_summary_card.dart';

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
      final logs = mealLogProvider.getLogsForDateRange(startDate, endDate);
      final metrics = _calculateRangeMetrics(mealPlanProvider, logs);

      final reportText = _generateReportText(logs, metrics);

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing report: $e')),
        );
      }
    }
  }

  String _generateReportText(
    List<MealLog> logs,
    ReportPreviewMetrics metrics,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('Progress Report');
    buffer.writeln('Client: ${client.name}');
    buffer.writeln('Email: ${client.email}');
    buffer.writeln(
      'Period: ${date_utils.DateUtils.formatDate(startDate)} - ${date_utils.DateUtils.formatDate(endDate)}',
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
      'Adherence: ${metrics.adherencePercentage.toStringAsFixed(1)}%',
    );
    buffer.writeln('');
    buffer.writeln('Daily Breakdown:');

    for (var date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
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
    final logs = mealLogProvider.getLogsForDateRange(startDate, endDate);
    final metrics = _calculateRangeMetrics(mealPlanProvider, logs);

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
              startDate: startDate,
              endDate: endDate,
            ),
            const SizedBox(height: AppSpacing.md),
            ReportPreviewSummaryCard(
              totalMeals: metrics.totalMeals,
              mealsFollowed: metrics.mealsFollowed,
              mealsWithAlternatives: metrics.mealsWithAlternatives,
              mealsSkipped: metrics.mealsSkipped,
              dueMeals: metrics.dueMeals,
              unloggedDueMeals: metrics.unloggedDueMeals,
              adherencePercentage: metrics.adherencePercentage,
            ),
            const SizedBox(height: AppSpacing.lg),
            const ReportPreviewDailyBreakdownHeader(),
            const SizedBox(height: AppSpacing.md),
            ReportPreviewDailyBreakdownList(
              logs: logs,
              startDate: startDate,
              endDate: endDate,
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
  ) {
    var totalMeals = 0;
    var mealsFollowed = 0;
    var mealsWithAlternatives = 0;
    var mealsSkipped = 0;
    var dueMeals = 0;
    var unloggedDueMeals = 0;

    final now = TimeProvider.now();

    for (var date = date_utils.DateUtils.getDateOnly(startDate);
        !date.isAfter(endDate);
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
    );
  }
}
