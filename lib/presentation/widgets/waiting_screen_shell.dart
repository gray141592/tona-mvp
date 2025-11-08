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
  final bool showBackButton;
  final VoidCallback? onBack;

  const WaitingScreenShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.footer,
    this.onClose,
    this.padding,
    this.backgroundGradient,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  State<WaitingScreenShell> createState() => _WaitingScreenShellState();
}

class _WaitingScreenShellState extends State<WaitingScreenShell>
    with SingleTickerProviderStateMixin {
  late Animation<double> _fadeAnimation;

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.showBackButton)
                        Container(
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
                              if (widget.onBack != null) {
                                widget.onBack!();
                                return;
                              }
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                      if (widget.showBackButton)
                        const SizedBox(width: AppSpacing.md),
                      Expanded(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Expanded(
                    child: widget.body,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(width: double.infinity, child: widget.footer),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
