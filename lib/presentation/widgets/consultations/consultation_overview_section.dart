import 'package:flutter/material.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/consultation_appointment.dart';
import 'consultation_appointment_card.dart';

class ConsultationOverviewSection extends StatelessWidget {
  const ConsultationOverviewSection({
    super.key,
    this.nextAppointment,
    this.lastAppointment,
    this.onAddToSchedule,
    this.onPrepareReport,
    this.onOpenReport,
    this.onAttachMealPlan,
    this.onViewMealPlan,
    this.onOpenDetails,
    this.isNextAddedToSchedule = false,
    this.hasPreparedReport = false,
  });

  final ConsultationAppointment? nextAppointment;
  final ConsultationAppointment? lastAppointment;
  final ValueChanged<ConsultationAppointment>? onAddToSchedule;
  final ValueChanged<ConsultationAppointment>? onPrepareReport;
  final ValueChanged<ConsultationAppointment>? onOpenReport;
  final ValueChanged<ConsultationAppointment>? onAttachMealPlan;
  final ValueChanged<ConsultationAppointment>? onViewMealPlan;
  final ValueChanged<ConsultationAppointment>? onOpenDetails;
  final bool isNextAddedToSchedule;
  final bool hasPreparedReport;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final last = lastAppointment;
    final hasLinkedPlan = last != null &&
        (last.linkedMealPlan != null || last.outcome?.mealPlan?.plan != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (nextAppointment != null) ...[
          Text(
            localizations.consultationOverview_upcoming,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          ConsultationAppointmentCard(
            label: localizations.consultationOverview_nextAppointment,
            appointment: nextAppointment!,
            isEmphasised: true,
            showOutcomeDetails: false,
            onTap: onOpenDetails == null
                ? null
                : () => onOpenDetails!(nextAppointment!),
            actions: [
              ElevatedButton.icon(
                onPressed: isNextAddedToSchedule || onAddToSchedule == null
                    ? null
                    : () => onAddToSchedule!(nextAppointment!),
                icon: const Icon(Icons.event_available_rounded),
                label: Text(
                  isNextAddedToSchedule
                      ? localizations.consultationOverview_addedToSchedule
                      : localizations.consultationOverview_addToSchedule,
                ),
              ),
              hasPreparedReport
                  ? OutlinedButton.icon(
                      onPressed: onOpenReport == null
                          ? null
                          : () => onOpenReport!(nextAppointment!),
                      icon: const Icon(Icons.description_rounded),
                      label: Text(localizations.openPreparedReport),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryDark,
                      ),
                    )
                  : OutlinedButton.icon(
                      onPressed: onPrepareReport == null
                          ? null
                          : () => onPrepareReport!(nextAppointment!),
                      icon: const Icon(Icons.description_rounded),
                      label: Text(localizations.consultationOverview_prepareReport),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryDark,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (last != null) ...[
          Text(
            localizations.consultationOverview_mostRecent,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          ConsultationAppointmentCard(
            label: localizations.consultationOverview_lastAppointment,
            appointment: last,
            isEmphasised: false,
            showOutcomeDetails: true,
            onTap: onOpenDetails == null ? null : () => onOpenDetails!(last),
            actions: [
              if (last.linkedMealPlan == null && onAttachMealPlan != null)
                OutlinedButton.icon(
                  onPressed: () => onAttachMealPlan!(last),
                  icon: const Icon(Icons.link_rounded),
                  label: Text(localizations.consultationOverview_linkMealPlan),
                ),
              if (hasLinkedPlan && onViewMealPlan != null)
                TextButton.icon(
                  onPressed: () => onViewMealPlan!(last),
                  icon: const Icon(Icons.restaurant_menu_rounded),
                  label: Text(localizations.consultationOverview_viewMealPlan),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
