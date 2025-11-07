import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../providers/progress_provider.dart';
import '../widgets/dashboard_page_shell.dart';
import '../widgets/weekly_calendar.dart';
import '../../data/models/weekly_progress.dart';
import 'daily_view_screen.dart';

class WeeklyProgressScreen extends StatelessWidget {
  const WeeklyProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();
    final weeklyProgress = progressProvider.getCurrentWeekProgress();

    final subtitle =
        '${date_utils.DateUtils.formatDate(weeklyProgress.weekStartDate)} → ${date_utils.DateUtils.formatDate(weeklyProgress.weekEndDate)}';

    return DashboardPageShell(
      title: 'Weekly progress',
      subtitle: subtitle,
      bodyPadding: const EdgeInsets.all(AppSpacing.md),
      child: ListView(
        children: [
          const SizedBox(height: AppSpacing.md),
          _WeeklyAdherenceCard(
            weeklyProgress: weeklyProgress,
            message: _adherenceMessage(weeklyProgress.adherencePercentage),
          ),
          const SizedBox(height: AppSpacing.lg),
          _WeeklySummaryCard(weeklyProgress: weeklyProgress),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(
            icon: Icons.calendar_view_week,
            title: 'Daily breakdown',
            subtitle: 'Tap any day to review the full plan',
          ),
          const SizedBox(height: AppSpacing.md),
          WeeklyCalendar(
            weeklyProgress: weeklyProgress,
            onDayTap: (date) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DailyViewScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _WeeklyAdherenceCard extends StatelessWidget {
  final WeeklyProgress weeklyProgress;
  final String message;

  const _WeeklyAdherenceCard({
    required this.weeklyProgress,
    required this.message,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly adherence',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${weeklyProgress.adherencePercentage.toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
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
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _WeeklySummaryCard extends StatelessWidget {
  final WeeklyProgress weeklyProgress;

  const _WeeklySummaryCard({required this.weeklyProgress});

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
          _SectionHeader(
            icon: Icons.summarize_rounded,
            title: 'Summary',
            subtitle: 'A quick snapshot of your week',
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  icon: Icons.restaurant_menu,
                  label: 'Total meals',
                  value: weeklyProgress.totalMeals.toString(),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _SummaryTile(
                  icon: Icons.check_circle,
                  label: 'Followed',
                  value:
                      '${weeklyProgress.mealsFollowed}\n${weeklyProgress.adherencePercentage.toStringAsFixed(0)}%',
                  accent: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  icon: Icons.restaurant,
                  label: 'Alternatives',
                  value: weeklyProgress.mealsWithAlternatives.toString(),
                  accent: AppColors.warning,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _SummaryTile(
                  icon: Icons.remove_circle_outline,
                  label: 'Skipped',
                  value: weeklyProgress.mealsSkipped.toString(),
                  accent: AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  icon: Icons.timeline,
                  label: 'Consistency',
                  value: _consistencyLabel(weeklyProgress.adherencePercentage),
                  accent: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _SummaryTile(
                  icon: Icons.task_alt_rounded,
                  label: 'Meals logged',
                  value:
                      '${weeklyProgress.mealsLogged}/${weeklyProgress.totalMeals}',
                  accent: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _consistencyLabel(double percentage) {
    if (percentage >= 90) return 'Elite';
    if (percentage >= 75) return 'Strong';
    if (percentage >= 60) return 'Improving';
    return 'Building';
  }
}

class _SummaryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;

  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
    this.accent = AppColors.primary,
  });

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
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
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

String _adherenceMessage(double percentage) {
  if (percentage >= 90) return 'Outstanding! Keep it up! 🎉';
  if (percentage >= 80) return 'Great work — you\'re in the groove! 💪';
  if (percentage >= 70) return 'Solid progress, keep the streak alive! 👍';
  if (percentage >= 50)
    return 'You\'re on track — let\'s push a little more! 📈';
  return 'Fresh week, fresh opportunity to shine! 🌟';
}
