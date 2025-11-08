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
import '../../data/mock_data/mock_data.dart';
import '../../data/models/consultation_appointment.dart';
import '../../data/models/meal.dart';
import '../../data/models/meal_log.dart';
import '../providers/meal_log_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../providers/progress_provider.dart';
import '../providers/consultation_provider.dart';
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
import '../widgets/dashboard/dashboard_consultation_followup_card.dart';
import '../widgets/dashboard/dashboard_consultation_reminder_card.dart';
import '../widgets/dashboard/dashboard_upcoming_meals_preview.dart';
import '../widgets/dashboard/dashboard_daily_completion_dialog.dart';
import '../widgets/success_toast.dart';
import 'groceries_flow_screen.dart';
import 'consultations_screen.dart';
import 'consultation_detail_screen.dart';
import 'meal_plan_overview_screen.dart';
import 'report_generation_screen.dart';
import 'report_preview_screen.dart';
import 'weekly_progress_screen.dart';
import 'meal_plan_upload_screen.dart';

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

  bool _hasCompletedAllPlannedMeals() {
    final mealPlanProvider = context.read<MealPlanProvider>();
    final mealLogProvider = context.read<MealLogProvider>();
    final todayMeals = mealPlanProvider.getMealsForDate(_today);

    if (todayMeals.isEmpty) {
      return false;
    }

    return todayMeals.every(
      (meal) => mealLogProvider.getLogForMeal(meal.id, _today) != null,
    );
  }

  Future<void> _showDailyCompletionCelebration() async {
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const DashboardDailyCompletionDialog(),
    );
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
    final didCompleteDay = _hasCompletedAllPlannedMeals();
    if (didCompleteDay) {
      await _showDailyCompletionCelebration();
    } else {
      SuccessToast.show(
        context,
        MessageGenerator.getMealLoggedMessage(meal.name),
        emoji: '🎉',
      );
    }

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
    final didCompleteDay = _hasCompletedAllPlannedMeals();
    if (didCompleteDay) {
      await _showDailyCompletionCelebration();
    } else {
      SuccessToast.show(
        context,
        'Meal marked as skipped',
        emoji: '⏭️',
      );
    }

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
      final didCompleteDay = _hasCompletedAllPlannedMeals();
      if (didCompleteDay) {
        await _showDailyCompletionCelebration();
      } else {
        SuccessToast.show(
          context,
          MessageGenerator.getAlternativeLoggedMessage(meal.name),
          emoji: '✅',
        );
      }

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

  void _navigateToConsultations() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConsultationsScreen(),
      ),
    );
  }

  void _openConsultationDetails(ConsultationAppointment appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConsultationDetailScreen(
          appointmentId: appointment.id,
        ),
      ),
    );
  }

  void _prepareConsultationReport(ConsultationAppointment appointment) {
    final consultationProvider = context.read<ConsultationProvider>();
    consultationProvider.markReportPrepared(appointment.id);

    final lastAppointment = consultationProvider.getLastAppointment();
    final suggestedStart = lastAppointment?.scheduledAt ??
        appointment.scheduledAt.subtract(
          const Duration(days: 7),
        );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportGenerationScreen(
          initialStartDate: suggestedStart,
          initialEndDate: appointment.scheduledAt,
          contextLabel:
              'Preparing for ${date_utils.DateUtils.formatDate(appointment.scheduledAt)} consultation',
        ),
      ),
    );
  }

  void _openPreparedConsultationReport(ConsultationAppointment appointment) {
    final consultationProvider = context.read<ConsultationProvider>();
    if (!consultationProvider.hasPreparedReport(appointment.id)) {
      _prepareConsultationReport(appointment);
      return;
    }

    final lastAppointment = consultationProvider.getLastAppointment();
    final client = MockData.getMockClient();
    DateTime startDate;
    DateTime endDate;

    final report = appointment.outcome?.report;
    if (report != null) {
      endDate = report.generatedAt;
      startDate = report.generatedAt.subtract(const Duration(days: 7));
    } else {
      endDate = appointment.scheduledAt;
      startDate = lastAppointment?.scheduledAt ??
          endDate.subtract(const Duration(days: 7));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportPreviewScreen(
          client: client,
          startDate: startDate,
          endDate: endDate,
        ),
      ),
    );
  }

  Future<void> _addUnplannedMeal() async {
    final didLog = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DashboardAlternativeMealSheet(
        meal: null,
        loggedDate: _today,
        isUnplanned: true,
      ),
    );

    if (didLog == true && mounted) {
      context.read<ProgressProvider>().refresh();
      SuccessToast.show(
        context,
        'Unplanned meal logged',
        emoji: '✅',
      );

      await _acknowledgeSwipeCoach();
    }
  }

  void _navigateToMealPlanOverview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MealPlanOverviewScreen(),
      ),
    );
  }

  Future<void> _startMealPlanUploadFlow(
    ConsultationAppointment appointment,
  ) async {
    final didUpload = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (uploadContext) => MealPlanUploadScreen(
          onFileSelected: () {
            Navigator.of(uploadContext).pop(true);
          },
          showBackButton: true,
        ),
      ),
    );

    if (didUpload == true && mounted) {
      final attachedPlan = context.read<MealPlanProvider>().currentMealPlan;
      if (attachedPlan != null) {
        context.read<ConsultationProvider>().attachMealPlanToAppointment(
              appointmentId: appointment.id,
              mealPlan: attachedPlan,
            );
      }
      context
          .read<ConsultationProvider>()
          .markFollowUpPlanUploaded(appointment.id);
      SuccessToast.show(
        context,
        'Great! New meal plan will be processed and linked to your consultation.',
        emoji: '📄',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealPlanProvider = context.watch<MealPlanProvider>();
    final mealLogProvider = context.watch<MealLogProvider>();
    final progressProvider = context.watch<ProgressProvider>();
    final consultationProvider = context.watch<ConsultationProvider>();
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
    final nextConsultation = consultationProvider.getNextAppointment();
    final lastConsultation = consultationProvider.getLastAppointment();

    final bool showConsultationReminder = nextConsultation != null &&
        !nextConsultation.scheduledAt.isBefore(_now) &&
        nextConsultation.scheduledAt.difference(_now) <=
            AppConstants.consultationReminderLeadTime;

    final bool showConsultationFollowUp = lastConsultation != null &&
        !lastConsultation.hasUploadedFollowUpPlan &&
        !_now.isBefore(lastConsultation.scheduledAt) &&
        _now.difference(lastConsultation.scheduledAt) <=
            AppConstants.consultationFollowUpWindow;

    final followUpAppointment =
        showConsultationFollowUp ? lastConsultation : null;
    final reminderAppointment =
        showConsultationReminder ? nextConsultation : null;

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

    // Add unplanned meals (meals with mealId starting with "unplanned_")
    final allLogsForToday = mealLogProvider.getLogsForDate(_today);
    final unplannedLogs = allLogsForToday
        .where((log) => log.mealId.startsWith('unplanned_'))
        .toList();

    final unplannedMealEntries = unplannedLogs
        .map(
          (log) => DashboardMealLogEntry(
            meal: null,
            log: log,
          ),
        )
        .toList();

    // Combine planned and unplanned meals, sorted by logged time
    final allLoggedMeals = [...loggedMeals, ...unplannedMealEntries]
      ..sort((a, b) => b.log.loggedTime.compareTo(a.log.loggedTime));

    final unloggedEntries =
        timelineEntries.where((entry) => entry.log == null).toList();
    final focusCandidate = _selectFocusEntry(unloggedEntries);

    final catchUpEntries = unloggedEntries
        .where(
          (entry) =>
              entry.state == MealTimelineState.overdue ||
              entry.state == MealTimelineState.dueNow,
        )
        .toList();

    final bool shouldShowFocusCard =
        catchUpEntries.isEmpty && focusCandidate != null;

    final focusEntry = shouldShowFocusCard ? focusCandidate : null;

    final attentionEntries = shouldShowFocusCard && focusEntry != null
        ? catchUpEntries
            .where((entry) => entry.meal.id != focusEntry.meal.id)
            .toList()
        : catchUpEntries;

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
                              : attentionEntries.isEmpty
                                  ? const DashboardAllMealsLoggedCard()
                                  : const SizedBox.shrink(),
                        ),
                        if (attentionEntries.isNotEmpty) ...[
                          DashboardPendingMealsSection(
                            entries: attentionEntries,
                            isLogging: _isLoggingAction,
                            onFollowed: _logMealAsFollowed,
                            onSkipped: _logMealAsSkipped,
                            onAlternative: _logMealAsAlternative,
                            onViewDetails: _openMealDetails,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        const SizedBox(height: AppSpacing.lg),
                        DashboardQuickActionsRow(
                          onOpenGroceries: _navigateToGroceriesFlow,
                          onAddUnplannedMeal: _addUnplannedMeal,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (followUpAppointment != null)
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.lg),
                            child: DashboardConsultationFollowupCard(
                              appointment: followUpAppointment,
                              hasUploadedMealPlan:
                                  followUpAppointment.hasUploadedFollowUpPlan,
                              onUploadMealPlan: () => _startMealPlanUploadFlow(
                                followUpAppointment,
                              ),
                              onViewDetails: () => _openConsultationDetails(
                                followUpAppointment,
                              ),
                            ),
                          )
                        else if (reminderAppointment != null)
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.lg),
                            child: DashboardConsultationReminderCard(
                              appointment: reminderAppointment,
                              isReportPrepared:
                                  consultationProvider.hasPreparedReport(
                                reminderAppointment.id,
                              ),
                              onPrepareReport: () => _prepareConsultationReport(
                                reminderAppointment,
                              ),
                              onOpenReport: () =>
                                  _openPreparedConsultationReport(
                                reminderAppointment,
                              ),
                              onViewDetails: () => _openConsultationDetails(
                                reminderAppointment,
                              ),
                            ),
                          ),
                        if (upcomingEntries.isNotEmpty)
                          DashboardUpcomingMealsPreview(
                            entries: upcomingEntries,
                            onViewDetails: _openMealDetails,
                          ),
                        if (upcomingEntries.isNotEmpty)
                          const SizedBox(height: AppSpacing.lg),
                        DashboardMealsLoggedSection(
                          entries: allLoggedMeals,
                          totalMealsForDay:
                              todayMeals.length + unplannedLogs.length,
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
                onConsultations: _navigateToConsultations,
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
