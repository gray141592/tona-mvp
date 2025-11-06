import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../data/mock_data/mock_data.dart';
import 'report_preview_screen.dart';

enum DateRange {
  lastWeek,
  lastMonth,
  custom,
}

class ReportGenerationScreen extends StatefulWidget {
  const ReportGenerationScreen({super.key});

  @override
  State<ReportGenerationScreen> createState() => _ReportGenerationScreenState();
}

class _ReportGenerationScreenState extends State<ReportGenerationScreen> {
  DateRange _selectedRange = DateRange.lastWeek;
  DateTime? _customStartDate;
  DateTime? _customEndDate;

  DateTime get _startDate {
    final now = DateTime.now();
    switch (_selectedRange) {
      case DateRange.lastWeek:
        return now.subtract(const Duration(days: 7));
      case DateRange.lastMonth:
        return now.subtract(const Duration(days: 30));
      case DateRange.custom:
        return _customStartDate ?? now.subtract(const Duration(days: 7));
    }
  }

  DateTime get _endDate {
    final now = DateTime.now();
    switch (_selectedRange) {
      case DateRange.lastWeek:
      case DateRange.lastMonth:
        return now;
      case DateRange.custom:
        return _customEndDate ?? now;
    }
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _customStartDate ?? DateTime.now().subtract(const Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _customStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _customEndDate ?? DateTime.now(),
      firstDate: _customStartDate ?? DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _customEndDate = picked;
      });
    }
  }

  void _generateReport() {
    final client = MockData.getMockClient();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPreviewScreen(
          client: client,
          startDate: _startDate,
          endDate: _endDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Generate report'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              'Choose a period',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'We’ll summarise all activity within the selected range.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _RangeChip(
                  label: 'Last 7 days',
                  icon: Icons.calendar_view_day,
                  selected: _selectedRange == DateRange.lastWeek,
                  onSelected: () {
                    setState(() {
                      _selectedRange = DateRange.lastWeek;
                    });
                  },
                ),
                _RangeChip(
                  label: 'Last 30 days',
                  icon: Icons.calendar_month,
                  selected: _selectedRange == DateRange.lastMonth,
                  onSelected: () {
                    setState(() {
                      _selectedRange = DateRange.lastMonth;
                    });
                  },
                ),
                _RangeChip(
                  label: 'Custom range',
                  icon: Icons.edit_calendar_rounded,
                  selected: _selectedRange == DateRange.custom,
                  onSelected: () {
                    setState(() {
                      _selectedRange = DateRange.custom;
                    });
                  },
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _selectedRange == DateRange.custom
                  ? Padding(
                      key: const ValueKey('custom-range'),
                      padding: const EdgeInsets.only(top: AppSpacing.lg),
                      child: Row(
                        children: [
                          Expanded(
                            child: _DateCard(
                              title: 'From',
                              value: _customStartDate != null
                                  ? date_utils.DateUtils.formatDate(_customStartDate!)
                                  : 'Select date',
                              onTap: _selectStartDate,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _DateCard(
                              title: 'To',
                              value: _customEndDate != null
                                  ? date_utils.DateUtils.formatDate(_customEndDate!)
                                  : 'Select date',
                              onTap: _selectEndDate,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(key: ValueKey('preset-range')),
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.description_outlined, color: AppColors.primary),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Your report will include',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildCheckItem('Full meal log history for the period'),
                  _buildCheckItem('Adherence and consistency insights'),
                  _buildCheckItem('Client notes and alternative selections'),
                  _buildCheckItem('Weekly summaries ready to share'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton.icon(
              onPressed: _generateReport,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Generate report'),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded, color: AppColors.success, size: 18),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onSelected;

  const _RangeChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: AppColors.primary.withValues(alpha: 0.18),
      backgroundColor: Colors.white,
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? AppColors.primaryDark : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.divider,
        ),
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _DateCard({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPlaceholder = value == 'Select date';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isPlaceholder
                              ? AppColors.textDisabled
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const Icon(Icons.calendar_today, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

