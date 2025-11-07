import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

const Duration kDashboardSwipeCoachAnimationDuration =
    Duration(milliseconds: 5500);

class DashboardSwipeCoachOverlay extends StatefulWidget {
  final VoidCallback onCompleted;
  final Duration duration;
  final BorderRadius borderRadius;

  const DashboardSwipeCoachOverlay({
    super.key,
    required this.onCompleted,
    this.duration = kDashboardSwipeCoachAnimationDuration,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
  });

  @override
  State<DashboardSwipeCoachOverlay> createState() =>
      _DashboardSwipeCoachOverlayState();
}

class _DashboardSwipeCoachOverlayState extends State<DashboardSwipeCoachOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _travelAnimation;
  late final Animation<double> _pressAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 20,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 60),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 20,
      ),
    ]).animate(_controller);

    _travelAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 15,
      ),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 10),
    ]).animate(_controller);

    _pressAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.9)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.9, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 20,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 60),
    ]).animate(_controller);

    _glowAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.25), weight: 20),
      TweenSequenceItem(
        tween: Tween(begin: 0.25, end: 0.9)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.9, end: 0.25)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleted();
      }
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant DashboardSwipeCoachOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              color: AppColors.primary.withValues(alpha: 0.86),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double rawWidth = constraints.maxWidth.isFinite
                      ? constraints.maxWidth
                      : MediaQuery.of(context).size.width - (AppSpacing.lg * 2);
                  final double safeTrackWidth = rawWidth.isFinite &&
                          rawWidth > 0
                      ? rawWidth
                      : MediaQuery.of(context).size.width - (AppSpacing.lg * 2);
                  const double knobDiameter = 52.0;

                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final double availableTravel =
                          math.max(0, safeTrackWidth - knobDiameter);
                      final double halfTravel = availableTravel / 2;
                      final double travelOffset =
                          _travelAnimation.value * halfTravel;
                      final double glow = _glowAnimation.value.clamp(0.0, 1.0);
                      final double leftEmphasis = _travelAnimation.value < 0
                          ? _travelAnimation.value.abs().clamp(0.0, 1.0)
                          : 0.0;
                      final double rightEmphasis = _travelAnimation.value > 0
                          ? _travelAnimation.value.abs().clamp(0.0, 1.0)
                          : 0.0;
                      final double chipMaxWidth =
                          math.max(0, (safeTrackWidth - AppSpacing.sm) / 2);

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 72,
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: safeTrackWidth,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: Colors.white.withValues(
                                      alpha:
                                          (0.16 + glow * 0.12).clamp(0.0, 1.0),
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: (0.24 + glow * 0.18)
                                            .clamp(0.0, 1.0),
                                      ),
                                      width: 1.4,
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(travelOffset, 0),
                                  child: Transform.scale(
                                    scale: _pressAnimation.value,
                                    child: Container(
                                      width: knobDiameter,
                                      height: knobDiameter,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(26),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withValues(alpha: 0.35),
                                            blurRadius: 22,
                                            offset: const Offset(0, 12),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        _travelAnimation.value < 0
                                            ? Icons.swipe_left_alt_rounded
                                            : Icons.swipe_right_alt_rounded,
                                        color: AppColors.primary,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              SizedBox(
                                width: chipMaxWidth,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: DashboardSwipeCoachHintChip(
                                    icon: Icons.check_circle_outline,
                                    label: 'Followed plan',
                                    emphasis: leftEmphasis,
                                    maxWidth: chipMaxWidth,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              SizedBox(
                                width: chipMaxWidth,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: DashboardSwipeCoachHintChip(
                                    icon: Icons.remove_circle_outline,
                                    label: 'Skipped meal',
                                    emphasis: rightEmphasis,
                                    maxWidth: chipMaxWidth,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardSwipeCoachHintChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final double emphasis;
  final double maxWidth;
  final TextAlign textAlign;

  const DashboardSwipeCoachHintChip({
    super.key,
    required this.icon,
    required this.label,
    required this.emphasis,
    required this.maxWidth,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final double clampedEmphasis = emphasis.clamp(0.0, 1.0);

    return AnimatedContainer(
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: maxWidth,
      ),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppColors.primary.withValues(
          alpha: 0.08 + (0.18 * clampedEmphasis),
        ),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.18 + (0.22 * clampedEmphasis),
          ),
        ),
        boxShadow: clampedEmphasis > 0.3
            ? [
                BoxShadow(
                  color: AppColors.primary
                      .withValues(alpha: 0.25 * clampedEmphasis),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: textAlign == TextAlign.right
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.white.withValues(
              alpha: 0.7 + (0.3 * clampedEmphasis),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              label,
              textAlign: textAlign,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(
                      alpha: 0.85 + (0.15 * clampedEmphasis),
                    ),
                    fontWeight: clampedEmphasis > 0.5
                        ? FontWeight.w700
                        : FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
