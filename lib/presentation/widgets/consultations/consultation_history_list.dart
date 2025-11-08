import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../data/models/consultation_appointment.dart';
import 'consultation_appointment_card.dart';

class ConsultationHistoryList extends StatelessWidget {
  const ConsultationHistoryList({
    super.key,
    required this.appointments,
    this.onViewMealPlan,
    this.onOpenDetails,
  });

  final List<ConsultationAppointment> appointments;
  final ValueChanged<ConsultationAppointment>? onViewMealPlan;
  final ValueChanged<ConsultationAppointment>? onOpenDetails;

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xl),
        Text(
          'History',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final appointment in appointments)
          ConsultationAppointmentCard(
            label:
                'Consultation ${date_utils.DateUtils.formatShortDate(appointment.scheduledAt)}',
            appointment: appointment,
            showOutcomeDetails: true,
            onTap: onOpenDetails == null
                ? null
                : () => onOpenDetails!(appointment),
            actions: [
              if (onViewMealPlan != null &&
                  (appointment.linkedMealPlan != null ||
                      appointment.outcome?.mealPlan?.plan != null))
                TextButton.icon(
                  onPressed: () => onViewMealPlan!(appointment),
                  icon: const Icon(Icons.restaurant_menu_rounded),
                  label: const Text('View meal plan'),
                ),
            ],
          ),
      ],
    );
  }
}
