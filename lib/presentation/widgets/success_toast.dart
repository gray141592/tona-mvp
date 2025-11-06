import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

enum ToastType { success, info, warning }

class SuccessToast extends StatelessWidget {
  final String message;
  final String? emoji;
  final ToastType type;
  final VoidCallback? onDismiss;

  const SuccessToast({
    super.key,
    required this.message,
    this.emoji,
    this.type = ToastType.success,
    this.onDismiss,
  });

  static void show(
    BuildContext context,
    String message, {
    String? emoji,
    ToastType type = ToastType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    HapticFeedback.mediumImpact();
    
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastOverlay(
        message: message,
        emoji: emoji,
        type: type,
        duration: duration,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration + const Duration(milliseconds: 300), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _ToastOverlay extends StatefulWidget {
  final String message;
  final String? emoji;
  final ToastType type;
  final Duration duration;

  const _ToastOverlay({
    required this.message,
    this.emoji,
    required this.type,
    required this.duration,
  });

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LinearGradient _getGradient() {
    switch (widget.type) {
      case ToastType.success:
        return const LinearGradient(
          colors: [AppColors.success, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ToastType.warning:
        return const LinearGradient(
          colors: [AppColors.warning, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ToastType.info:
        return const LinearGradient(
          colors: [AppColors.info, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  String _getDefaultEmoji() {
    switch (widget.type) {
      case ToastType.success:
        return '🎉';
      case ToastType.warning:
        return '⚠️';
      case ToastType.info:
        return 'ℹ️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + AppSpacing.md,
      left: AppSpacing.md,
      right: AppSpacing.md,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: _getGradient(),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        widget.emoji ?? _getDefaultEmoji(),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: AppTypography.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
  }
}

