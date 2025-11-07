import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SwipeToComplete extends StatefulWidget {
  final VoidCallback onComplete;
  final String label;
  final IconData icon;
  final bool isCompleted;

  const SwipeToComplete({
    super.key,
    required this.onComplete,
    required this.label,
    required this.icon,
    this.isCompleted = false,
  });

  @override
  State<SwipeToComplete> createState() => _SwipeToCompleteState();
}

class _SwipeToCompleteState extends State<SwipeToComplete>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _completionController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  double _dragPosition = 0.0;
  double _maxDragDistance = 0.0;
  bool _isDragging = false;
  bool _isCompleted = false;
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _completionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _completionController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _completionController,
        curve: Curves.easeOut,
      ),
    );

    if (_isCompleted) {
      _completionController.value = 1.0;
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(SwipeToComplete oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted != oldWidget.isCompleted) {
      _isCompleted = widget.isCompleted;
      if (_isCompleted && !_completionController.isAnimating) {
        _controller.forward().then((_) {
          _completionController.forward();
        });
      } else if (!_isCompleted) {
        _completionController.reverse().then((_) {
          _controller.reset();
          _dragPosition = 0.0;
        });
      }
    }
  }

  void _calculateMaxDragDistance() {
    if (_containerKey.currentContext != null && mounted) {
      final RenderBox? box =
          _containerKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize && box.size.width > 0) {
        final width = box.size.width;
        final calculated =
            width - 56; // Just subtract button width to reach the end
        if (calculated != _maxDragDistance && calculated > 0) {
          setState(() {
            _maxDragDistance = calculated;
          });
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMaxDragDistance();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _completionController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_isCompleted) return;
    setState(() {
      _isDragging = true;
    });
    HapticFeedback.selectionClick();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isCompleted || _maxDragDistance <= 0) return;

    final newPosition = (_dragPosition + details.primaryDelta!).clamp(
      0.0,
      _maxDragDistance,
    );

    final progress = (newPosition / _maxDragDistance).clamp(0.0, 1.0);
    final previousProgress = _controller.value;

    setState(() {
      _dragPosition = newPosition;
      _controller.value = progress;
    });

    if (progress > 0.95 && previousProgress <= 0.95) {
      HapticFeedback.mediumImpact();
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isCompleted) return;

    final velocity = details.velocity.pixelsPerSecond.dx;
    final threshold = _maxDragDistance * 0.75;

    if (_dragPosition >= threshold || velocity > 400) {
      _completeSwipe();
    } else {
      _snapBack();
    }

    setState(() {
      _isDragging = false;
    });
  }

  void _completeSwipe() {
    setState(() {
      _isCompleted = true;
    });

    HapticFeedback.mediumImpact();

    _controller
        .animateTo(1.0, duration: const Duration(milliseconds: 200))
        .then((_) {
      _completionController.forward().then((_) {
        widget.onComplete();
      });
    });

    setState(() {
      _dragPosition = _maxDragDistance;
    });
  }

  void _snapBack() {
    _controller.animateTo(0.0, duration: const Duration(milliseconds: 300));
    setState(() {
      _dragPosition = 0.0;
    });
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 0) {
          final calculated = constraints.maxWidth - 56;
          if (calculated > 0 && _maxDragDistance != calculated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _maxDragDistance = calculated;
                });
              }
            });
          }
        }

        return AnimatedBuilder(
          animation: Listenable.merge([_controller, _completionController]),
          builder: (context, child) {
            final progress = _controller.value;
            final isCompleted =
                _isCompleted && _completionController.value > 0.5;

            return Transform.scale(
              scale: _isCompleted ? _scaleAnimation.value : 1.0,
              child: Opacity(
                opacity: _isCompleted ? _fadeAnimation.value : 1.0,
                child: GestureDetector(
                  onHorizontalDragStart: _isCompleted ? null : _handleDragStart,
                  onHorizontalDragUpdate:
                      _isCompleted ? null : _handleDragUpdate,
                  onHorizontalDragEnd: _isCompleted ? null : _handleDragEnd,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    key: _containerKey,
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(56),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(56),
                              color: AppColors.surfaceVariant
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        if (!isCompleted)
                          Positioned.fill(
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(56),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      AppColors.primary,
                                      AppColors.secondary,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (isCompleted)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.success,
                                    AppColors.secondary,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Text(
                                      'Completed!',
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
                        Positioned.fill(
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: AppTypography.labelLarge.copyWith(
                                color: isCompleted
                                    ? Colors.white
                                    : progress > 0.35
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                              child: Text(
                                isCompleted ? 'Completed!' : widget.label,
                              ),
                            ),
                          ),
                        ),
                        if (!isCompleted)
                          AnimatedPositioned(
                            duration: _isDragging
                                ? Duration.zero
                                : const Duration(milliseconds: 220),
                            curve: Curves.easeOutCubic,
                            left: _dragPosition.clamp(
                              0.0,
                              _maxDragDistance > 0 ? _maxDragDistance : 0,
                            ),
                            top: 4,
                            bottom: 4,
                            child: Container(
                              width: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryDark,
                                    AppColors.primary,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: progress < 0.75
                                        ? 1.0
                                        : (1.0 - ((progress - 0.75) / 0.25))
                                            .clamp(0.0, 1.0),
                                    child: Icon(
                                      widget.icon,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                  Opacity(
                                    opacity: progress < 0.75
                                        ? 0.0
                                        : ((progress - 0.75) / 0.25)
                                            .clamp(0.0, 1.0),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
