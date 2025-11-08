import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final provider = context.read<ConsultationProvider>();
    if (provider.isAddedToSchedule(appointment.id)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This consultation is already on your calendar.'),
          ),
        );
      }
      return;
    }

    try {
      await CalendarLauncher.addToCalendar(appointment);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open calendar. Please try again.'),
        ),
      );
      return;
    }

    provider.markAddedToSchedule(appointment.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added ${date_utils.DateUtils.formatDate(appointment.scheduledAt)} to your calendar list.',
        ),
      ),
    );
  }

  void _prepareReport(
    BuildContext context,
    ConsultationAppointment appointment,
    ConsultationAppointment? lastAppointment,
  ) {
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
              'Preparing for ${date_utils.DateUtils.formatDate(appointment.scheduledAt)} consultation',
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
    final defaultNutritionist = provider.appointments.isNotEmpty
        ? provider.appointments.first.nutritionistName
        : 'Your nutritionist';

    final result = await ConsultationScheduleSheet.show(
      context,
      initialNutritionistName: defaultNutritionist,
    );

    if (!mounted || result == null) return;

    provider.scheduleAppointment(
      scheduledAt: result.scheduledAt,
      nutritionistName: result.nutritionistName,
      meetingFormat: result.meetingFormat,
      location: result.location,
      meetingLink: result.meetingLink,
      preparationNotes: result.preparationNotes,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Consultation scheduled for ${date_utils.DateUtils.formatDate(result.scheduledAt)}.',
        ),
      ),
    );
  }

  void _attachCurrentMealPlan(
    BuildContext context,
    ConsultationAppointment appointment,
  ) {
    final mealPlan = context.read<MealPlanProvider>().currentMealPlan;
    if (mealPlan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No meal plan loaded to link yet.'),
        ),
      );
      return;
    }

    context.read<ConsultationProvider>().attachMealPlanToAppointment(
          appointmentId: appointment.id,
          mealPlan: mealPlan,
        );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Linked ${mealPlan.name} to ${date_utils.DateUtils.formatDate(appointment.scheduledAt)} consultation.',
        ),
      ),
    );
  }

  void _viewMealPlan(
    BuildContext context,
    ConsultationAppointment appointment,
  ) {
    final plan =
        appointment.linkedMealPlan ?? appointment.outcome?.mealPlan?.plan;
    if (plan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No meal plan is linked to this consultation yet.'),
        ),
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
    return Consumer<ConsultationProvider>(
      builder: (context, provider, _) {
        final nextAppointment = provider.getNextAppointment();
        final lastAppointment = provider.getLastAppointment();
        final pastAppointments = provider.getPastAppointments();
        final previousHistory = pastAppointments.length > 1
            ? pastAppointments.sublist(1)
            : const <ConsultationAppointment>[];

        return DashboardPageShell(
          title: 'Consultations',
          subtitle: 'Stay aligned with your nutritionist',
          bodyPadding: EdgeInsets.zero,
          actions: [
            IconButton(
              onPressed: () => _scheduleNewAppointment(context, provider),
              icon: const Icon(Icons.add_circle_outline_rounded),
              tooltip: 'Schedule consultation',
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
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
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
            'No consultations yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Upload a meal plan or connect with your nutritionist to see upcoming appointments.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: onUploadPlan,
            icon: const Icon(Icons.upload_file_rounded),
            label: const Text('Upload meal plan'),
          ),
        ],
      ),
    );
  }
}
