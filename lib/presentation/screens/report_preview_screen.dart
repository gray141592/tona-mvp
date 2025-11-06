import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/client.dart';
import '../../data/models/meal_log.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../providers/meal_log_provider.dart';

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
      final logs = mealLogProvider.getLogsForDateRange(startDate, endDate);
      
      final reportText = _generateReportText(logs);
      
      // Using ignore comment for now as the share_plus package is transitioning APIs
      // ignore: deprecated_member_use, deprecated_member_use_from_same_package
      await Share.share(
        reportText,
        subject: 'Progress Report - ${date_utils.DateUtils.formatDate(startDate)} to ${date_utils.DateUtils.formatDate(endDate)}',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing report: $e')),
        );
      }
    }
  }

  String _generateReportText(List<MealLog> logs) {
    final buffer = StringBuffer();
    buffer.writeln('Progress Report');
    buffer.writeln('Client: ${client.name}');
    buffer.writeln('Email: ${client.email}');
    buffer.writeln('Period: ${date_utils.DateUtils.formatDate(startDate)} - ${date_utils.DateUtils.formatDate(endDate)}');
    buffer.writeln('');
    buffer.writeln('Summary:');
    buffer.writeln('Total Meals: ${logs.length}');
    buffer.writeln('Meals Followed: ${logs.where((l) => l.status.name == 'followed').length}');
    buffer.writeln('Alternative Meals: ${logs.where((l) => l.status.name == 'alternative').length}');
    buffer.writeln('');
    buffer.writeln('Daily Breakdown:');
    
    for (var date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final dayLogs = logs.where(
        (log) => date_utils.DateUtils.isSameDay(log.loggedDate, date),
      ).toList();

      if (dayLogs.isEmpty) continue;

      buffer.writeln('\n${date_utils.DateUtils.formatDate(date)}:');
      for (final log in dayLogs) {
        buffer.writeln('  ${date_utils.DateUtils.formatTime(log.loggedTime)} - ${log.status.displayName}');
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
    final logs = mealLogProvider.getLogsForDateRange(startDate, endDate);

    final totalMeals = 35;
    final mealsFollowed = logs.where((log) => log.status.name == 'followed').length;
    final mealsWithAlternatives = logs.where((log) => log.status.name == 'alternative').length;
    final adherencePercentage = totalMeals > 0 ? (mealsFollowed / totalMeals) * 100 : 0.0;

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
            _ClientInfoCard(
              client: client,
              startDate: startDate,
              endDate: endDate,
            ),
            const SizedBox(height: AppSpacing.md),
            _SummaryCard(
              totalMeals: totalMeals,
              mealsFollowed: mealsFollowed,
              mealsWithAlternatives: mealsWithAlternatives,
              adherencePercentage: adherencePercentage,
            ),
            const SizedBox(height: AppSpacing.lg),
            const _DailyBreakdownHeader(),
            const SizedBox(height: AppSpacing.md),
            _DailyBreakdownList(
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
}

class _ClientInfoCard extends StatelessWidget {
  final Client client;
  final DateTime startDate;
  final DateTime endDate;

  const _ClientInfoCard({
    required this.client,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.18),
            AppColors.accent.withValues(alpha: 0.12),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    client.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const Icon(Icons.event_available_rounded, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Reporting on ${date_utils.DateUtils.formatDate(startDate)} → ${date_utils.DateUtils.formatDate(endDate)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final double adherencePercentage;

  const _SummaryCard({
    required this.totalMeals,
    required this.mealsFollowed,
    required this.mealsWithAlternatives,
    required this.adherencePercentage,
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
          Row(
            children: [
              Expanded(
                child: _SummaryPill(
                  icon: Icons.restaurant_menu,
                  label: 'Total meals',
                  value: totalMeals.toString(),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _SummaryPill(
                  icon: Icons.check_circle,
                  label: 'Followed',
                  value: '$mealsFollowed',
                  footer: '${adherencePercentage.toStringAsFixed(1)}% adherence',
                  accent: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _SummaryPill(
                  icon: Icons.restaurant,
                  label: 'Alternatives',
                  value: mealsWithAlternatives.toString(),
                  accent: AppColors.warning,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _SummaryPill(
                  icon: Icons.timeline_rounded,
                  label: 'Daily avg',
                  value: '${adherencePercentage.toStringAsFixed(1)}%',
                  accent: AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DailyBreakdownHeader extends StatelessWidget {
  const _DailyBreakdownHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.view_agenda_outlined, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          'Daily breakdown',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _DailyBreakdownList extends StatelessWidget {
  final List<MealLog> logs;
  final DateTime startDate;
  final DateTime endDate;

  const _DailyBreakdownList({
    required this.logs,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildDayCards(),
    );
  }

  List<Widget> _buildDayCards() {
    final widgets = <Widget>[];

    for (var date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final dayLogs = logs.where(
        (log) => date_utils.DateUtils.isSameDay(log.loggedDate, date),
      ).toList();

      if (dayLogs.isEmpty) continue;

      widgets.add(
        _DayCard(
          date: date,
          dayLogs: dayLogs,
        ),
      );
    }

    return widgets;
  }
}

class _DayCard extends StatelessWidget {
  final DateTime date;
  final List<MealLog> dayLogs;

  const _DayCard({
    required this.date,
    required this.dayLogs,
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
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                date_utils.DateUtils.formatDate(date),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ...dayLogs.map((log) => _MealLogEntry(log: log)),
          if (dayLogs.any((log) => log.notes != null))
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: dayLogs
                    .where((log) => log.notes != null)
                    .map((log) => _MealLogNote(notes: log.notes!))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _MealLogEntry extends StatelessWidget {
  final MealLog log;

  const _MealLogEntry({required this.log});

  @override
  Widget build(BuildContext context) {
    final isFollowed = log.status.name == 'followed';

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isFollowed
            ? AppColors.success.withValues(alpha: 0.12)
            : AppColors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            isFollowed ? Icons.check_circle : Icons.restaurant,
            size: 18,
            color: isFollowed ? AppColors.success : AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            date_utils.DateUtils.formatTime(log.loggedTime),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              log.status.displayName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealLogNote extends StatelessWidget {
  final String notes;

  const _MealLogNote({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        top: AppSpacing.xs,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          notes,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
        ),
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? footer;
  final Color accent;

  const _SummaryPill({
    required this.icon,
    required this.label,
    required this.value,
    this.footer,
    this.accent = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          if (footer != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              footer!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
