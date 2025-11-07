import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/time_provider.dart';
import '../../core/utils/message_generator.dart';
import '../../data/models/meal.dart';
import '../../data/models/meal_log.dart';
import '../providers/meal_log_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../providers/progress_provider.dart';
import '../widgets/dashboard/dashboard_all_meals_logged_card.dart';
import '../widgets/dashboard/dashboard_alternative_meal_sheet.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/dashboard_meal_details_sheet.dart';
import '../widgets/dashboard/dashboard_meal_focus_card.dart';
import '../widgets/dashboard/dashboard_meals_logged_section.dart';
import '../widgets/dashboard/dashboard_menu_widget.dart';
import '../widgets/dashboard/dashboard_models.dart';
import '../widgets/dashboard/dashboard_pending_meals_section.dart';
import '../widgets/dashboard/dashboard_quick_actions_row.dart';
import '../widgets/dashboard/dashboard_upcoming_meals_preview.dart';
import '../widgets/success_toast.dart';
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

    await _acknowledgeSwipeCoach();

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

    await _acknowledgeSwipeCoach();

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

      await _acknowledgeSwipeCoach();
    }
  }

  Future<void> _acknowledgeSwipeCoach() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.hasSeenNextMealSwipeHintKey, true);
  }

  void _openMealDetails(Meal meal) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DashboardMealDetailsSheet(meal: meal),
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
                const Icon(
                  Icons.restaurant_menu,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
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
        _today,
        meal.timeScheduled,
      );
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
        .where(
          (entry) =>
              entry.state == MealTimelineState.overdue ||
              entry.state == MealTimelineState.dueNow,
        )
        .where(
          (entry) => focusEntry == null || entry.meal.id != focusEntry.meal.id,
        )
        .toList();

    final upcomingEntries = unloggedEntries
        .where(
          (entry) =>
              entry.state == MealTimelineState.upcomingSoon ||
              entry.state == MealTimelineState.upcomingFar,
        )
        .where(
          (entry) => focusEntry == null || entry.meal.id != focusEntry.meal.id,
        )
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
                                    'focus-${focusEntry.meal.id}-${focusEntry.state.name}',
                                  ),
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
                          onOpenGroceries: _navigateToGroceriesFlow,
                          onOpenMealPlan: _navigateToMealPlanOverview,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (upcomingEntries.isNotEmpty)
                          DashboardUpcomingMealsPreview(
                            entries: upcomingEntries,
                            onViewDetails: _openMealDetails,
                          ),
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
