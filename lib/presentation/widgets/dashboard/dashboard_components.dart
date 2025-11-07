import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/time_provider.dart';
import '../../../data/models/daily_progress.dart';
import '../../../data/models/meal.dart';
import '../../../data/models/meal_log_status.dart';
import 'dashboard_models.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onMenuTap;
  final bool isMenuOpen;
  final DailyProgress dailyProgress;

  const DashboardHeader({
    super.key,
    required this.onMenuTap,
    required this.isMenuOpen,
    required this.dailyProgress,
  });

  @override
  Widget build(BuildContext context) {
    final isToday =
        dailyProgress.date.year == TimeProvider.now().year &&
            dailyProgress.date.month == TimeProvider.now().month &&
            dailyProgress.date.day == TimeProvider.now().day;

    return Row(
      children: [
        GestureDetector(
          onTap: onMenuTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isMenuOpen ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              isMenuOpen ? Icons.close_rounded : Icons.restaurant_menu,
              color: isMenuOpen ? Colors.white : AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    isToday
                        ? 'Today'
                        : '${dailyProgress.date.month}/${dailyProgress.date.day}/${dailyProgress.date.year}',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${dailyProgress.mealsLogged}/${dailyProgress.totalMeals} logged',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _greetingMessage(dailyProgress),
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _greetingMessage(DailyProgress progress) {
    if (progress.unloggedDueMeals >= 3) {
      return 'Let’s log a few meals while the details are fresh.';
    }
    if (progress.unloggedDueMeals == 2) {
      return 'Two meals are waiting for a log — quick updates help a ton.';
    }
    if (progress.unloggedDueMeals == 1) {
      return 'One meal needs a quick log to stay on track.';
    }
    if (progress.dueMeals == 0) {
      return 'You’re all set until the next meal.';
    }
    return 'Nice work staying current — keep the momentum going.';
  }
}

class DashboardAllMealsLoggedCard extends StatelessWidget {
  const DashboardAllMealsLoggedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'All meals logged!',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Great job staying on track today. You can review your entries or jump into the schedule for upcoming days.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardMealFocusCard extends StatelessWidget {
  final MealTimelineEntry entry;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const DashboardMealFocusCard({
    super.key,
    required this.entry,
    required this.isLogging,
    required this.onFollowed,
    required this.onSkipped,
    required this.onAlternative,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final meal = entry.meal;
    final isPrep = entry.state == MealTimelineState.upcomingFar ||
        entry.state == MealTimelineState.upcomingSoon;
    final isOverdue = entry.state == MealTimelineState.overdue;
    final isDue = entry.state == MealTimelineState.dueNow;

    final statusLabel = switch (entry.state) {
      MealTimelineState.overdue => 'Catch up',
      MealTimelineState.dueNow => 'Log now',
      MealTimelineState.upcomingSoon => 'Coming up',
      MealTimelineState.upcomingFar => 'Next meal',
      MealTimelineState.logged => 'Logged',
    };

    final statusColor = switch (entry.state) {
      MealTimelineState.overdue => AppColors.error,
      MealTimelineState.dueNow => AppColors.warning,
      MealTimelineState.upcomingSoon => AppColors.primary,
      MealTimelineState.upcomingFar => AppColors.primaryDark,
      MealTimelineState.logged => AppColors.success,
    };

    final gradientColors = isOverdue
        ? [
            AppColors.error.withValues(alpha: 0.12),
            Colors.white,
          ]
        : isDue
            ? [
                AppColors.warning.withValues(alpha: 0.14),
                Colors.white,
              ]
            : [
                AppColors.primary.withValues(alpha: 0.16),
                Colors.white,
              ];

    final scheduleLine = switch (entry.state) {
      MealTimelineState.overdue ||
      MealTimelineState.dueNow =>
        'Scheduled ${meal.timeScheduled} • ${relativeTimeLabel(entry.timeDifference)}',
      MealTimelineState.upcomingSoon ||
      MealTimelineState.upcomingFar =>
        '${meal.timeScheduled} • ${meal.mealType.displayName} • ${relativeTimeLabel(entry.timeDifference)}',
      MealTimelineState.logged =>
        '${meal.timeScheduled} • ${meal.mealType.displayName}',
    };

    final followLabel = isPrep ? 'Log as eaten' : 'Followed plan';
    final skipLabel = isPrep ? 'Skip meal' : 'Skipped';
    final alternativeLabel =
        isPrep ? 'Log different meal' : 'Log something else';

    final actionWidgets = <Widget>[
      Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: isLogging ? null : () => onFollowed(meal),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(followLabel),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: isLogging ? null : () => onSkipped(meal),
              icon: const Icon(Icons.remove_circle_outline),
              label: Text(skipLabel),
            ),
          ),
        ],
      ),
      const SizedBox(height: AppSpacing.sm),
      SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: isLogging ? null : () => onAlternative(meal),
          icon: const Icon(Icons.edit_note_outlined),
          label: Text(alternativeLabel),
        ),
      ),
    ];

    if (!isPrep) {
      actionWidgets.addAll([
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () => onViewDetails(meal),
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('Review recipe'),
          ),
        ),
      ]);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Text(
                    meal.mealType.emoji,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          statusLabel,
                          style: AppTypography.labelMedium.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        meal.name,
                        style: AppTypography.displaySmall.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        scheduleLine,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => onViewDetails(meal),
                  icon: const Icon(Icons.menu_book_outlined),
                  color: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              meal.description,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.lg),
            ...actionWidgets,
          ],
        ),
      ),
    );
  }
}

