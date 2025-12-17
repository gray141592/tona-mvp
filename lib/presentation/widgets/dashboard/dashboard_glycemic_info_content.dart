import 'package:flutter/material.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DashboardGlycemicInfoContent extends StatelessWidget {
  const DashboardGlycemicInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final sections = _getSections(localizations);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections
            .map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: _GlycemicSection(section: section),
              ),
            )
            .toList(),
      ),
    );
  }

  List<_GlycemicInfoSection> _getSections(AppLocalizations localizations) {
    return [
      _GlycemicInfoSection(
        title: localizations.glycemicInfo_lowTitle,
        description: localizations.glycemicInfo_lowDesc,
        examples: [
          localizations.glycemicInfo_lowExample1,
          localizations.glycemicInfo_lowExample2,
          localizations.glycemicInfo_lowExample3,
        ],
        backgroundColor: AppColors.success,
        icon: Icons.eco_outlined,
      ),
      _GlycemicInfoSection(
        title: localizations.glycemicInfo_mediumTitle,
        description: localizations.glycemicInfo_mediumDesc,
        examples: [
          localizations.glycemicInfo_mediumExample1,
          localizations.glycemicInfo_mediumExample2,
          localizations.glycemicInfo_mediumExample3,
        ],
        backgroundColor: AppColors.warning,
        icon: Icons.waves_outlined,
      ),
      _GlycemicInfoSection(
        title: localizations.glycemicInfo_highTitle,
        description: localizations.glycemicInfo_highDesc,
        examples: [
          localizations.glycemicInfo_highExample1,
          localizations.glycemicInfo_highExample2,
          localizations.glycemicInfo_highExample3,
        ],
        backgroundColor: AppColors.error,
        icon: Icons.local_fire_department_outlined,
      ),
    ];
  }
}

class _GlycemicSection extends StatelessWidget {
  final _GlycemicInfoSection section;

  const _GlycemicSection({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: section.backgroundColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(section.icon, color: section.backgroundColor),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                section.title,
                style: AppTypography.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: section.backgroundColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            section.description,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...section.examples.map(
            (example) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(
                    child: Text(
                      example,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlycemicInfoSection {
  final String title;
  final String description;
  final List<String> examples;
  final Color backgroundColor;
  final IconData icon;

  const _GlycemicInfoSection({
    required this.title,
    required this.description,
    required this.examples,
    required this.backgroundColor,
    required this.icon,
  });
}
