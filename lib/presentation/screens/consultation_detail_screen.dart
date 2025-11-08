import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/time_provider.dart';
import '../../data/mock_data/mock_data.dart';
import '../../data/models/consultation_appointment.dart';
import '../providers/consultation_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../widgets/consultations/consultation_schedule_sheet.dart';
import '../widgets/dashboard_page_shell.dart';
import 'meal_plan_overview_screen.dart';
import 'meal_plan_upload_screen.dart';
import 'report_preview_screen.dart';

class ConsultationDetailScreen extends StatefulWidget {
  const ConsultationDetailScreen({
    super.key,
    required this.appointmentId,
  });

  final String appointmentId;

  @override
  State<ConsultationDetailScreen> createState() =>
      _ConsultationDetailScreenState();
}

class _ConsultationDetailScreenState extends State<ConsultationDetailScreen> {
  late final TextEditingController _notesController;
  late final TextEditingController _focusAreasController;
  Timer? _notesDebounce;
  String? _lastSyncedNotes;
  String? _lastSyncedFocusAreas;
  late final FocusNode _focusAreasFocusNode;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _focusAreasController = TextEditingController();
    _focusAreasFocusNode = FocusNode();
    _focusAreasFocusNode.addListener(_handleFocusAreasFocusChange);
  }

  @override
  void dispose() {
    _notesDebounce?.cancel();
    _notesController.dispose();
    _focusAreasController.dispose();
    _focusAreasFocusNode
      ..removeListener(_handleFocusAreasFocusChange)
      ..dispose();
    super.dispose();
  }

  void _syncControllers(ConsultationAppointment appointment) {
    final notes = appointment.notes ?? '';
    final focusAreasText = appointment.focusAreas.join('\n');

    if (_lastSyncedNotes != notes) {
      _lastSyncedNotes = notes;
      _notesController
        ..text = notes
        ..selection = TextSelection.collapsed(offset: notes.length);
    }

    if (_lastSyncedFocusAreas != focusAreasText) {
      _lastSyncedFocusAreas = focusAreasText;
      _focusAreasController
        ..text = focusAreasText
        ..selection = TextSelection.collapsed(offset: focusAreasText.length);
    }
  }

  void _handleNotesChanged(String value, ConsultationProvider provider) {
    _notesDebounce?.cancel();
    _notesDebounce = Timer(const Duration(milliseconds: 350), () {
      provider.updateNotes(
        appointmentId: widget.appointmentId,
        notes: value.trim().isEmpty ? null : value.trim(),
      );
    });
  }

  void _handleFocusAreasFocusChange() {
    if (!_focusAreasFocusNode.hasFocus && mounted) {
      final provider = context.read<ConsultationProvider>();
      final text = _focusAreasController.text;
      final areas = text
          .split('\n')
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .toList();
      final serialized = areas.join('\n');
      if (serialized == (_lastSyncedFocusAreas ?? '')) {
        return;
      }

      provider.updateFocusAreas(
        appointmentId: widget.appointmentId,
        focusAreas: areas,
      );
      _lastSyncedFocusAreas = serialized;
    }
  }

  Future<void> _reschedule(
    ConsultationAppointment appointment,
    ConsultationProvider provider,
  ) async {
    final result = await ConsultationScheduleSheet.show(
      context,
      initialNutritionistName: appointment.nutritionistName,
      initialScheduledAt: appointment.scheduledAt,
      initialMeetingFormat: appointment.meetingFormat,
      initialLocation: appointment.location,
      initialMeetingLink: appointment.meetingLink,
      initialPreparationNotes: appointment.preparationNotes,
    );

    if (!mounted || result == null) return;

    final newDateTime = result.scheduledAt;
    provider.updateAppointment(
      appointmentId: appointment.id,
      scheduledAt: newDateTime,
      meetingFormat: result.meetingFormat,
      location: result.location,
      meetingLink: result.meetingLink,
      nutritionistName: result.nutritionistName,
      preparationNotes: result.preparationNotes,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Consultation moved to ${date_utils.DateUtils.formatDate(newDateTime)} at ${date_utils.DateUtils.formatTime(newDateTime)}.',
        ),
      ),
    );
  }

  Future<void> _startUploadFlow(
    ConsultationAppointment appointment,
    ConsultationProvider provider,
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

    if (!mounted) return;

    if (didUpload == true) {
      final mealPlan = context.read<MealPlanProvider>().currentMealPlan;
      if (mealPlan != null) {
        provider.attachMealPlanToAppointment(
          appointmentId: appointment.id,
          mealPlan: mealPlan,
        );
      }
      provider.markFollowUpPlanUploaded(appointment.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Meal plan uploaded and linked to this consultation.'),
        ),
      );
    }
  }

  void _viewMealPlan() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MealPlanOverviewScreen(),
      ),
    );
  }

  void _viewReport(ConsultationOutcome? outcome) {
    if (outcome?.report == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No report available yet.')),
      );
      return;
    }

    final report = outcome!.report!;
    final client = MockData.getMockClient();
    final endDate = report.generatedAt;
    final startDate = report.generatedAt.subtract(const Duration(days: 7));

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

  void _openPreparedReport(
    ConsultationProvider provider,
    ConsultationAppointment appointment,
  ) {
    final lastAppointment = provider.getLastAppointment();
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsultationProvider>(
      builder: (context, provider, _) {
        final appointment = provider.getAppointmentById(widget.appointmentId);
        if (appointment == null) {
          return const Scaffold(
            body: Center(
              child: Text('Consultation not found'),
            ),
          );
        }

        _syncControllers(appointment);
        final now = TimeProvider.now();
        final isPast = !appointment.scheduledAt.isAfter(now);
        final linkedPlan =
            appointment.linkedMealPlan ?? appointment.outcome?.mealPlan?.plan;
        final hasPreparedReport = provider.hasPreparedReport(appointment.id);

        return DashboardPageShell(
          title: 'Consultation notes',
          subtitle: date_utils.DateUtils.formatDate(appointment.scheduledAt),
          bodyPadding: EdgeInsets.zero,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              _SummaryCard(appointment: appointment),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: appointment.hasUploadedFollowUpPlan
                    ? null
                    : () => _reschedule(appointment, provider),
                icon: const Icon(Icons.schedule_rounded),
                label: const Text('Reschedule'),
              ),
              if (appointment.hasUploadedFollowUpPlan) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Rescheduling disabled after uploading a follow-up meal plan.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
              if (!appointment.hasUploadedFollowUpPlan &&
                  hasPreparedReport &&
                  !isPast) ...[
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () => _openPreparedReport(provider, appointment),
                  icon: const Icon(Icons.description_outlined),
                  label: const Text('Open prepared report'),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              Text(
                'My notes',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _notesController,
                maxLines: 6,
                minLines: 3,
                onChanged: (value) => _handleNotesChanged(value, provider),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Capture takeaways, adjustments, questions…',
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Focus areas',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _focusAreasController,
                maxLines: 4,
                focusNode: _focusAreasFocusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'One per line (e.g. Pre-workout fueling)',
                ),
              ),
              if (appointment.focusAreas.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: appointment.focusAreas
                      .map(
                        (area) => Chip(
                          label: Text(area),
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.1),
                        ),
                      )
                      .toList(),
                ),
              ],
              if (isPast) ...[
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'After the visit',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton.icon(
                  onPressed: appointment.hasUploadedFollowUpPlan
                      ? null
                      : () => _startUploadFlow(appointment, provider),
                  icon: const Icon(Icons.upload_file_rounded),
                  label: Text(
                    appointment.hasUploadedFollowUpPlan
                        ? 'Meal plan uploaded'
                        : 'Upload new meal plan',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (linkedPlan != null)
                  OutlinedButton.icon(
                    onPressed: _viewMealPlan,
                    icon: const Icon(Icons.restaurant_menu_rounded),
                    label: const Text('View linked meal plan'),
                  ),
                if (appointment.outcome?.report != null)
                  TextButton.icon(
                    onPressed: () => _viewReport(appointment.outcome),
                    icon: const Icon(Icons.description_outlined),
                    label: const Text('View report'),
                  ),
                if (appointment.outcome?.report == null && hasPreparedReport)
                  TextButton.icon(
                    onPressed: () => _openPreparedReport(provider, appointment),
                    icon: const Icon(Icons.description_outlined),
                    label: const Text('Open prepared report'),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.appointment,
  });

  final ConsultationAppointment appointment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date_utils.DateUtils.formatDate(appointment.scheduledAt),
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${appointment.nutritionistName} • ${appointment.meetingFormat}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            date_utils.DateUtils.formatTime(appointment.scheduledAt),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (appointment.location != null &&
              appointment.location!.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.place_outlined, color: AppColors.primary),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    appointment.location!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
          if (appointment.meetingLink != null &&
              appointment.meetingLink!.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.link_rounded, color: AppColors.primary),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    appointment.meetingLink!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryDark,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
