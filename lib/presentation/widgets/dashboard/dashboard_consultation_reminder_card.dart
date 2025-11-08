import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../core/utils/time_provider.dart';
import '../../../data/models/consultation_appointment.dart';

class DashboardConsultationReminderCard extends StatelessWidget {
  const DashboardConsultationReminderCard({
    super.key,
    required this.appointment,
    required this.onPrepareReport,
    required this.onViewDetails,
    this.onOpenReport,
    this.isReportPrepared = false,
  });

  final ConsultationAppointment appointment;
  final VoidCallback onPrepareReport;
  final VoidCallback onViewDetails;
  final VoidCallback? onOpenReport;
  final bool isReportPrepared;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = appointment.scheduledAt;
    final relative = _relativeLabel(date);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 18),
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
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Consultation coming up',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${date_utils.DateUtils.formatDayOfWeek(date)}, ${date_utils.DateUtils.formatDate(date)} • ${date_utils.DateUtils.formatTime(date)}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (relative != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              relative,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Prepare your notes so ${appointment.nutritionistName} has the latest insights. Generating a report now keeps everything ready to review together.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.4,
            ),
          ),
          if (appointment.focusAreas.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: appointment.focusAreas
                  .take(3)
                  .map(
                    (focus) => Chip(
                      backgroundColor: Colors.white.withValues(alpha: 0.16),
                      labelStyle: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      label: Text(focus),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(
                    isReportPrepared
                        ? Icons.check_circle_rounded
                        : Icons.play_circle_rounded,
                  ),
                  onPressed: isReportPrepared
                      ? onOpenReport ?? onPrepareReport
                      : onPrepareReport,
                  label: Text(
                    isReportPrepared ? 'Open report' : 'Prepare report',
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              TextButton(
                onPressed: onViewDetails,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: const Text('View agenda'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _relativeLabel(DateTime date) {
    final now = TimeProvider.now();
    final diff = date.difference(now);
    if (diff.isNegative) {
      return null;
    }
    if (diff.inDays >= 1) {
      final days = diff.inDays;
      return days == 1 ? 'Tomorrow' : 'In $days days';
    }
    if (diff.inHours >= 1) {
      final hours = diff.inHours;
      return hours == 1 ? 'In 1 hour' : 'In $hours hours';
    }
    if (diff.inMinutes >= 1) {
      final minutes = diff.inMinutes;
      return minutes == 1 ? 'In 1 minute' : 'In $minutes minutes';
    }
    return 'Happening soon';
  }
}
