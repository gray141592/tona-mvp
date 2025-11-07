import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/meal.dart';
import 'dashboard_models.dart';
import 'dashboard_utils.dart';

const Duration _swipeCoachAnimationDuration = Duration(milliseconds: 2200);

enum SwipeDirection {
  none,
  left, // Followed recipe
  right, // Skipped meal
}

class _SwipeCoachOverlay extends StatefulWidget {
  final VoidCallback onCompleted;
  final Duration duration;

  const _SwipeCoachOverlay({
    super.key,
    required this.onCompleted,
    this.duration = _swipeCoachAnimationDuration,
  });

  @override
  State<_SwipeCoachOverlay> createState() => _SwipeCoachOverlayState();
}

class _SwipeCoachOverlayState extends State<_SwipeCoachOverlay>
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _SwipeCoachOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: AppColors.primary.withValues(alpha: 0.56),
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
                                  child: _HintChip(
                                    icon: Icons.check_circle_outline,
                                    label: 'Swipe left • Followed',
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
                                  child: _HintChip(
                                    icon: Icons.remove_circle_outline,
                                    label: 'Swipe right • Skip',
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

class _HintChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final double emphasis;
  final double maxWidth;
  final TextAlign textAlign;

  const _HintChip({
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

class DashboardMealFocusCard extends StatefulWidget {
  final MealTimelineEntry entry;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;

  const DashboardMealFocusCard({
    super.key,
    required this.entry,
    required this.isLogging,
    required this.onFollowed,
    required this.onSkipped,
    required this.onAlternative,
    required this.onViewDetails,
  });

  @override
  State<DashboardMealFocusCard> createState() => _DashboardMealFocusCardState();
}

class _DashboardMealFocusCardState extends State<DashboardMealFocusCard>
    with TickerProviderStateMixin {
  double _dragOffset = 0.0;
  SwipeDirection _swipeDirection = SwipeDirection.none;
  bool _isCompleting = false;
  bool _showThankYou = false;
  SwipeDirection _lastCompletedDirection = SwipeDirection.none;
  bool _showSwipeHint = false;
  SharedPreferences? _preferences;
  int _swipeHintAnimationSeed = 0;
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _thankYouController;
  late AnimationController _swipeOutController;
  late AnimationController _loaderController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _thankYouFadeAnimation;
  late Animation<double> _thankYouScaleAnimation;
  late Animation<double> _swipeOutAnimation;
  late Animation<double> _loaderRotationAnimation;
  VoidCallback? _swipeOutListener;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _thankYouController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _swipeOutController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loaderController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );
    _thankYouFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _thankYouController, curve: Curves.easeOut),
    );
    _swipeOutAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _swipeOutController, curve: Curves.easeIn),
    );
    _loaderRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loaderController, curve: Curves.linear),
    );
    _thankYouScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.5,
      ),
    ]).animate(_thankYouController);

    unawaited(_initializeSwipeHint());
  }

  Future<void> _initializeSwipeHint() async {
    final prefs = await SharedPreferences.getInstance();
    _preferences = prefs;
    final hasSeenHint =
        prefs.getBool(AppConstants.hasSeenNextMealSwipeHintKey) ?? false;
    final shouldShowHint = !hasSeenHint &&
        widget.entry.state != MealTimelineState.logged &&
        !_isCompleting;

    if (!mounted) return;

    if (_showSwipeHint != shouldShowHint) {
      setState(() {
        _showSwipeHint = shouldShowHint;
        if (shouldShowHint) {
          _swipeHintAnimationSeed++;
        }
      });
    } else if (shouldShowHint) {
      setState(() {
        _swipeHintAnimationSeed++;
      });
    }
  }

  Future<void> _handleSwipeHintCompleted() async {
    if (!_showSwipeHint) return;

    if (mounted) {
      setState(() {
        _showSwipeHint = false;
      });
    }
  }

  Future<void> _markSwipeHintAsCompleted() async {
    if (mounted) {
      setState(() {
        _showSwipeHint = false;
      });
    }
  }

  @override
  void didUpdateWidget(DashboardMealFocusCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset state when entry changes
    if (oldWidget.entry.meal.id != widget.entry.meal.id) {
      _dragOffset = 0.0;
      _swipeDirection = SwipeDirection.none;
      _isCompleting = false;
      _showThankYou = false;
      _lastCompletedDirection = SwipeDirection.none;
      if (_swipeOutListener != null) {
        _swipeOutController.removeListener(_swipeOutListener!);
        _swipeOutListener = null;
      }
      _swipeOutController.reset();
      _scaleController.reset();
      _thankYouController.reset();
      _rotationController.reset();
      _loaderController.stop();
      _loaderController.reset();
      unawaited(_initializeSwipeHint());
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _thankYouController.dispose();
    _swipeOutController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_isCompleting || widget.isLogging) return;
    if (_showSwipeHint) {
      unawaited(_handleSwipeHintCompleted());
    }
    HapticFeedback.selectionClick();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isCompleting || widget.isLogging) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final newOffset = _dragOffset + details.primaryDelta!;
    final clampedOffset =
        newOffset.clamp(-screenWidth * 0.6, screenWidth * 0.6);

    setState(() {
      _dragOffset = clampedOffset;
      if (_dragOffset < -20) {
        _swipeDirection = SwipeDirection.left;
        _rotationAnimation = Tween<double>(
          begin: _rotationAnimation.value,
          end: -0.1,
        ).animate(
          CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
        );
        _rotationController.forward();
      } else if (_dragOffset > 20) {
        _swipeDirection = SwipeDirection.right;
        _rotationAnimation = Tween<double>(
          begin: _rotationAnimation.value,
          end: 0.1,
        ).animate(
          CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
        );
        _rotationController.forward();
      } else {
        _swipeDirection = SwipeDirection.none;
        _rotationAnimation = Tween<double>(
          begin: _rotationAnimation.value,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
        );
        _rotationController.forward();
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isCompleting || widget.isLogging) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.25;
    final velocity = details.velocity.pixelsPerSecond.dx;

    if ((_dragOffset.abs() >= threshold || velocity.abs() > 500) &&
        _swipeDirection != SwipeDirection.none) {
      _completeSwipe();
    } else {
      _snapBack();
    }
  }

  void _completeSwipe() async {
    if (_isCompleting) return;

    if (_showSwipeHint) {
      unawaited(_handleSwipeHintCompleted());
    }

    // Store the swipe direction before resetting
    final completedDirection = _swipeDirection;
    final startOffset = _dragOffset;

    setState(() {
      _isCompleting = true;
      _lastCompletedDirection = completedDirection;
    });

    HapticFeedback.mediumImpact();

    // Animate card off screen
    final screenWidth = MediaQuery.of(context).size.width;
    final targetOffset = completedDirection == SwipeDirection.left
        ? -screenWidth * 1.5
        : screenWidth * 1.5;

    // Animate card out
    await _scaleController.forward();

    // Animate drag offset to off-screen
    _swipeOutAnimation = Tween<double>(
      begin: startOffset,
      end: targetOffset,
    ).animate(
      CurvedAnimation(parent: _swipeOutController, curve: Curves.easeIn),
    );

    _swipeOutListener = () {
      if (mounted) {
        setState(() {
          _dragOffset = _swipeOutAnimation.value;
        });
      }
    };
    _swipeOutController.addListener(_swipeOutListener!);

    await _swipeOutController.forward();

    if (!mounted) return;

    // Remove listener after animation completes
    if (_swipeOutListener != null) {
      _swipeOutController.removeListener(_swipeOutListener!);
      _swipeOutListener = null;
    }

    await Future.delayed(const Duration(milliseconds: 100));

    // Show thank you message
    setState(() {
      _showThankYou = true;
      _dragOffset = 0;
      _swipeDirection = SwipeDirection.none;
      _lastCompletedDirection = completedDirection;
    });

    await _thankYouController.forward();

    // Wait minimum 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    await _thankYouController.reverse();

    if (!mounted) return;

    setState(() {
      _showThankYou = false;
      _isCompleting = false;
    });

    _scaleController.reset();
    _swipeOutController.reset();

    // Trigger the appropriate callback
    if (completedDirection == SwipeDirection.left) {
      widget.onFollowed(widget.entry.meal);
    } else if (completedDirection == SwipeDirection.right) {
      widget.onSkipped(widget.entry.meal);
    }

    unawaited(_markSwipeHintAsCompleted());
  }

  void _snapBack() {
    if (_swipeOutListener != null) {
      _swipeOutController.removeListener(_swipeOutListener!);
      _swipeOutListener = null;
    }
    _swipeOutController.reset();

    setState(() {
      _dragOffset = 0.0;
      _swipeDirection = SwipeDirection.none;
    });

    _rotationAnimation = Tween<double>(
      begin: _rotationAnimation.value,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
    );
    _rotationController.forward();
    HapticFeedback.lightImpact();
  }

  double _currentSwipeProgress(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 0) return 0;
    final progress = _dragOffset.abs() / (width * 0.25);
    return progress.clamp(0.0, 1.0).toDouble();
  }

  Widget _buildActionIndicator(double swipeProgress) {
    if (_swipeDirection == SwipeDirection.none || _isCompleting) {
      return const SizedBox.shrink();
    }

    final isLeft = _swipeDirection == SwipeDirection.left;
    final highlightColor = isLeft ? AppColors.success : AppColors.error;

    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 140),
            opacity: swipeProgress,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    highlightColor.withValues(alpha: 0.85),
                    highlightColor.withValues(alpha: 0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: highlightColor.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (!isLeft)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isLeft ? Icons.check_rounded : Icons.remove_circle,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLeft ? 'Followed meal' : 'Skipped meal',
                          style: AppTypography.titleLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          isLeft
                              ? 'Logged exactly as planned'
                              : 'Marked as skipped for today',
                          style: AppTypography.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isLeft)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isLeft ? Icons.check_rounded : Icons.remove_circle,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThankYouOverlay() {
    if (!_showThankYou) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _thankYouController,
      builder: (context, child) {
        final isFollowed = _lastCompletedDirection == SwipeDirection.left;
        final icon = isFollowed ? Icons.check_circle : Icons.remove_circle;
        final title = isFollowed ? 'Followed meal' : 'Skipped meal';
        final subtitle = isFollowed
            ? 'Thanks for staying on track!'
            : 'Noted, we\'ll adjust your plan.';
        final gradientColors = isFollowed
            ? [
                AppColors.success.withValues(alpha: 0.96),
                AppColors.secondary.withValues(alpha: 0.9),
              ]
            : [
                AppColors.error.withValues(alpha: 0.95),
                AppColors.warning.withValues(alpha: 0.9),
              ];

        return Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: _thankYouFadeAnimation.value,
              child: Transform.scale(
                scale: _thankYouScaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors.first.withValues(alpha: 0.28),
                        blurRadius: 28,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: Colors.white,
                          size: 56,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          title,
                          style: AppTypography.displaySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium.copyWith(
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoggingPreview() {
    if (!_isCompleting || _showThankYou) return const SizedBox.shrink();

    final meal = widget.entry.meal;
    final isLeft = _lastCompletedDirection == SwipeDirection.left;
    final gradientColors = isLeft
        ? [
            AppColors.success.withValues(alpha: 0.96),
            AppColors.secondary.withValues(alpha: 0.9),
          ]
        : [
            AppColors.error.withValues(alpha: 0.95),
            AppColors.warning.withValues(alpha: 0.9),
          ];
    final title = isLeft ? 'Following recipe' : 'Skipping meal';
    final subtitle = isLeft ? 'Logging your meal...' : 'Marking as skipped...';

    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColors.first.withValues(alpha: 0.28),
                blurRadius: 28,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: AnimatedBuilder(
                    animation: _loaderRotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _loaderRotationAnimation.value * 2 * 3.14159,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const SizedBox(
                              width: 64,
                              height: 64,
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 56,
                              height: 56,
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isLeft
                                    ? Icons.check_rounded
                                    : Icons.remove_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  style: AppTypography.displaySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.92),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  meal.name,
                  textAlign: TextAlign.center,
                  style: AppTypography.titleMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogAlternativeButton(Meal meal) {
    final isDisabled = widget.isLogging || _isCompleting;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 120),
      opacity: isDisabled ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : () => _handleAlternativePressed(meal),
        behavior: HitTestBehavior.opaque,
        child: TextButton.icon(
          onPressed: isDisabled ? null : () => _handleAlternativePressed(meal),
          icon: const Icon(Icons.restaurant_menu_outlined, size: 24),
          label: const Text('Log something else'),
        ),
      ),
    );
  }

  void _handleAlternativePressed(Meal meal) {
    if (_showSwipeHint) {
      unawaited(_handleSwipeHintCompleted());
    }
    widget.onAlternative(meal);
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.entry.meal;
    final isOverdue = widget.entry.state == MealTimelineState.overdue;
    final isDue = widget.entry.state == MealTimelineState.dueNow;

    final statusLabel = switch (widget.entry.state) {
      MealTimelineState.overdue => 'Catch up',
      MealTimelineState.dueNow => 'Log now',
      MealTimelineState.upcomingSoon => 'Coming up',
      MealTimelineState.upcomingFar => 'Next meal',
      MealTimelineState.logged => 'Logged',
    };

    final statusColor = switch (widget.entry.state) {
      MealTimelineState.overdue => AppColors.error,
      MealTimelineState.dueNow => AppColors.warning,
      MealTimelineState.upcomingSoon => AppColors.primary,
      MealTimelineState.upcomingFar => AppColors.primaryDark,
      MealTimelineState.logged => AppColors.success,
    };

    final List<Color> gradientColors = isOverdue
        ? [
            AppColors.error.withValues(alpha: 0.12),
            Colors.white,
          ]
        : isDue
            ? [
                AppColors.warning.withValues(alpha: 0.14),
                Colors.white,
              ]
            : [
                AppColors.primary.withValues(alpha: 0.16),
                Colors.white,
              ];

    final scheduleLine = switch (widget.entry.state) {
      MealTimelineState.overdue ||
      MealTimelineState.dueNow =>
        'Scheduled ${meal.timeScheduled} • ${relativeTimeLabel(widget.entry.timeDifference)}',
      MealTimelineState.upcomingSoon ||
      MealTimelineState.upcomingFar =>
        '${meal.timeScheduled} • ${meal.mealType.displayName} • ${relativeTimeLabel(widget.entry.timeDifference)}',
      MealTimelineState.logged =>
        '${meal.timeScheduled} • ${meal.mealType.displayName}',
    };

    return SizedBox(
      child: Stack(
        children: [
          if (_isCompleting && !_showThankYou) _buildLoggingPreview(),
          if (_showThankYou) _buildThankYouOverlay(),
          AnimatedBuilder(
            animation: Listenable.merge([
              _rotationController,
              _scaleController,
            ]),
            builder: (context, child) {
              final opacity = _isCompleting ? 0.0 : 1.0;
              final scale = _isCompleting ? _scaleAnimation.value : 1.0;
              final swipeProgress = _currentSwipeProgress(context);
              final isSwipingLeft = _swipeDirection == SwipeDirection.left;
              final isSwipingRight = _swipeDirection == SwipeDirection.right;
              final highlightColor = isSwipingLeft
                  ? AppColors.success
                  : isSwipingRight
                      ? AppColors.error
                      : Colors.transparent;
              final effectiveGradient = gradientColors
                  .map(
                    (color) => (isSwipingLeft || isSwipingRight)
                        ? (Color.lerp(
                              color,
                              highlightColor.withValues(alpha: 0.85),
                              swipeProgress,
                            ) ??
                            color)
                        : color,
                  )
                  .toList();
              final double contentOpacity =
                  (1 - swipeProgress * 0.85).clamp(0.2, 1.0).toDouble();
              final double hintOpacity =
                  (1 - swipeProgress * 0.9).clamp(0.0, 1.0).toDouble();

              return IgnorePointer(
                ignoring: _isCompleting,
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Transform.translate(
                      offset: Offset(_dragOffset, 0),
                      child: Transform.rotate(
                        angle: _rotationAnimation.value,
                        child: GestureDetector(
                          onTap: (_isCompleting || widget.isLogging)
                              ? null
                              : () => widget.onViewDetails(meal),
                          onHorizontalDragStart:
                              (_isCompleting || widget.isLogging)
                                  ? null
                                  : _handleDragStart,
                          onHorizontalDragUpdate:
                              (_isCompleting || widget.isLogging)
                                  ? null
                                  : _handleDragUpdate,
                          onHorizontalDragEnd:
                              (_isCompleting || widget.isLogging)
                                  ? null
                                  : _handleDragEnd,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: effectiveGradient,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (isSwipingLeft || isSwipingRight)
                                      ? highlightColor.withValues(alpha: 0.28)
                                      : statusColor.withValues(alpha: 0.18),
                                  blurRadius: 26,
                                  offset: const Offset(0, 18),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(AppSpacing.lg),
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 160),
                                    opacity: contentOpacity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(
                                                AppSpacing.md,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(
                                                            alpha: 0.08),
                                                    blurRadius: 18,
                                                    offset: const Offset(0, 12),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                meal.mealType.emoji,
                                                style: const TextStyle(
                                                    fontSize: 22),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: AppSpacing.md),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: AppSpacing.sm,
                                                      vertical: AppSpacing.xs,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: statusColor
                                                          .withValues(
                                                              alpha: 0.12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              999),
                                                    ),
                                                    child: Text(
                                                      statusLabel,
                                                      style: AppTypography
                                                          .labelMedium
                                                          .copyWith(
                                                        color: statusColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: AppSpacing.xs,
                                                  ),
                                                  Text(
                                                    meal.name,
                                                    style: AppTypography
                                                        .displaySmall
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: AppSpacing.xs,
                                                  ),
                                                  Text(
                                                    scheduleLine,
                                                    style: AppTypography
                                                        .bodySmall
                                                        .copyWith(
                                                      color: AppColors
                                                          .textSecondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  widget.onViewDetails(meal),
                                              icon: const Icon(
                                                Icons.menu_book_outlined,
                                              ),
                                              color: AppColors.primary,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: AppSpacing.md),
                                        Text(
                                          meal.description,
                                          style:
                                              AppTypography.bodyMedium.copyWith(
                                            color: AppColors.textSecondary,
                                            height: 1.5,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: AppSpacing.xxl),
                                        const SizedBox(height: AppSpacing.xl),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: AppSpacing.lg,
                                  right: AppSpacing.lg,
                                  bottom: AppSpacing.lg,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 160),
                                    opacity: hintOpacity,
                                    child: _buildLogAlternativeButton(meal),
                                  ),
                                ),
                                if (_showSwipeHint &&
                                    !_isCompleting &&
                                    !_showThankYou)
                                  _SwipeCoachOverlay(
                                    key: ValueKey(_swipeHintAnimationSeed),
                                    duration: _swipeCoachAnimationDuration,
                                    onCompleted: () {
                                      unawaited(_handleSwipeHintCompleted());
                                    },
                                  ),
                                _buildActionIndicator(swipeProgress),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
