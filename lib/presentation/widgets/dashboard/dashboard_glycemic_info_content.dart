import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DashboardGlycemicInfoContent extends StatelessWidget {
  const DashboardGlycemicInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _sections
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

const List<_GlycemicInfoSection> _sections = [
  _GlycemicInfoSection(
    title: 'Low GI (0-55)',
    description: 'Steady energy, best for maintaining balanced blood sugar.',
    examples: [
      'Leafy greens, non-starchy vegetables',
      'Beans, lentils, chickpeas',
      'Whole grains like barley or quinoa',
    ],
    backgroundColor: AppColors.success,
    icon: Icons.eco_outlined,
  ),
  _GlycemicInfoSection(
    title: 'Medium GI (56-69)',
    description: 'Moderate impact, balance with protein or healthy fats.',
    examples: [
      'Whole grain bread, oats',
      'Sweet corn, sweet potatoes',
      'Tropical fruits like pineapple or mango',
    ],
    backgroundColor: AppColors.warning,
    icon: Icons.waves_outlined,
  ),
  _GlycemicInfoSection(
    title: 'High GI (70+)',
    description: 'Spikes blood sugar quickly; limit when possible.',
    examples: [
      'White bread, bagels, pretzels',
      'Sugary cereals, candy, pastries',
      'White rice, fries, processed snacks',
    ],
    backgroundColor: AppColors.error,
    icon: Icons.local_fire_department_outlined,
  ),
];
