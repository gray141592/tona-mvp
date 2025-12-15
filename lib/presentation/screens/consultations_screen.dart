import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/calendar_launcher.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../data/mock_data/mock_data.dart';
import '../../data/models/consultation_appointment.dart';
import '../providers/consultation_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../widgets/consultations/consultation_history_list.dart';
import '../widgets/consultations/consultation_overview_section.dart';
import '../widgets/consultations/consultation_schedule_sheet.dart';
import '../widgets/dashboard_page_shell.dart';
import '../widgets/success_toast.dart';
import 'consultation_detail_screen.dart';
import 'report_generation_screen.dart';
import 'report_preview_screen.dart';
import 'meal_plan_overview_screen.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  Future<void> _addToSchedule(
    BuildContext context,
    ConsultationAppointment appointment,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<ConsultationProvider>();
    if (provider.isAddedToSchedule(appointment.id)) {
      if (mounted) {
        SuccessToast.show(
          context,
          localizations.alreadyOnYourCalendar,
          emoji: '📅',
          type: ToastType.info,
        );
      }
      return;
    }

    try {
      await CalendarLauncher.addToCalendar(appointment);
    } catch (error) {
      if (!mounted) return;
      if (!context.mounted) return;
      SuccessToast.show(
        context,
        localizations.calendarUnavailable,
        emoji: '⚠️',
        type: ToastType.warning,
      );
      return;
    }

    provider.markAddedToSchedule(appointment.id);
    if (!mounted) return;
    if (!context.mounted) return;
    SuccessToast.show(
      context,
      localizations.addedToCalendar(date_utils.DateUtils.formatDate(appointment.scheduledAt)),
      emoji: '✅',
    );
  }

  void _prepareReport(
    BuildContext context,
    ConsultationAppointment appointment,
    ConsultationAppointment? lastAppointment,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final provider = context.read<ConsultationProvider>();
    provider.markReportPrepared(appointment.id);

    final suggestedStart = lastAppointment?.scheduledAt ??
        appointment.scheduledAt.subtract(
          const Duration(days: 7),
        );
    final suggestedEnd = appointment.scheduledAt;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportGenerationScreen(
          initialStartDate: suggestedStart,
          initialEndDate: suggestedEnd,
          contextLabel:
              localizations.preparingForConsultation(date_utils.DateUtils.formatDate(appointment.scheduledAt)),
        ),
      ),
    );
  }

  void _openPreparedReport(
    BuildContext context,
    ConsultationAppointment appointment,
    ConsultationAppointment? lastAppointment,
  ) {
    final provider = context.read<ConsultationProvider>();
    if (!provider.hasPreparedReport(appointment.id)) {
      return;
    }

    final report = appointment.outcome?.report;
    final client = MockData.getMockClient();
    DateTime startDate;
    DateTime endDate;

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

  Future<void> _scheduleNewAppointment(
    BuildContext context,
    ConsultationProvider provider,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final defaultNutritionist = provider.appointments.isNotEmpty
        ? provider.appointments.first.nutritionistName
        : localizations.yourNutritionist;

    final result = await ConsultationScheduleSheet.show(
      context,
      initialNutritionistName: defaultNutritionist,
    );

    if (!mounted || result == null) return;
    if (!context.mounted) return;

    provider.scheduleAppointment(
      scheduledAt: result.scheduledAt,
      nutritionistName: result.nutritionistName,
      meetingFormat: result.meetingFormat,
      location: result.location,
      meetingLink: result.meetingLink,
      preparationNotes: result.preparationNotes,
    );

    SuccessToast.show(
      context,
      localizations.consultationScheduledFor(date_utils.DateUtils.formatDate(result.scheduledAt)),
      emoji: '🗓️',
    );
  }

  void _attachCurrentMealPlan(
    BuildContext context,
    ConsultationAppointment appointment,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final mealPlan = context.read<MealPlanProvider>().currentMealPlan;
    if (mealPlan == null) {
      SuccessToast.show(
        context,
        localizations.noMealPlanLoaded,
        emoji: 'ℹ️',
        type: ToastType.info,
      );
      return;
    }

    context.read<ConsultationProvider>().attachMealPlanToAppointment(
          appointmentId: appointment.id,
          mealPlan: mealPlan,
        );

    SuccessToast.show(
      context,
      localizations.linkedMealPlanToConsultation(mealPlan.name, date_utils.DateUtils.formatDate(appointment.scheduledAt)),
      emoji: '🔗',
    );
  }

  void _viewMealPlan(
    BuildContext context,
    ConsultationAppointment appointment,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final plan =
        appointment.linkedMealPlan ?? appointment.outcome?.mealPlan?.plan;
    if (plan == null) {
      SuccessToast.show(
        context,
        localizations.noMealPlanLinked,
        emoji: 'ℹ️',
        type: ToastType.info,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MealPlanOverviewScreen(),
      ),
    );
  }

  void _openDetails(
    BuildContext context,
    String appointmentId,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConsultationDetailScreen(
          appointmentId: appointmentId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<ConsultationProvider>(
      builder: (context, provider, _) {
        final nextAppointment = provider.getNextAppointment();
        final lastAppointment = provider.getLastAppointment();
        final pastAppointments = provider.getPastAppointments();
        final previousHistory = pastAppointments.length > 1
            ? pastAppointments.sublist(1)
            : const <ConsultationAppointment>[];

        return DashboardPageShell(
          title: localizations.consultations,
          subtitle: localizations.consultationsSubtitle,
          bodyPadding: EdgeInsets.zero,
          actions: [
            IconButton(
              onPressed: () => _scheduleNewAppointment(context, provider),
              icon: const Icon(Icons.add_circle_outline_rounded),
              tooltip: localizations.scheduleConsultation,
              color: AppColors.primary,
            ),
          ],
          child: (nextAppointment == null && lastAppointment == null)
              ? _EmptyConsultationsState(
                  onUploadPlan: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                )
              : ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    ConsultationOverviewSection(
                      nextAppointment: nextAppointment,
                      lastAppointment: lastAppointment,
                      isNextAddedToSchedule: nextAppointment == null
                          ? false
                          : provider.isAddedToSchedule(nextAppointment.id),
                      hasPreparedReport: nextAppointment == null
                          ? false
                          : provider.hasPreparedReport(nextAppointment.id),
                      onAddToSchedule: nextAppointment == null
                          ? null
                          : (appointment) =>
                              _addToSchedule(context, appointment),
                      onPrepareReport: nextAppointment == null
                          ? null
                          : (appointment) => _prepareReport(
                                context,
                                appointment,
                                lastAppointment,
                              ),
                      onOpenReport: nextAppointment == null
                          ? null
                          : (appointment) => _openPreparedReport(
                                context,
                                appointment,
                                lastAppointment,
                              ),
                      onAttachMealPlan: lastAppointment == null
                          ? null
                          : (appointment) =>
                              _attachCurrentMealPlan(context, appointment),
                      onViewMealPlan: (appointment) =>
                          _viewMealPlan(context, appointment),
                      onOpenDetails: (appointment) =>
                          _openDetails(context, appointment.id),
                    ),
                    ConsultationHistoryList(
                      appointments: previousHistory,
                      onViewMealPlan: (appointment) =>
                          _viewMealPlan(context, appointment),
                      onOpenDetails: (appointment) =>
                          _openDetails(context, appointment.id),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
        );
      },
    );
  }
}

class _EmptyConsultationsState extends StatelessWidget {
  const _EmptyConsultationsState({
    required this.onUploadPlan,
  });

  final VoidCallback onUploadPlan;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              size: 48,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            localizations.noConsultationsYet,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            localizations.noConsultationsYetBody,
            textAlign: TextAlign.center,
            style: Theme.of((context)).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: onUploadPlan,
            icon: const Icon(Icons.upload_file_rounded),
            label: Text(localizations.uploadMealPlan),
          ),
        ],
      ),
    );
  }
}
