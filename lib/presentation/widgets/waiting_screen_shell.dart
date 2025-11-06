import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class WaitingScreenShell extends StatefulWidget {
  final String title;
  final Widget subtitle;
  final Widget body;
  final Widget? footer;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry? padding;
  final Gradient? backgroundGradient;

  const WaitingScreenShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.footer,
    this.onClose,
    this.padding,
    this.backgroundGradient,
  });

  @override
  State<WaitingScreenShell> createState() => _WaitingScreenShellState();
}

class _WaitingScreenShellState extends State<WaitingScreenShell> with SingleTickerProviderStateMixin {
  late Animation<double> _fadeAnimation;

  late Animation<Offset> _slideAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTypography.displayMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  widget.subtitle,
                  const SizedBox(height: AppSpacing.xxl),
                  Expanded(
                    child: widget.body,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: widget.footer
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

