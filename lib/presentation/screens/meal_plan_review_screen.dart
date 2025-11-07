import 'package:flutter/material.dart';
import 'package:tona_mvp/presentation/widgets/waiting_screen_shell.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/meal_plan.dart';
import '../../data/models/meal.dart';
import '../../data/models/meal_type.dart';

class MealPlanReviewScreen extends StatefulWidget {
  final MealPlan mealPlan;
  final VoidCallback onAccept;
  final VoidCallback onCancel;

  const MealPlanReviewScreen({
    super.key,
    required this.mealPlan,
    required this.onAccept,
    required this.onCancel,
  });

  @override
  State<MealPlanReviewScreen> createState() => _MealPlanReviewScreenState();
}

class _MealPlanReviewScreenState extends State<MealPlanReviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedDayIndex = 0; // 0 = Monday, 6 = Sunday

  final List<String> _dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Meal> get _mealsForSelectedDay {
    final dayOfWeek = _selectedDayIndex + 1; // Monday = 1, Sunday = 7
    return widget.mealPlan.meals
        .where((meal) => meal.dayOfWeek == dayOfWeek)
        .toList()
      ..sort((a, b) => a.timeScheduled.compareTo(b.timeScheduled));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            return;
          }
          widget.onCancel();
        },
        child: WaitingScreenShell(
          title: 'Review Meal Plan',
          subtitle: _DaySelectorSection(
            dayNames: _dayNames,
            selectedDayIndex: _selectedDayIndex,
            onDaySelected: (index) {
              setState(() {
                _selectedDayIndex = index;
              });
            },
          ),
          body: Column(children: [
            Expanded(
              child: _mealsForSelectedDay.isEmpty
                  ? const _EmptyMealsView()
                  : ListView.builder(
                      itemCount: _mealsForSelectedDay.length,
                      itemBuilder: (context, index) {
                        final meal = _mealsForSelectedDay[index];
                        return _MealItem(meal: meal);
                      },
                    ),
            ),
          ],),
          footer: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                  ),
                  child: const Text('Change File'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: widget.onAccept,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                  ),
                  child: const Text('Confirm Plan'),
                ),
              ),
            ],
          ),
        ),);
  }
}

class _DaySelectorSection extends StatelessWidget {
  const _DaySelectorSection({
    required this.dayNames,
    required this.selectedDayIndex,
    required this.onDaySelected,
  });

  final List<String> dayNames;
  final int selectedDayIndex;
  final ValueChanged<int> onDaySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dayNames.length,
        itemBuilder: (context, index) {
          final isSelected = selectedDayIndex == index;
          return GestureDetector(
            onTap: () => onDaySelected(index),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.xs,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.buttonPrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  dayNames[index].substring(0, 3),
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected ? Colors.black : AppColors.textSecondary,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyMealsView extends StatelessWidget {
  const _EmptyMealsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.restaurant_menu,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No meals scheduled',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealItem extends StatelessWidget {
  const _MealItem({
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getMealTypeColor(meal.mealType).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              meal.mealType.emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.mealType.displayName,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  meal.name,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (meal.description.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    meal.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Text(
            meal.timeScheduled,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMealTypeColor(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return AppColors.mealBreakfast;
      case MealType.lunch:
        return AppColors.mealLunch;
      case MealType.dinner:
        return AppColors.mealDinner;
      case MealType.snack1:
      case MealType.snack2:
        return AppColors.mealSnack;
    }
  }
}
