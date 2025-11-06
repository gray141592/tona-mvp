import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/meal.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/constants/app_constants.dart';
import '../providers/meal_log_provider.dart';

class LogAlternativeScreen extends StatefulWidget {
  final Meal meal;

  const LogAlternativeScreen({
    super.key,
    required this.meal,
  });

  @override
  State<LogAlternativeScreen> createState() => _LogAlternativeScreenState();
}

class _LogAlternativeScreenState extends State<LogAlternativeScreen> {
  final _alternativeMealController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _alternativeMealController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveAlternative() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final mealLogProvider = context.read<MealLogProvider>();
    await mealLogProvider.logMealAsAlternative(
      clientId: AppConstants.mockClientId,
      mealId: widget.meal.id,
      loggedDate: DateTime.now(),
      alternativeMeal: _alternativeMealController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Alternative Meal'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Original Meal',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      widget.meal.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      widget.meal.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'What did you eat instead?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              controller: _alternativeMealController,
              decoration: const InputDecoration(
                hintText: 'e.g., Caesar salad with grilled chicken',
                labelText: 'Alternative Meal',
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please describe what you ate';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Notes (optional)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                hintText: 'Add any additional notes...',
                labelText: 'Notes',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveAlternative,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Alternative'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