class DashboardPendingMealsSection extends StatelessWidget {
  final List<MealTimelineEntry> entries;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const DashboardPendingMealsSection({
    super.key,
    required this.entries,
    required this.isLogging,
    required this.onFollowed,
    required this.onSkipped,
    required this.onAlternative,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final severityMessage = switch (entries.length) {
      >= 3 =>
        'Several meals are waiting — capturing them now keeps your data accurate.',
      2 =>
        'Two meals need attention — a couple quick logs will close the gap.',
      1 => 'One meal is ready to log — take a moment to record it.',
      _ => null,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
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
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.timer_outlined, color: AppColors.warning),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Needs attention',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (severityMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                severityMessage,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: DashboardPendingMealRow(
                entry: entry,
                isLogging: isLogging,
                onFollowed: onFollowed,
                onSkipped: onSkipped,
                onAlternative: onAlternative,
                onViewDetails: onViewDetails,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardPendingMealRow extends StatelessWidget {
  final MealTimelineEntry entry;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const DashboardPendingMealRow({
    super.key,
    required this.entry,
    required this.isLogging,
    required this.onFollowed,
    required this.onSkipped,
    required this.onAlternative,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final meal = entry.meal;
    final isOverdue = entry.state == MealTimelineState.overdue;
    final tintColor = isOverdue ? AppColors.error : AppColors.warning;
    final scheduleLine =
        'Scheduled ${meal.timeScheduled} • ${relativeTimeLabel(entry.timeDifference)}';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: tintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Text(meal.mealType.emoji, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      scheduleLine,
                      style: AppTypography.bodySmall.copyWith(
                        color: tintColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => onViewDetails(meal),
                icon: const Icon(Icons.visibility_outlined),
                color: tintColor,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              OutlinedButton.icon(
                onPressed: isLogging ? null : () => onFollowed(meal),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('Followed'),
              ),
              OutlinedButton.icon(
                onPressed: isLogging ? null : () => onSkipped(meal),
                icon: const Icon(Icons.remove_circle_outline, size: 18),
                label: const Text('Skipped'),
              ),
              TextButton.icon(
                onPressed: isLogging ? null : () => onAlternative(meal),
                icon: const Icon(Icons.edit_note_outlined, size: 18),
                label: const Text('Something else'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardQuickActionsRow extends StatelessWidget {
  final VoidCallback onOpenSchedule;
  final VoidCallback onOpenGroceries;
  final VoidCallback onOpenMealPlan;

  const DashboardQuickActionsRow({
    super.key,
    required this.onOpenSchedule,
    required this.onOpenGroceries,
    required this.onOpenMealPlan,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DashboardQuickActionCard(
            icon: Icons.calendar_today,
            title: 'Full schedule',
            subtitle: 'Preview the whole day',
            onTap: onOpenSchedule,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _DashboardQuickActionCard(
            icon: Icons.shopping_cart_outlined,
            title: 'Groceries',
            subtitle: 'Generate your list',
            onTap: onOpenGroceries,
          ),
        ),
      ],
    );
  }
}

class _DashboardQuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DashboardQuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
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
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardUpcomingMealsPreview extends StatelessWidget {
  final List<MealTimelineEntry> entries;
  final ValueChanged<Meal> onViewDetails;

  const DashboardUpcomingMealsPreview({
    super.key,
    required this.entries,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
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
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.schedule, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Coming up',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...entries.take(3).map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _DashboardUpcomingMealTile(
                    entry: entry,
                    onViewDetails: () => onViewDetails(entry.meal),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _DashboardUpcomingMealTile extends StatelessWidget {
  final MealTimelineEntry entry;
  final VoidCallback onViewDetails;

  const _DashboardUpcomingMealTile({
    required this.entry,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final meal = entry.meal;
    final isSoon = entry.state == MealTimelineState.upcomingSoon;
    final accentColor = isSoon ? AppColors.primary : AppColors.textSecondary;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(meal.mealType.emoji, style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal.name,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${meal.timeScheduled} • ${relativeTimeLabel(entry.timeDifference)}',
                style: AppTypography.bodySmall.copyWith(
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onViewDetails,
          icon: const Icon(Icons.visibility_outlined),
          color: AppColors.primary,
        ),
      ],
    );
  }
}

class DashboardMealsLoggedSection extends StatelessWidget {
  final List<DashboardMealLogEntry> entries;
  final int totalMealsForDay;

  const DashboardMealsLoggedSection({
    super.key,
    required this.entries,
    required this.totalMealsForDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.verified, color: AppColors.success),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Meals logged',
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${entries.length} of $totalMealsForDay logged',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Nothing logged yet. Your updates will appear here.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          else
            ...entries.map(
              (entry) => _DashboardLoggedMealRow(entry: entry),
            ),
        ],
      ),
    );
  }
}

class _DashboardLoggedMealRow extends StatelessWidget {
  final DashboardMealLogEntry entry;

  const _DashboardLoggedMealRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(entry.log.status);
    final statusIcon = _statusIcon(entry.log.status);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.meal.name,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  entry.log.status.displayName,
                  style: AppTypography.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (entry.log.alternativeMeal != null)
                  Text(
                    entry.log.alternativeMeal!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                if (entry.log.notes != null)
                  Text(
                    entry.log.notes!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            '${entry.log.loggedTime.hour.toString().padLeft(2, '0')}:${entry.log.loggedTime.minute.toString().padLeft(2, '0')}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  static Color _statusColor(MealLogStatus status) {
    switch (status) {
      case MealLogStatus.followed:
        return AppColors.success;
      case MealLogStatus.alternative:
        return AppColors.warning;
      case MealLogStatus.skipped:
        return AppColors.error;
    }
  }

  static IconData _statusIcon(MealLogStatus status) {
    switch (status) {
      case MealLogStatus.followed:
        return Icons.check_circle;
      case MealLogStatus.alternative:
        return Icons.restaurant;
      case MealLogStatus.skipped:
        return Icons.remove_circle_outline;
    }
  }
}

String relativeTimeLabel(Duration difference) {
  final isFuture = !difference.isNegative;
  final absolute = difference.abs();

  if (absolute.inMinutes == 0) {
    return isFuture ? 'in under a minute' : 'less than a minute ago';
  }

  if (absolute.inMinutes < 60) {
    final minutes = absolute.inMinutes;
    return isFuture ? 'in $minutes min' : '$minutes min ago';
  }

  final hours = absolute.inHours;
  final minutes = absolute.inMinutes % 60;

  if (minutes == 0) {
    return isFuture ? 'in $hours h' : '$hours h ago';
  }

  return isFuture ? 'in ${hours}h ${minutes}m' : '${hours}h ${minutes}m ago';
}

