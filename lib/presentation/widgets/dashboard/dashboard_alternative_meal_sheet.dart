import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/meal.dart';
import '../../providers/meal_log_provider.dart';
import '../../screens/dashboard_glycemic_info_screen.dart';

class DashboardAlternativeMealSheet extends StatefulWidget {
  final Meal? meal;
  final DateTime loggedDate;
  final bool isUnplanned;

  const DashboardAlternativeMealSheet({
    super.key,
    this.meal,
    required this.loggedDate,
    this.isUnplanned = false,
  });

  @override
  State<DashboardAlternativeMealSheet> createState() =>
      _DashboardAlternativeMealSheetState();
}

class _DashboardAlternativeMealSheetState
    extends State<DashboardAlternativeMealSheet> {
  final _alternativeController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  bool _containsSugar = false;
  bool _hasHighGlycemicIndex = false;

  @override
  void dispose() {
    _alternativeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving || !_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final mealLogProvider = context.read<MealLogProvider>();

    if (widget.isUnplanned || widget.meal == null) {
      // Log as unplanned meal
      await mealLogProvider.logUnplannedMeal(
        clientId: AppConstants.mockClientId,
        loggedDate: widget.loggedDate,
        mealName: _alternativeController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        containsSugar: _containsSugar,
        hasHighGlycemicIndex: _hasHighGlycemicIndex,
      );
    } else {
      // Log as alternative to existing meal
      await mealLogProvider.logMealAsAlternative(
        clientId: AppConstants.mockClientId,
        mealId: widget.meal!.id,
        loggedDate: widget.loggedDate,
        alternativeMeal: _alternativeController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        containsSugar: _containsSugar,
        hasHighGlycemicIndex: _hasHighGlycemicIndex,
      );
    }

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _openGlycemicInfoScreen() async {
    await Navigator.of(context).push<void>(
      DashboardGlycemicInfoScreen.route(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.xl,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  widget.isUnplanned ? 'Add unplanned meal' : 'Log alternative',
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (widget.meal != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    widget.meal!.name,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _alternativeController,
                  decoration: InputDecoration(
                    labelText: widget.isUnplanned
                        ? 'What did you eat?'
                        : 'What did you eat instead?',
                    hintText: widget.isUnplanned
                        ? 'Describe the meal...'
                        : 'Describe the meal you had...',
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please provide a short description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes (optional)',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Blood sugar impact',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: _containsSugar,
                  onChanged: (value) => setState(() {
                    _containsSugar = value;
                  }),
                  title: const Text('Contains added sugar'),
                  subtitle: const Text(
                    'Mark if the alternative meal includes refined sugar or sweet syrups.',
                  ),
                ),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: _hasHighGlycemicIndex,
                  onChanged: (value) => setState(() {
                    _hasHighGlycemicIndex = value;
                  }),
                  title: Row(
                    children: [
                      const Expanded(
                        child: Text('High glycemic index'),
                      ),
                      IconButton(
                        onPressed: _openGlycemicInfoScreen,
                        icon: const Icon(Icons.info_outline),
                        tooltip: 'Glycemic index guide',
                      ),
                    ],
                  ),
                  subtitle: const Text(
                    'Select when the meal is likely to cause a sharp blood sugar spike.',
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                ElevatedButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(
                    _isSaving
                        ? 'Saving...'
                        : widget.isUnplanned
                            ? 'Save meal'
                            : 'Save alternative',
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
