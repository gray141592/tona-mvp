import 'package:flutter/material.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../core/utils/time_provider.dart';
import '../../../data/models/consultation_appointment.dart';

class ConsultationAppointmentCard extends StatelessWidget {
  const ConsultationAppointmentCard({
    super.key,
    required this.label,
    required this.appointment,
    this.isEmphasised = false,
    this.showOutcomeDetails = true,
    this.actions = const [],
    this.onTap,
  });

  final String label;
  final ConsultationAppointment appointment;
  final bool isEmphasised;
  final bool showOutcomeDetails;
  final List<Widget> actions;
  final VoidCallback? onTap;

  String _getLocalizedMeetingFormat(BuildContext context, String format) {
    final localizations = AppLocalizations.of(context)!;
    switch (format) {
      case 'Video call':
        return localizations.consultationSchedule_videoCall;
      case 'In-person':
        return localizations.consultationSchedule_inPerson;
      case 'Phone':
        return localizations.consultationSchedule_phone;
      default:
        return format;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final appointmentDate = appointment.scheduledAt;
    final relativeTime = _buildRelativeDate(context, appointmentDate);
    final formattedDate =
        '${date_utils.DateUtils.formatDayOfWeek(appointmentDate)}, ${date_utils.DateUtils.formatDate(appointmentDate)}';
    final formattedTime = date_utils.DateUtils.formatTime(appointmentDate);
    final planSummary = appointment.outcome?.mealPlan;
    final mealPlanTitle =
        planSummary?.title ?? appointment.linkedMealPlan?.name;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: isEmphasised ? AppColors.primaryLight : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _buildContent(
              context: context,
              formattedDate: formattedDate,
              formattedTime: formattedTime,
              relativeTime: relativeTime,
              planSummary: planSummary,
              mealPlanTitle: mealPlanTitle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required String formattedDate,
    required String formattedTime,
    String? relativeTime,
    ConsultationMealPlanSummary? planSummary,
    String? mealPlanTitle,
  }) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: theme.textTheme.labelMedium?.copyWith(
                      letterSpacing: 0.4,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${appointment.nutritionistName} • ${_getLocalizedMeetingFormat(context, appointment.meetingFormat)}',
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '$formattedDate • $formattedTime',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (relativeTime != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      relativeTime,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (appointment.location != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      appointment.location!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        if (!showOutcomeDetails && mealPlanTitle != null) ...[
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(
            icon: Icons.restaurant_menu,
            label: localizations.consultationCard_mealPlanInEffect,
          ),
          const SizedBox(height: AppSpacing.sm),
          _Panel(
            icon: Icons.task_alt_rounded,
            title: mealPlanTitle,
            subtitle: planSummary != null
                ? 'Effective ${date_utils.DateUtils.formatDate(planSummary.effectiveFrom)}'
                : null,
            items: planSummary?.highlights ?? const [],
          ),
        ],
        if (appointment.focusAreas.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(
            icon: Icons.flag_rounded,
            label: localizations.consultationCard_focusAreas,
          ),
          const SizedBox(height: AppSpacing.sm),
          _BulletList(items: appointment.focusAreas),
        ],
        if (appointment.preparationNotes.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(
            icon: Icons.checklist_outlined,
            label: localizations.consultationCard_preparation,
          ),
          const SizedBox(height: AppSpacing.sm),
          _BulletList(items: appointment.preparationNotes),
        ],
        if (actions.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: actions,
          ),
        ],
      ],
    );
  }

  String? _buildRelativeDate(BuildContext context, DateTime date) {
    final localizations = AppLocalizations.of(context)!;
    final now = TimeProvider.now();
    final difference = date.difference(now);

    if (difference.inDays >= 1) {
      final days = difference.inDays;
      return days == 1
          ? localizations.consultationCard_inDay
          : localizations.consultationCard_inDays(days);
    }

    if (difference.inHours >= 1) {
      final hours = difference.inHours;
      return hours == 1
          ? localizations.consultationCard_inHour
          : localizations.consultationCard_inHours(hours);
    }

    if (difference.inMinutes >= 1) {
      final minutes = difference.inMinutes;
      return minutes == 1
          ? localizations.consultationCard_inMinute
          : localizations.consultationCard_inMinutes(minutes);
    }

    if (difference.inMinutes > -1 && difference.inMinutes < 1) {
      return localizations.consultationCard_happeningNow;
    }

    final pastDifference = now.difference(date);
    if (pastDifference.inDays >= 1) {
      final days = pastDifference.inDays;
      return days == 1
          ? localizations.consultationCard_dayAgo
          : localizations.consultationCard_daysAgo(days);
    }
    if (pastDifference.inHours >= 1) {
      final hours = pastDifference.inHours;
      return hours == 1
          ? localizations.consultationCard_hourAgo
          : localizations.consultationCard_hoursAgo(hours);
    }
    if (pastDifference.inMinutes >= 1) {
      final minutes = pastDifference.inMinutes;
      return minutes == 1
          ? localizations.consultationCard_minuteAgo
          : localizations.consultationCard_minutesAgo(minutes);
    }
    return null;
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: AppColors.primaryDark),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Icon(
                    Icons.circle,
                    size: 6,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    item,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.icon,
    required this.title,
    this.subtitle,
    this.items = const [],
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: AppColors.primaryDark),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (items.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _BulletList(items: items),
          ],
        ],
      ),
    );
  }
}
