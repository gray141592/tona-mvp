import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/meal.dart';
import 'dashboard_models.dart';
import 'dashboard_swipe_coach_overlay.dart';
import 'dashboard_utils.dart';

enum _SwipeDirection { none, left, right }

enum _CompletionPhase { idle, loading, success }

class DashboardPendingMealRow extends StatefulWidget {
  final MealTimelineEntry entry;
  final bool isLogging;
  final ValueChanged<Meal> onFollowed;
  final ValueChanged<Meal> onSkipped;
  final ValueChanged<Meal> onAlternative;
  final ValueChanged<Meal> onViewDetails;
  final bool showSwipeCoach;

  const DashboardPendingMealRow({
    super.key,
    required this.entry,
    required this.isLogging,
    required this.onFollowed,
    required this.onSkipped,
    required this.onAlternative,
    required this.onViewDetails,
    this.showSwipeCoach = false,
  });

  @override
  State<DashboardPendingMealRow> createState() =>
      _DashboardPendingMealRowState();
}

class _DashboardPendingMealRowState extends State<DashboardPendingMealRow> {
  static const double _maxSwipeFraction = 0.55;
  static const double _swipeThresholdFraction = 0.28;

  double _dragOffset = 0.0;
  _SwipeDirection _swipeDirection = _SwipeDirection.none;
  _CompletionPhase _completionPhase = _CompletionPhase.idle;
  bool _showSwipeCoach = false;
  int _swipeCoachAnimationSeed = 0;

  bool get _isInteractionLocked =>
      widget.isLogging || _completionPhase != _CompletionPhase.idle;

  @override
  void initState() {
    super.initState();
    if (widget.showSwipeCoach) {
      unawaited(_initializeSwipeCoach());
    }
  }

