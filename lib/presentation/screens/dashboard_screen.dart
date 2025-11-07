import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/time_provider.dart';
import '../../core/utils/message_generator.dart';
import '../../data/models/meal.dart';
import '../../data/models/meal_log.dart';
import '../../data/models/meal_log_status.dart';
import '../../data/models/daily_progress.dart';
import '../providers/meal_log_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../providers/progress_provider.dart';
import '../widgets/dashboard/dashboard_components.dart';
import '../widgets/dashboard/dashboard_menu.dart';
import '../widgets/dashboard/dashboard_models.dart';
import '../widgets/dashboard/dashboard_overlays.dart';
import '../widgets/success_toast.dart';
import 'daily_view_screen.dart';
import 'groceries_flow_screen.dart';
import 'meal_plan_overview_screen.dart';
import 'report_generation_screen.dart';
import 'weekly_progress_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isMenuOpen = false;
  bool _isLoggingAction = false;
  late DateTime _now;
  Timer? _clockTicker;

  static const Duration _preparationLeadTime = Duration(minutes: 90);
  static const Duration _dueAheadWindow = Duration(minutes: 15);
  static const Duration _dueGraceWindow = Duration(minutes: 75);

  DateTime get _today => date_utils.DateUtils.getDateOnly(_now);

  @override
  void initState() {
    super.initState();
    _now = TimeProvider.now();
    _startClockTicker();
  }

  @override
  void dispose() {
    _clockTicker?.cancel();
    super.dispose();
  }

  void _startClockTicker() {
    _clockTicker?.cancel();
    if (TimeProvider.isOverridden) {
      setState(() {
        _now = TimeProvider.now();
      });
      return;
    }

    // Align the first tick to the start of the next minute for smoother updates.
    final now = TimeProvider.now();
    final secondsToNextMinute = 60 - now.second;
    final initialDelay =
        Duration(seconds: secondsToNextMinute == 0 ? 60 : secondsToNextMinute);
    _clockTicker = Timer(initialDelay, () {
      if (!mounted) return;
      _handleClockTick();
      _clockTicker = Timer.periodic(const Duration(minutes: 1), (_) {
        if (!mounted) return;
        _handleClockTick();
      });
    });
  }

  void _handleClockTick() {
    setState(() {
      _now = TimeProvider.now();
    });
  }

  MealTimelineState _resolveMealState(DateTime scheduled, MealLog? log) {
    if (log != null) {
      return MealTimelineState.logged;
    }

    final diff = scheduled.difference(_now);

    if (diff <= _dueAheadWindow && diff >= -_dueGraceWindow) {
      return MealTimelineState.dueNow;
    }

    if (diff < -_dueGraceWindow) {
      return MealTimelineState.overdue;
    }

    if (diff <= _preparationLeadTime) {
      return MealTimelineState.upcomingSoon;
    }

    return MealTimelineState.upcomingFar;
  }

  MealTimelineEntry? _selectFocusEntry(List<MealTimelineEntry> entries) {
    if (entries.isEmpty) return null;

    final prioritizedStates = [
      MealTimelineState.overdue,
      MealTimelineState.dueNow,
      MealTimelineState.upcomingSoon,
      MealTimelineState.upcomingFar,
    ];

    for (final state in prioritizedStates) {
      final match = _firstWhereOrNull(entries, (entry) => entry.state == state);
      if (match != null) {
        return match;
      }
    }

    return entries.first;
  }

  MealTimelineEntry? _firstWhereOrNull(
    Iterable<MealTimelineEntry> entries,
    bool Function(MealTimelineEntry entry) test,
  ) {
    for (final entry in entries) {
      if (test(entry)) {
        return entry;
      }
    }
    return null;
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  Future<void> _logMealAsFollowed(Meal meal) async {
    if (_isLoggingAction) return;
    setState(() => _isLoggingAction = true);

    final mealLogProvider = context.read<MealLogProvider>();
    await mealLogProvider.logMealAsFollowed(
      clientId: AppConstants.mockClientId,
      mealId: meal.id,
      loggedDate: _today,
    );

    if (!mounted) return;
    context.read<ProgressProvider>().refresh();
    SuccessToast.show(
      context,
      MessageGenerator.getMealLoggedMessage(meal.name),
      emoji: '🎉',
    );

    setState(() => _isLoggingAction = false);
  }

  Future<void> _logMealAsSkipped(Meal meal) async {
    if (_isLoggingAction) return;
    setState(() => _isLoggingAction = true);

    final mealLogProvider = context.read<MealLogProvider>();
    await mealLogProvider.logMealAsSkipped(
      clientId: AppConstants.mockClientId,
      mealId: meal.id,
      loggedDate: _today,
    );

    if (!mounted) return;
    context.read<ProgressProvider>().refresh();
    SuccessToast.show(
      context,
      'Meal marked as skipped',
      emoji: '⏭️',
    );

    setState(() => _isLoggingAction = false);
  }

  Future<void> _logMealAsAlternative(Meal meal) async {
    final didLog = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DashboardAlternativeMealSheet(
        meal: meal,
        loggedDate: _today,
      ),
    );

    if (didLog == true && mounted) {
      context.read<ProgressProvider>().refresh();
      SuccessToast.show(
        context,
        MessageGenerator.getAlternativeLoggedMessage(meal.name),
        emoji: '✅',
      );
    }
  }

  void _openMealDetails(Meal meal) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DashboardMealDetailsSheet(meal: meal),
    );
  }

  void _navigateToDailySchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DailyViewScreen(),
      ),
    );
  }

  void _navigateToGroceriesFlow() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroceriesFlowScreen(),
      ),
    );
  }

  void _navigateToWeeklyProgress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WeeklyProgressScreen(),
      ),
    );
  }

  void _navigateToReportGeneration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReportGenerationScreen(),
      ),
    );
  }

  void _navigateToMealPlanOverview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MealPlanOverviewScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealPlanProvider = context.watch<MealPlanProvider>();
    final mealLogProvider = context.watch<MealLogProvider>();
    final progressProvider = context.watch<ProgressProvider>();
    final mealPlan = mealPlanProvider.currentMealPlan;

    if (mealPlan == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.restaurant_menu,
                    size: 64, color: AppColors.textSecondary),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Upload a meal plan to get started',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final todayMeals = mealPlanProvider.getMealsForDate(_today);
    final dailyProgress = progressProvider.getDailyProgress(_today);

    final timelineEntries = todayMeals.map((meal) {
      final scheduled = date_utils.DateUtils.combineDateWithTimeString(
          _today, meal.timeScheduled);
      final log = mealLogProvider.getLogForMeal(meal.id, _today);
      final state = _resolveMealState(scheduled, log);

      return MealTimelineEntry(
        meal: meal,
        log: log,
        scheduledTime: scheduled,
        state: state,
        timeDifference: scheduled.difference(_now),
      );
    }).toList()
      ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));

    final loggedMeals = timelineEntries
        .where((entry) => entry.log != null)
        .map(
          (entry) => DashboardMealLogEntry(
            meal: entry.meal,
            log: entry.log!,
          ),
        )
        .toList();

    final unloggedEntries =
        timelineEntries.where((entry) => entry.log == null).toList();
    final focusEntry = _selectFocusEntry(unloggedEntries);

    final catchUpEntries = unloggedEntries
        .where((entry) =>
            entry.state == MealTimelineState.overdue ||
            entry.state == MealTimelineState.dueNow)
        .where((entry) =>
            focusEntry == null || entry.meal.id != focusEntry.meal.id)
        .toList();

    final upcomingEntries = unloggedEntries
        .where((entry) =>
            entry.state == MealTimelineState.upcomingSoon ||
            entry.state == MealTimelineState.upcomingFar)
        .where((entry) =>
            focusEntry == null || entry.meal.id != focusEntry.meal.id)
        .toList();

    final sidebarWidth = MediaQuery.of(context).size.width * 0.78;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: DashboardHeader(
                    onMenuTap: _toggleMenu,
                    isMenuOpen: _isMenuOpen,
                    dailyProgress: dailyProgress,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.lg),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: focusEntry != null
                              ? DashboardMealFocusCard(
                                  key: ValueKey(
                                      'focus-${focusEntry.meal.id}-${focusEntry.state.name}'),
                                  entry: focusEntry,
                                  isLogging: _isLoggingAction,
                                  onFollowed: _logMealAsFollowed,
                                  onSkipped: _logMealAsSkipped,
                                  onAlternative: _logMealAsAlternative,
                                  onViewDetails: _openMealDetails,
                                )
                              : const DashboardAllMealsLoggedCard(),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (catchUpEntries.isNotEmpty) ...[
                          DashboardPendingMealsSection(
                            entries: catchUpEntries,
                            isLogging: _isLoggingAction,
                            onFollowed: _logMealAsFollowed,
                            onSkipped: _logMealAsSkipped,
                            onAlternative: _logMealAsAlternative,
                            onViewDetails: _openMealDetails,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        DashboardQuickActionsRow(
                          onOpenSchedule: _navigateToDailySchedule,
                          onOpenGroceries: _navigateToGroceriesFlow,
                          onOpenMealPlan: _navigateToMealPlanOverview,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (upcomingEntries.isNotEmpty)
                          DashboardUpcomingMealsPreview(
                              entries: upcomingEntries,
                              onViewDetails: _openMealDetails),
                        if (upcomingEntries.isNotEmpty)
                          const SizedBox(height: AppSpacing.lg),
                        DashboardMealsLoggedSection(
                          entries: loggedMeals,
                          totalMealsForDay: todayMeals.length,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isMenuOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _toggleMenu,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.2),
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              top: 0,
              bottom: 0,
              left: _isMenuOpen ? 0 : -sidebarWidth,
              child: DashboardMenu(
                isVisible: _isMenuOpen,
                onClose: _toggleMenu,
                onWeeklyProgress: _navigateToWeeklyProgress,
                onReportGeneration: _navigateToReportGeneration,
                onMealPlanOverview: _navigateToMealPlanOverview,
                onDailySchedule: _navigateToDailySchedule,
                onGroceries: _navigateToGroceriesFlow,
                width: sidebarWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealLogEntry {
  final Meal meal;
  final MealLog log;

  MealLogEntry({required this.meal, required this.log});
}

enum MealTimelineState {
  upcomingFar,
  upcomingSoon,
  dueNow,
  overdue,
  logged,
}

class MealTimelineEntry {
  final Meal meal;
  final MealLog? log;
  final DateTime scheduledTime;
  final MealTimelineState state;
  final Duration timeDifference;

  const MealTimelineEntry({
    required this.meal,
    required this.log,
    required this.scheduledTime,
    required this.state,
    required this.timeDifference,
  });
}

class _DashboardHeader extends StatelessWidget {
  final VoidCallback onMenuTap;
  final bool isMenuOpen;
  final DailyProgress dailyProgress;

  const _DashboardHeader({
    required this.onMenuTap,
    required this.isMenuOpen,
    required this.dailyProgress,
  });

  @override
  Widget build(BuildContext context) {
    final isToday =
        date_utils.DateUtils.isSameDay(dailyProgress.date, TimeProvider.now());

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
                        : date_utils.DateUtils.formatDate(dailyProgress.date),
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

class _MealFocusCard extends StatelessWidget {
  final MealTimelineEntry entry;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const _MealFocusCard({
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

    final statusLabel = () {
      switch (entry.state) {
        case MealTimelineState.overdue:
          return 'Catch up';
        case MealTimelineState.dueNow:
          return 'Log now';
        case MealTimelineState.upcomingSoon:
          return 'Coming up';
        case MealTimelineState.upcomingFar:
          return 'Next meal';
        case MealTimelineState.logged:
          return 'Logged';
      }
    }();

    final statusColor = () {
      switch (entry.state) {
        case MealTimelineState.overdue:
          return AppColors.error;
        case MealTimelineState.dueNow:
          return AppColors.warning;
        case MealTimelineState.upcomingSoon:
          return AppColors.primary;
        case MealTimelineState.upcomingFar:
          return AppColors.primaryDark;
        case MealTimelineState.logged:
          return AppColors.success;
      }
    }();

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

    final scheduleLine = () {
      switch (entry.state) {
        case MealTimelineState.overdue:
        case MealTimelineState.dueNow:
          return 'Scheduled ${meal.timeScheduled} • ${_relativeTimeLabel(entry.timeDifference)}';
        case MealTimelineState.upcomingSoon:
        case MealTimelineState.upcomingFar:
          return '${meal.timeScheduled} • ${meal.mealType.displayName} • ${_relativeTimeLabel(entry.timeDifference)}';
        case MealTimelineState.logged:
          return '${meal.timeScheduled} • ${meal.mealType.displayName}';
      }
    }();

    final followLabel = isPrep ? 'Log as eaten' : 'Followed plan';
    final skipLabel = isPrep ? 'Skip meal' : 'Skipped';
    final alternativeLabel =
        isPrep ? 'Log different meal' : 'Log something else';

    final actionWidgets = <Widget>[];

    actionWidgets.add(
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
    );
    actionWidgets.add(const SizedBox(height: AppSpacing.sm));

    actionWidgets.add(
      SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: isLogging ? null : () => onAlternative(meal),
          icon: const Icon(Icons.edit_note_outlined),
          label: Text(alternativeLabel),
        ),
      ),
    );

    if (!isPrep) {
      actionWidgets.add(const SizedBox(height: AppSpacing.xs));
      actionWidgets.add(
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () => onViewDetails(meal),
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('Review recipe'),
          ),
        ),
      );
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

class _AllMealsLoggedCard extends StatelessWidget {
  const _AllMealsLoggedCard();

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

class _PendingMealsSection extends StatelessWidget {
  final List<MealTimelineEntry> entries;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const _PendingMealsSection({
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

    final severityMessage = _severityLabel(entries.length);

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
                child:
                    const Icon(Icons.timer_outlined, color: AppColors.warning),
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
              child: _PendingMealRow(
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

  String? _severityLabel(int count) {
    if (count >= 3) {
      return 'Several meals are waiting — capturing them now keeps your data accurate.';
    }
    if (count == 2) {
      return 'Two meals need attention — a couple quick logs will close the gap.';
    }
    if (count == 1) {
      return 'One meal is ready to log — take a moment to record it.';
    }
    return null;
  }
}

class _PendingMealRow extends StatelessWidget {
  final MealTimelineEntry entry;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const _PendingMealRow({
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
        'Scheduled ${meal.timeScheduled} • ${_relativeTimeLabel(entry.timeDifference)}';

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
                child: Text(meal.mealType.emoji,
                    style: const TextStyle(fontSize: 18)),
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

class _QuickActionsRow extends StatelessWidget {
  final VoidCallback onOpenSchedule;
  final VoidCallback onOpenGroceries;
  final VoidCallback onOpenMealPlan;

  const _QuickActionsRow({
    required this.onOpenSchedule,
    required this.onOpenGroceries,
    required this.onOpenMealPlan,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icons.calendar_today,
            title: 'Full schedule',
            subtitle: 'Preview the whole day',
            onTap: onOpenSchedule,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _QuickActionCard(
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

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
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

class _UpcomingMealsPreview extends StatelessWidget {
  final List<MealTimelineEntry> entries;
  final ValueChanged<Meal> onViewDetails;

  const _UpcomingMealsPreview({
    required this.entries,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

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
                  child: _UpcomingMealTile(
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

class _UpcomingMealTile extends StatelessWidget {
  final MealTimelineEntry entry;
  final VoidCallback onViewDetails;

  const _UpcomingMealTile({
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
          child:
              Text(meal.mealType.emoji, style: const TextStyle(fontSize: 18)),
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
                '${meal.timeScheduled} • ${_relativeTimeLabel(entry.timeDifference)}',
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

class _MealsLoggedSection extends StatelessWidget {
  final List<MealLogEntry> entries;
  final int totalMealsForDay;

  const _MealsLoggedSection({
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
            ...entries.map((entry) => _LoggedMealRow(entry: entry)),
        ],
      ),
    );
  }
}

class _LoggedMealRow extends StatelessWidget {
  final MealLogEntry entry;

  const _LoggedMealRow({required this.entry});

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
            date_utils.DateUtils.formatTime(entry.log.loggedTime),
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

class _DashboardMenu extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClose;
  final VoidCallback onWeeklyProgress;
  final VoidCallback onReportGeneration;
  final VoidCallback onMealPlanOverview;
  final VoidCallback onDailySchedule;
  final VoidCallback onGroceries;
  final double width;

  const _DashboardMenu({
    required this.isVisible,
    required this.onClose,
    required this.onWeeklyProgress,
    required this.onReportGeneration,
    required this.onMealPlanOverview,
    required this.onDailySchedule,
    required this.onGroceries,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isVisible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isVisible ? 1 : 0,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: width,
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 28,
                    offset: const Offset(6, 0),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.restaurant_menu,
                              color: AppColors.primary),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'TONA',
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _MenuTile(
                      icon: Icons.today_outlined,
                      label: 'Daily schedule',
                      onTap: () {
                        onClose();
                        onDailySchedule();
                      },
                    ),
                    _MenuTile(
                      icon: Icons.show_chart_outlined,
                      label: 'Weekly progress',
                      onTap: () {
                        onClose();
                        onWeeklyProgress();
                      },
                    ),
                    _MenuTile(
                      icon: Icons.description_outlined,
                      label: 'Generate report',
                      onTap: () {
                        onClose();
                        onReportGeneration();
                      },
                    ),
                    _MenuTile(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Groceries list',
                      onTap: () {
                        onClose();
                        onGroceries();
                      },
                    ),
                    _MenuTile(
                      icon: Icons.restaurant_menu,
                      label: 'Meal plan overview',
                      onTap: () {
                        onClose();
                        onMealPlanOverview();
                      },
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onClose,
                      icon: const Icon(Icons.close_rounded),
                      label: const Text('Close menu'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        label,
        style: AppTypography.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}

String _relativeTimeLabel(Duration difference) {
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

class _AlternativeMealSheet extends StatefulWidget {
  final Meal meal;
  final DateTime loggedDate;

  const _AlternativeMealSheet({
    required this.meal,
    required this.loggedDate,
  });

  @override
  State<_AlternativeMealSheet> createState() => _AlternativeMealSheetState();
}

class _AlternativeMealSheetState extends State<_AlternativeMealSheet> {
  final _alternativeController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  @override
  void dispose() {
    _alternativeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving || !_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final mealLogProvider = context.read<MealLogProvider>();
    await mealLogProvider.logMealAsAlternative(
      clientId: AppConstants.mockClientId,
      mealId: widget.meal.id,
      loggedDate: widget.loggedDate,
      alternativeMeal: _alternativeController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.xl,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Log alternative',
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.meal.name,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _alternativeController,
                  decoration: const InputDecoration(
                    labelText: 'What did you eat instead?',
                    hintText: 'Describe the meal you had...',
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please provide a short description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes (optional)',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: AppSpacing.xl),
                ElevatedButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(_isSaving ? 'Saving...' : 'Save alternative'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MealDetailsSheet extends StatelessWidget {
  final Meal meal;

  const _MealDetailsSheet({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.xl,
        bottom: AppSpacing.lg + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              meal.name,
              style: AppTypography.displaySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${meal.timeScheduled} • ${meal.mealType.displayName}',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              meal.description,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Ingredients',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            if (meal.ingredients.isEmpty)
              Text(
                'No ingredient list provided for this meal.',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
            else
              ...meal.ingredients.map(
                (ingredient) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(
                        child: Text(
                          ingredient,
                          style: AppTypography.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
