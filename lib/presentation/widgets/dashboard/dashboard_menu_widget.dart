import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DashboardMenu extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClose;
  final VoidCallback onWeeklyProgress;
  final VoidCallback onConsultations;
  final VoidCallback onMealPlanOverview;
  final VoidCallback onGroceries;
  final double width;

  const DashboardMenu({
    super.key,
    required this.isVisible,
    required this.onClose,
    required this.onWeeklyProgress,
    required this.onConsultations,
    required this.onMealPlanOverview,
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
                        SvgPicture.asset(
                          'lib/assets/IR.svg',
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _buildTile(
                      icon: Icons.show_chart_outlined,
                      label: 'Weekly progress',
                      onTap: () {
                        onClose();
                        onWeeklyProgress();
                      },
                    ),
                    _buildTile(
                      icon: Icons.calendar_today_outlined,
                      label: 'Consultations',
                      onTap: () {
                        onClose();
                        onConsultations();
                      },
                    ),
                    _buildTile(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Groceries list',
                      onTap: () {
                        onClose();
                        onGroceries();
                      },
                    ),
                    _buildTile(
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

  Widget _buildTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
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
