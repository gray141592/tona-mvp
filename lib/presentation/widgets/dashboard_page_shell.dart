import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class DashboardPageShell extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget>? actions;
  final EdgeInsetsGeometry bodyPadding;
  final VoidCallback? onBack;

  const DashboardPageShell({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.actions,
    this.bodyPadding = EdgeInsets.zero,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  _BackButton(onPressed: onBack),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (subtitle != null && subtitle!.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            subtitle!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: bodyPadding,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _BackButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: AppColors.primary,
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
            return;
          }
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
