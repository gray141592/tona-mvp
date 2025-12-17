import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../core/utils/time_provider.dart';
import '../../../data/models/daily_progress.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onMenuTap;
  final bool isMenuOpen;
  final DailyProgress dailyProgress;

  const DashboardHeader({
    super.key,
    required this.onMenuTap,
    required this.isMenuOpen,
    required this.dailyProgress,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isToday =
        date_utils.DateUtils.isSameDay(dailyProgress.date, TimeProvider.now());
    final statusLabel = _statusLabel(dailyProgress, localizations);

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
            child: SvgPicture.asset(
              'assets/IR-logo.svg',
              width: 20,
              height: 24,
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
                        ? localizations.dashboard_today
                        : date_utils.DateUtils.formatDate(dailyProgress.date),
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (statusLabel != null) ...[
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
                        statusLabel,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _greetingMessage(dailyProgress, localizations),
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

  String _greetingMessage(DailyProgress progress, AppLocalizations localizations) {
    if (progress.unloggedDueMeals >= 3) {
      return localizations.dashboard_greeting_unlogged_3;
    }
    if (progress.unloggedDueMeals == 2) {
      return localizations.dashboard_greeting_unlogged_2;
    }
    if (progress.unloggedDueMeals == 1) {
      return localizations.dashboard_greeting_unlogged_1;
    }
    if (progress.dueMeals == 0) {
      return localizations.dashboard_greeting_all_set;
    }
    return localizations.dashboard_greeting_good_job;
  }

  String? _statusLabel(DailyProgress progress, AppLocalizations localizations) {
    if (progress.unloggedDueMeals > 0) {
      final count = progress.unloggedDueMeals;
      final mealLabel = count == 1 ? localizations.mealLabel : localizations.mealsLabel;
      return localizations.dashboard_status_overdue(count, mealLabel);
    }

    if (progress.mealsLogged > 0) {
      final count = progress.mealsLogged;
      final mealLabel = count == 1 ? localizations.mealLabel : localizations.mealsLabel;
      return localizations.dashboard_status_logged(count, mealLabel);
    }

    return null;
  }
}
