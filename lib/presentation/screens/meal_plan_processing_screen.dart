import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../widgets/waiting_screen_shell.dart';

class MealPlanProcessingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback onCancel;

  const MealPlanProcessingScreen({
    super.key,
    required this.onComplete,
    required this.onCancel,
  });

  @override
  State<MealPlanProcessingScreen> createState() => _MealPlanProcessingScreenState();
}

class _MealPlanProcessingScreenState extends State<MealPlanProcessingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_ProcessingStage> _stages;
  bool _isCancelled = false;

  static const Duration _totalDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _stages = const [
      _ProcessingStage(
        title: 'Uploading your plan',
        subtitle: 'Securely sending to Tona servers',
        icon: Icons.cloud_upload_rounded,
      ),
      _ProcessingStage(
        title: 'Analyzing details',
        subtitle: 'Understanding nutrition goals',
        icon: Icons.analytics_outlined,
      ),
      _ProcessingStage(
        title: 'Extracting meals',
        subtitle: 'Capturing meals and supplements',
        icon: Icons.fact_check_outlined,
      ),
      _ProcessingStage(
        title: 'Final touches',
        subtitle: 'Applying the Tona structure',
        icon: Icons.auto_awesome_motion_outlined,
      ),
    ];

    _controller = AnimationController(vsync: this, duration: _totalDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_isCancelled) {
          widget.onComplete();
        }
      })
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get _currentStageIndex {
    final raw = (_controller.value * _stages.length).floor();
    return raw.clamp(0, _stages.length - 1);
  }

  double get _stageProgressFraction {
    final perStage = 1 / _stages.length;
    final stageStart = _currentStageIndex * perStage;
    final progress = (_controller.value - stageStart) / perStage;
    return progress.clamp(0.0, 1.0);
  }

  void _handleCancel() {
    if (_isCancelled) return;
    setState(() {
      _isCancelled = true;
    });
    _controller.stop();
    widget.onCancel();
  }

  @override
  Widget build(BuildContext context) {
    final stage = _stages[_currentStageIndex];
    final uploadProgress = (_stageProgressFraction * 100).clamp(0, 100).round();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        _handleCancel();
      },
      child: WaitingScreenShell(
        title: 'Preparing your plan',
        subtitle: _StageStepper(
              stages: _stages,
              activeIndex: _currentStageIndex,
            ),
        onClose: _handleCancel,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lg,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: _StageIconCard(
                  key: ValueKey(stage.icon),
                  icon: stage.icon,
                  accent: AppColors.primary,
                  isPulsing: _currentStageIndex == 0,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: Column(
                  key: ValueKey(stage.title),
                  children: [
                    Text(
                      stage.title,
                      style: AppTypography.displaySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _currentStageIndex == 0
                          ? 'Progress ${uploadProgress.toString().padLeft(2, '0')}%'
                          : stage.subtitle,
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: _controller.value,
                minHeight: 8,
                backgroundColor: AppColors.surfaceVariant.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton.icon(
              onPressed: _handleCancel,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Cancel and choose another file'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StageIconCard extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final bool isPulsing;

  const _StageIconCard({
    super.key,
    required this.icon,
    required this.accent,
    required this.isPulsing,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: isPulsing ? scale : 1.0,
          child: child,
        );
      },
      child: Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.22),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.18),
              blurRadius: 36,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: 56,
            color: accent,
          ),
        ),
      ),
    );
  }
}

class _StageStepper extends StatelessWidget {
  final List<_ProcessingStage> stages;
  final int activeIndex;

  const _StageStepper({
    required this.stages,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var index = 0; index < stages.length; index++) {
      final isActive = index == activeIndex;
      final isComplete = index < activeIndex;
      final statusColor = isActive
          ? AppColors.primary
          : isComplete
              ? AppColors.success
              : AppColors.textDisabled;

      children.add(
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : isComplete
                        ? AppColors.success.withValues(alpha: 0.15)
                        : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              ),
              child: Icon(
                stages[index].icon,
                color: statusColor,
              ),
            ),
          ],
        ),
      );

      if (index != stages.length - 1) {
        children.add(
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              height: 2,
              decoration: BoxDecoration(
                color: index < activeIndex
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ],
    );
  }
}

class _ProcessingStage {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ProcessingStage({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

