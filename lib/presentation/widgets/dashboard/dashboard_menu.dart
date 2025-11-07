import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DashboardMenu extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClose;
  final VoidCallback onWeeklyProgress;
  final VoidCallback onReportGeneration;
  final VoidCallback onMealPlanOverview;
  final VoidCallback onDailySchedule;
  final VoidCallback onGroceries;
  final double width;

  const DashboardMenu({
    super.key,
    required this.isVisible,
    required this.onClose,
    required this.onWeeklyProgress,
    required this.onReportGeneration,
    required this.onMealPlanOverview,
    required this.onDailySchedule,
    required this.onGroceries,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isVisible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isVisible ? 1 : 0,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: width,
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 28,
                    offset: const Offset(6, 0),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.restaurant_menu,
                              color: AppColors.primary),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'TONA',
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _DashboardMenuTile(
                      icon: Icons.today_outlined,
                      label: 'Daily schedule',
                      onTap: () {
                        onClose();
                        onDailySchedule();
                      },
                    ),
                    _DashboardMenuTile(
                      icon: Icons.show_chart_outlined,
                      label: 'Weekly progress',
                      onTap: () {
                        onClose();
                        onWeeklyProgress();
                      },
                    ),
                    _DashboardMenuTile(
                      icon: Icons.description_outlined,
                      label: 'Generate report',
                      onTap: () {
                        onClose();
                        onReportGeneration();
                      },
                    ),
                    _DashboardMenuTile(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Groceries list',
                      onTap: () {
                        onClose();
                        onGroceries();
                      },
                    ),
                    _DashboardMenuTile(
                      icon: Icons.restaurant_menu,
                      label: 'Meal plan overview',
                      onTap: () {
                        onClose();
                        onMealPlanOverview();
                      },
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onClose,
                      icon: const Icon(Icons.close_rounded),
                      label: const Text('Close menu'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        label,
        style: AppTypography.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}

