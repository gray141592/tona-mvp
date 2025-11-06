import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/meal.dart';
import '../../data/models/meal_type.dart';
import '../../data/models/meal_log.dart';
import '../../data/models/meal_log_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import 'swipe_to_complete.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final MealLog? mealLog;
  final VoidCallback? onFollowed;
  final VoidCallback? onAlternative;
  final bool isLogged;

  const MealCard({
    super.key,
    required this.meal,
    this.mealLog,
    this.onFollowed,
    this.onAlternative,
    required this.isLogged,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _mealTypeColor {
    switch (widget.meal.mealType) {
      case MealType.breakfast:
        return AppColors.mealBreakfast;
      case MealType.lunch:
        return AppColors.mealLunch;
      case MealType.dinner:
        return AppColors.mealDinner;
      case MealType.snack1:
      case MealType.snack2:
        return AppColors.mealSnack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _mealTypeColor.withValues(alpha: 0.7),
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _mealTypeColor.withValues(alpha: 0.25),
              blurRadius: 26,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (widget.onFollowed != null || widget.onAlternative != null) {
                  _controller.forward().then((_) => _controller.reverse());
                }
              },
              onTapDown: (_) {
                if (widget.onFollowed != null || widget.onAlternative != null) {
                  _controller.forward();
                }
              },
              onTapUp: (_) {
                _controller.reverse();
              },
              onTapCancel: () {
                _controller.reverse();
              },
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            widget.meal.mealType.emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.meal.mealType.displayName,
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  widget.meal.timeScheduled,
                                  style: AppTypography.bodySmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.isLogged)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.verified_rounded,
                                  color: AppColors.success,
                                  size: 18,
                                ),
                                SizedBox(width: AppSpacing.xs),
                                Text(
                                  'Logged',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      widget.meal.name,
                      style: AppTypography.displaySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      widget.meal.description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    if (widget.isLogged && widget.mealLog != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: widget.mealLog!.status == MealLogStatus.followed
                                    ? AppColors.success
                                    : AppColors.warning,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.mealLog!.status == MealLogStatus.followed
                                    ? Icons.check_rounded
                                    : Icons.restaurant,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.mealLog!.status.displayName,
                                    style: AppTypography.titleMedium.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if (widget.mealLog!.alternativeMeal != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                                      child: Text(
                                        widget.mealLog!.alternativeMeal!,
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  if (widget.mealLog!.notes != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                                      child: Text(
                                        widget.mealLog!.notes!,
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Text(
                              date_utils.DateUtils.formatTime(widget.mealLog!.loggedTime),
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: AppSpacing.lg),
                      if (widget.onFollowed != null)
                        SwipeToComplete(
                          onComplete: widget.onFollowed!,
                          label: 'I followed the plan',
                          icon: Icons.arrow_forward_rounded,
                          isCompleted: widget.isLogged,
                        ),
                      if (widget.onAlternative != null) ...[
                        const SizedBox(height: AppSpacing.sm),
                        _AlternativeButton(
                          onLongPress: widget.onAlternative!,
                        ),
                      ],
                    ],
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

class _GamifiedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Gradient gradient;
  final IconData icon;
  final String label;
  final bool isPrimary;

  const _GamifiedButton({
    required this.onPressed,
    required this.gradient,
    required this.icon,
    required this.label,
    required this.isPrimary,
  });

  @override
  State<_GamifiedButton> createState() => _GamifiedButtonState();
}

class _GamifiedButtonState extends State<_GamifiedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.08),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.08, end: 1.0),
        weight: 0.5,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.mediumImpact();
    _controller.forward().then((_) {
      _controller.reverse();
      Future.delayed(const Duration(milliseconds: 50), () {
        widget.onPressed();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value * _bounceAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: widget.isPrimary
                  ? [
                      BoxShadow(
                        color: AppColors.success.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _handleTap,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.md,
                    horizontal: AppSpacing.md,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        widget.label,
                        style: AppTypography.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AlternativeButton extends StatefulWidget {
  final VoidCallback onLongPress;

  const _AlternativeButton({
    required this.onLongPress,
  });

  @override
  State<_AlternativeButton> createState() => _AlternativeButtonState();
}

class _AlternativeButtonState extends State<_AlternativeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        HapticFeedback.mediumImpact();
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onLongPressEnd: (_) {
        HapticFeedback.lightImpact();
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onLongPress();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: Colors.white.withValues(alpha: _isPressed ? 1.0 : 0.7),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Long press to log alternative',
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.white.withValues(alpha: _isPressed ? 1.0 : 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

