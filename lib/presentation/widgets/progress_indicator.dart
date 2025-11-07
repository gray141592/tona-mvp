import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';

class ProgressIndicator extends StatefulWidget {
  final int current;
  final int total;
  final String label;

  const ProgressIndicator({
    super.key,
    required this.current,
    required this.total,
    required this.label,
  });

  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.total > 0 ? (widget.current / widget.total) : 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(ProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.current != widget.current) {
      _controller.reset();
      _progressAnimation = Tween<double>(
        begin:
            oldWidget.total > 0 ? (oldWidget.current / oldWidget.total) : 0.0,
        end: widget.total > 0 ? (widget.current / widget.total) : 0.0,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
      _controller.forward();

      // Haptic feedback on progress
      if (widget.current > oldWidget.current) {
        HapticFeedback.lightImpact();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _percentage =>
      widget.total > 0 ? (widget.current / widget.total) * 100 : 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        final animatedProgress = _progressAnimation.value;
        final animatedPercentage = (animatedProgress * 100).clamp(0.0, 100.0);
        final displayProgress = animatedProgress.clamp(0.0, 1.0);

        return Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.18),
                AppColors.surface,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12),
                blurRadius: 32,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.emoji_events_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        widget.label,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      '${widget.current}/${widget.total}',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Stack(
                children: [
                  Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: displayProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.success,
                              AppColors.secondary,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    animatedProgress >= 1
                        ? 'All meals logged — great job!'
                        : '${animatedPercentage.toStringAsFixed(0)}% complete',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (_percentage >= 100)
                    Row(
                      children: [
                        const Icon(
                          Icons.celebration,
                          color: AppColors.secondary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Perfect!',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
