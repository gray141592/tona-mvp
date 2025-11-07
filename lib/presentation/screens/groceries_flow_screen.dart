import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/time_provider.dart';
import '../../data/models/meal_plan.dart';
import '../providers/meal_plan_provider.dart';
import '../widgets/dashboard_page_shell.dart';

class GroceriesFlowScreen extends StatefulWidget {
  const GroceriesFlowScreen({super.key});

  @override
  State<GroceriesFlowScreen> createState() => _GroceriesFlowScreenState();
}

class _GroceriesFlowScreenState extends State<GroceriesFlowScreen> {
  int _selectedDays = 5;
  final List<_GroceryItem> _items = [];
  bool _listGenerated = false;

  MealPlan? get _mealPlan => context.read<MealPlanProvider>().currentMealPlan;

  void _updateDays(int days) {
    setState(() {
      _selectedDays = days;
    });
  }

  Future<void> _generateGroceries() async {
    final mealPlan = _mealPlan;

    if (mealPlan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You need a meal plan to build a groceries list.',),),
      );
      return;
    }

    final mealPlanProvider = context.read<MealPlanProvider>();
    final counts = <String, int>{};

    for (var offset = 0; offset < _selectedDays; offset++) {
      final date = TimeProvider.now().add(Duration(days: offset));
      final meals = mealPlanProvider.getMealsForDate(date);

      for (final meal in meals) {
        for (final ingredient in meal.ingredients) {
          final key = ingredient.trim();
          if (key.isEmpty) continue;
          counts[key] = (counts[key] ?? 0) + 1;
        }
      }
    }

    setState(() {
      _items
        ..clear()
        ..addAll(
          counts.entries
              .map(
                (entry) => _GroceryItem(
                  label: _formatIngredient(entry.key, entry.value),
                ),
              )
              .toList()
            ..sort((a, b) => a.label.compareTo(b.label)),
        );
      _listGenerated = true;
    });

    if (_items.isEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No grocery items found for the selected days.',),),
      );
    }
  }

  Future<void> _addCustomItem() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add custom item'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'e.g., Olive oil (500ml)',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (result == null || result.isEmpty) return;

    setState(() {
      _items.add(_GroceryItem(label: result));
      _listGenerated = true;
    });
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index] = _items[index].copyWith(included: !_items[index].included);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  Future<void> _shareList() async {
    final includedItems = _items.where((item) => item.included).toList();

    if (includedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one item to share.')),
      );
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('Groceries list for the next $_selectedDays day(s)');
    buffer.writeln(
        'Generated on ${date_utils.DateUtils.formatDate(TimeProvider.now())}\n',);

    for (final item in includedItems) {
      buffer.writeln('• ${item.label}');
    }

    try {
      // ignore: deprecated_member_use, deprecated_member_use_from_same_package
      await Share.share(
        buffer.toString(),
        subject: 'Groceries list',
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to share groceries list: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardPageShell(
      title: 'Groceries list',
      subtitle: 'Shopping for $_selectedDays day(s)',
      bodyPadding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const _StepHeader(
            stepNumber: 1,
            title: 'Choose planning window',
            subtitle: 'How many days of meals are you shopping for?',
          ),
          const SizedBox(height: AppSpacing.sm),
          _DaysSelector(
            selectedDays: _selectedDays,
            onChanged: _updateDays,
          ),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton.icon(
            onPressed: _generateGroceries,
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Generate groceries list'),
          ),
          const SizedBox(height: AppSpacing.xl),
          const _StepHeader(
            stepNumber: 2,
            title: 'Review and adjust',
            subtitle: 'Remove anything you already have and add extra items.',
          ),
          const SizedBox(height: AppSpacing.sm),
          if (!_listGenerated)
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Text(
                'Your generated list will appear here. Tap the button above once you’ve selected how many days to shop for.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          else
            Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.xs),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _GroceryListTile(
                      item: item,
                      onToggle: () => _toggleItem(index),
                      onRemove: () => _removeItem(index),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _addCustomItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Add custom item'),
                  ),
                ),
              ],
            ),
          const SizedBox(height: AppSpacing.xl),
          const _StepHeader(
            stepNumber: 3,
            title: 'Share your list',
            subtitle:
                'Send to your phone, a coach, or anyone helping with groceries.',
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: _items.isEmpty ? null : _shareList,
            icon: const Icon(Icons.share_outlined),
            label: const Text('Share groceries list'),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  String _formatIngredient(String ingredient, int occurrences) {
    final sanitized = ingredient.trim();
    if (occurrences <= 1) return sanitized;
    return '$occurrences × $sanitized';
  }
}

class _GroceryItem {
  final String label;
  final bool included;

  const _GroceryItem({
    required this.label,
    this.included = true,
  });

  _GroceryItem copyWith({String? label, bool? included}) {
    return _GroceryItem(
      label: label ?? this.label,
      included: included ?? this.included,
    );
  }
}

class _GroceryListTile extends StatelessWidget {
  final _GroceryItem item;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  const _GroceryListTile({
    required this.item,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: CheckboxListTile(
        value: item.included,
        onChanged: (_) => onToggle(),
        title: Text(
          item.label,
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        secondary: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onRemove,
          tooltip: 'Remove item',
        ),
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  final int stepNumber;
  final String title;
  final String subtitle;

  const _StepHeader({
    required this.stepNumber,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            stepNumber.toString(),
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DaysSelector extends StatelessWidget {
  final int selectedDays;
  final ValueChanged<int> onChanged;
  static const _options = [3, 5, 7];

  const _DaysSelector({
    required this.selectedDays,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            children: _options
                .map(
                  (option) => ChoiceChip(
                    label: Text('$option days'),
                    selected: selectedDays == option,
                    onSelected: (_) => onChanged(option),
                    selectedColor: AppColors.primary.withValues(alpha: 0.18),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Or set a custom range',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              min: 1,
              max: 14,
              divisions: 13,
              label: '$selectedDays day(s)',
              value: selectedDays.toDouble(),
              onChanged: (value) => onChanged(value.round()),
            ),
          ),
        ],
      ),
    );
  }
}