  @override
  void didUpdateWidget(DashboardPendingMealRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.entry.meal.id != widget.entry.meal.id) {
      _dragOffset = 0.0;
      _swipeDirection = _SwipeDirection.none;
      _completionPhase = _CompletionPhase.idle;
      _showSwipeCoach = false;
      if (widget.showSwipeCoach) {
        unawaited(_initializeSwipeCoach());
      }
    } else if (!oldWidget.showSwipeCoach && widget.showSwipeCoach) {
      unawaited(_initializeSwipeCoach());
    }
  }

  Future<void> _initializeSwipeCoach() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenHint =
        prefs.getBool(AppConstants.hasSeenNextMealSwipeHintKey) ?? false;
    final shouldShow = widget.showSwipeCoach &&
        !hasSeenHint &&
        _completionPhase == _CompletionPhase.idle;

    if (!mounted) return;

    setState(() {
      _showSwipeCoach = shouldShow;
      if (shouldShow) {
        _swipeCoachAnimationSeed++;
      }
    });
  }

  void _dismissSwipeCoach() {
    if (!_showSwipeCoach) return;
    setState(() {
      _showSwipeCoach = false;
    });
  }

  void _handleSwipeCoachCompleted() {
    if (!mounted) return;
    setState(() {
      _showSwipeCoach = false;
    });
  }

  void _handleDragStart(DragStartDetails details) {
    if (_isInteractionLocked) return;
    _dismissSwipeCoach();
    HapticFeedback.selectionClick();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isInteractionLocked) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final newOffset = _dragOffset + details.primaryDelta!;
    final clampedOffset = newOffset.clamp(
        -screenWidth * _maxSwipeFraction, screenWidth * _maxSwipeFraction);

    setState(() {
      _dragOffset = clampedOffset;

      if (_dragOffset < -20) {
        _swipeDirection = _SwipeDirection.left;
      } else if (_dragOffset > 20) {
        _swipeDirection = _SwipeDirection.right;
      } else {
        _swipeDirection = _SwipeDirection.none;
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isInteractionLocked) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * _swipeThresholdFraction;
    final velocity = details.velocity.pixelsPerSecond.dx;

    if ((_dragOffset.abs() >= threshold || velocity.abs() > 480) &&
        _swipeDirection != _SwipeDirection.none) {
      unawaited(_completeSwipe(_swipeDirection));
    } else {
      _resetDrag();
    }
  }

  Future<void> _completeSwipe(_SwipeDirection direction) async {
    if (_completionPhase != _CompletionPhase.idle) return;

    _dismissSwipeCoach();

    setState(() {
      _completionPhase = _CompletionPhase.loading;
      _swipeDirection = direction;
      _dragOffset = 0.0;
    });

    HapticFeedback.mediumImpact();

    await Future.delayed(const Duration(milliseconds: 520));
    if (!mounted) return;

    setState(() {
      _completionPhase = _CompletionPhase.success;
    });

    HapticFeedback.lightImpact();

    await Future.delayed(const Duration(milliseconds: 720));
    if (!mounted) return;

    final meal = widget.entry.meal;

    if (direction == _SwipeDirection.left) {
      widget.onFollowed(meal);
    } else {
      widget.onSkipped(meal);
    }
  }

  void _resetDrag() {
    setState(() {
      _dragOffset = 0.0;
      _swipeDirection = _SwipeDirection.none;
    });
    HapticFeedback.lightImpact();
  }

  double _swipeProgress(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= 0) return 0.0;
    final threshold = width * _swipeThresholdFraction;
    if (threshold <= 0) return 0.0;
    return (_dragOffset.abs() / threshold).clamp(0.0, 1.0).toDouble();
  }

  void _handleAlternativePressed() {
    if (_isInteractionLocked) return;
    _dismissSwipeCoach();
    widget.onAlternative(widget.entry.meal);
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.entry.meal;
    final isOverdue = widget.entry.state == MealTimelineState.overdue;
    final isDueNow = widget.entry.state == MealTimelineState.dueNow;
    final baseColor = isOverdue ? AppColors.primary : AppColors.accent;
    final statusColor = isDueNow ? AppColors.primaryDark : baseColor;
    final highlightColor = switch (_swipeDirection) {
      _SwipeDirection.left => AppColors.success,
      _SwipeDirection.right => AppColors.primaryDark,
      _ => statusColor,
    };
    final gradientColors = [
      baseColor.withValues(alpha: isOverdue ? 0.18 : 0.14),
      Colors.white,
    ];

    final swipeProgress = _swipeProgress(context);
    final effectiveGradient = gradientColors
        .map(
          (color) =>
              Color.lerp(
                color,
                highlightColor.withValues(alpha: 0.75),
                swipeProgress,
              ) ??
              color,
        )
        .toList(growable: false);

    final statusLabel = isOverdue
        ? 'Catch up'
        : isDueNow
            ? 'Log now'
            : 'Needs attention';

    final scheduleLine =
        'Scheduled ${meal.timeScheduled} • ${relativeTimeLabel(widget.entry.timeDifference)}';

    final bool dimForGlobalLogging =
        widget.isLogging && _completionPhase == _CompletionPhase.idle;

    return GestureDetector(
      onTap: _isInteractionLocked ? null : () => widget.onViewDetails(meal),
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: dimForGlobalLogging ? 0.6 : 1.0,
        child: Transform.translate(
          offset: Offset(_dragOffset, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: effectiveGradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: highlightColor.withValues(alpha: 0.18),
                  blurRadius: 22,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Text(
                              meal.mealType.emoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm,
                                    vertical: AppSpacing.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    statusLabel,
                                    style: AppTypography.labelMedium.copyWith(
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  meal.name,
                                  style: AppTypography.titleLarge.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  scheduleLine,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: _isInteractionLocked
                                ? null
                                : () => widget.onViewDetails(meal),
                            icon: const Icon(Icons.visibility_outlined),
                            color: statusColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Center(
                        child: TextButton.icon(
                          onPressed: _isInteractionLocked
                              ? null
                              : _handleAlternativePressed,
                          icon: const Icon(Icons.edit_note_outlined, size: 20),
                          label: const Text('Log something else'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showSwipeCoach &&
                    widget.showSwipeCoach &&
                    _completionPhase == _CompletionPhase.idle)
                  DashboardSwipeCoachOverlay(
                    key: ValueKey(
                        'coach-${widget.entry.meal.id}-$_swipeCoachAnimationSeed'),
                    borderRadius: BorderRadius.circular(24),
                    onCompleted: _handleSwipeCoachCompleted,
                  ),
                if (_completionPhase != _CompletionPhase.idle)
                  Positioned.fill(child: _buildCompletionOverlay()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionOverlay() {
    final isLoading = _completionPhase == _CompletionPhase.loading;
    final direction = _swipeDirection;
    final Color accentColor = direction == _SwipeDirection.left
        ? AppColors.success
        : AppColors.primaryDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                  ),
                )
              : Column(
                  key: const ValueKey('success'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      direction == _SwipeDirection.left
                          ? Icons.check_circle_outline
                          : Icons.remove_circle_outline,
                      color: accentColor,
                      size: 40,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      direction == _SwipeDirection.left
                          ? 'Great job!'
                          : 'Noted',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Log was successfully saved',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
