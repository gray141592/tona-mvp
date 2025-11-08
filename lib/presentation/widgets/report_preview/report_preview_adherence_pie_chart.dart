import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ReportPreviewAdherencePieChart extends StatelessWidget {
  final int followed;
  final int alternatives;
  final int skipped;

  const ReportPreviewAdherencePieChart({
    super.key,
    required this.followed,
    required this.alternatives,
    required this.skipped,
  });

  @override
  Widget build(BuildContext context) {
    final total = followed + alternatives + skipped;

    if (total == 0) {
      return const SizedBox.shrink();
    }

    final segments = [
      _PieSegment(
        value: followed.toDouble(),
        color: AppColors.success,
        label: 'Followed',
        count: followed,
      ),
      _PieSegment(
        value: alternatives.toDouble(),
        color: AppColors.warning,
        label: 'Alternatives',
        count: alternatives,
      ),
      _PieSegment(
        value: skipped.toDouble(),
        color: AppColors.error,
        label: 'Skipped',
        count: skipped,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 130,
            width: 130,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size.square(160),
                  painter: _AdherencePiePainter(
                    segments: segments,
                    total: total.toDouble(),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$total',
                      style: AppTypography.displaySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Total logs',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: segments
                  .map(
                    (segment) => Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                      child: _LegendRow(segment: segment),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdherencePiePainter extends CustomPainter {
  final List<_PieSegment> segments;
  final double total;

  _AdherencePiePainter({
    required this.segments,
    required this.total,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    var startAngle = -math.pi / 2;

    for (final segment in segments) {
      if (segment.value <= 0) continue;
      final sweepAngle = (segment.value / total) * 2 * math.pi;
      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.fill;
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }

    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final radius = math.min(size.width, size.height) / 2.6;
    canvas.drawCircle(size.center(Offset.zero), radius, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _AdherencePiePainter oldDelegate) {
    return oldDelegate.segments != segments || oldDelegate.total != total;
  }
}

class _LegendRow extends StatelessWidget {
  final _PieSegment segment;

  const _LegendRow({required this.segment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: segment.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            segment.label,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _PieSegment {
  final double value;
  final Color color;
  final String label;
  final int count;

  const _PieSegment({
    required this.value,
    required this.color,
    required this.label,
    required this.count,
  });
}

