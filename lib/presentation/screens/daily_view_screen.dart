import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/meal.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/message_generator.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/time_provider.dart';
import '../providers/meal_plan_provider.dart';
import '../providers/meal_log_provider.dart';
import '../providers/progress_provider.dart';
import '../widgets/dashboard_page_shell.dart';
import '../widgets/meal_card.dart';
import '../widgets/progress_indicator.dart' as app_progress;
import '../widgets/success_toast.dart';
import 'log_alternative_screen.dart';

class DailyViewScreen extends StatefulWidget {
  const DailyViewScreen({super.key});

  @override
  State<DailyViewScreen> createState() => _DailyViewScreenState();
}

class _DailyViewScreenState extends State<DailyViewScreen> {
  DateTime _selectedDate = TimeProvider.now();
  bool _showDateNavigation = false;

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: TimeProvider.now().subtract(const Duration(days: 30)),
      lastDate: TimeProvider.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _navigateToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _navigateToNextDay() {
    if (_selectedDate.isBefore(TimeProvider.now())) {
      setState(() {
        _selectedDate = _selectedDate.add(const Duration(days: 1));
      });
    }
  }

  Future<void> _logMealAsFollowed(Meal meal) async {
    final mealLogProvider = context.read<MealLogProvider>();
    await mealLogProvider.logMealAsFollowed(
      clientId: AppConstants.mockClientId,
      mealId: meal.id,
      loggedDate: _selectedDate,
    );

    if (!mounted) return;
    context.read<ProgressProvider>().refresh();

    if (mounted) {
      SuccessToast.show(
        context,
        MessageGenerator.getMealLoggedMessage(meal.name),
        emoji: '🎉',
      );
    }
  }

  Future<void> _logMealAsAlternative(Meal meal) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => LogAlternativeScreen(meal: meal),
      ),
    );

    if (result == true && mounted) {
      context.read<ProgressProvider>().refresh();
      SuccessToast.show(
        context,
        MessageGenerator.getAlternativeLoggedMessage(meal.name),
        emoji: '✅',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealPlanProvider = context.watch<MealPlanProvider>();
    final mealLogProvider = context.watch<MealLogProvider>();
    final progressProvider = context.watch<ProgressProvider>();

    final meals = mealPlanProvider.getMealsForDate(_selectedDate);
    final dailyProgress = progressProvider.getDailyProgress(_selectedDate);

    final isToday =
        date_utils.DateUtils.isSameDay(_selectedDate, TimeProvider.now());
    final canNavigateNext = _selectedDate.isBefore(TimeProvider.now());

    Meal? nextMeal;
    for (final meal in meals) {
      final mealLog = mealLogProvider.getLogForMeal(meal.id, _selectedDate);
      if (mealLog == null) {
        nextMeal = meal;
        break;
      }
    }

    final unloggedMeals = meals.where((meal) {
      final mealLog = mealLogProvider.getLogForMeal(meal.id, _selectedDate);
      return mealLog == null;
    }).toList();

    final loggedMeals = meals.where((meal) {
      final mealLog = mealLogProvider.getLogForMeal(meal.id, _selectedDate);
      return mealLog != null;
    }).toList();

    return DashboardPageShell(
      title: 'Daily schedule',
      subtitle: date_utils.DateUtils.formatDate(_selectedDate),
      bodyPadding: EdgeInsets.zero,
      child: Column(
        children: [
          _DateHeaderSection(
            selectedDate: _selectedDate,
            isToday: isToday,
            showDateNavigation: _showDateNavigation,
            canNavigateNext: canNavigateNext,
            onToggleNavigation: () {
              setState(() {
                _showDateNavigation = !_showDateNavigation;
              });
            },
            onSelectDate: _selectDate,
            onNavigatePrevious: _navigateToPreviousDay,
            onNavigateNext: _navigateToNextDay,
          ),
          Expanded(
            child: meals.isEmpty
                ? const _EmptyMealsView()
                : ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.lg,
                    ),
                    children: [
                      app_progress.ProgressIndicator(
                        current: dailyProgress.mealsLogged,
                        total: dailyProgress.totalMeals,
                        label: 'Meals logged',
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      if (nextMeal != null) ...[
                        _NextMealCardSection(
                          meal: nextMeal,
                          onFollowed: () => _logMealAsFollowed(nextMeal!),
                          onAlternative: () => _logMealAsAlternative(nextMeal!),
                        ),
                        if (unloggedMeals.length > 1 || loggedMeals.isNotEmpty)
                          const SizedBox(height: AppSpacing.md),
                      ],
                      if (unloggedMeals.length > 1 ||
                          (unloggedMeals.length == 1 && nextMeal == null))
                        _UnloggedMealsSection(
                          meals: unloggedMeals,
                          nextMeal: nextMeal,
                          selectedDate: _selectedDate,
                          onFollowed: _logMealAsFollowed,
                          onAlternative: _logMealAsAlternative,
                          hasLoggedMeals: loggedMeals.isNotEmpty,
                        ),
                      if (loggedMeals.isNotEmpty)
                        _LoggedMealsSection(
                          meals: loggedMeals,
                          selectedDate: _selectedDate,
                        ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _DateHeaderSection extends StatelessWidget {
  const _DateHeaderSection({
    required this.selectedDate,
    required this.isToday,
    required this.showDateNavigation,
    required this.canNavigateNext,
    required this.onToggleNavigation,
    required this.onSelectDate,
    required this.onNavigatePrevious,
    required this.onNavigateNext,
  });

  final DateTime selectedDate;
  final bool isToday;
  final bool showDateNavigation;
  final bool canNavigateNext;
  final VoidCallback onToggleNavigation;
  final VoidCallback onSelectDate;
  final VoidCallback onNavigatePrevious;
  final VoidCallback onNavigateNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.14),
                  AppColors.surface,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            isToday
                                ? 'Today'
                                : date_utils.DateUtils.formatDayOfWeek(
                                    selectedDate),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          if (isToday) ...[
                            const SizedBox(width: AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                'On track',
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        date_utils.DateUtils.formatDate(selectedDate),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: onToggleNavigation,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 200),
                        turns: showDateNavigation ? 0.5 : 0,
                        curve: Curves.easeOutCubic,
                        child: Icon(
                          showDateNavigation
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.calendar_today,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: showDateNavigation
                ? Container(
                    key: const ValueKey('nav-expanded'),
                    margin: const EdgeInsets.only(top: AppSpacing.sm),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        _NavigationControl(
                          icon: Icons.chevron_left,
                          onPressed: onNavigatePrevious,
                        ),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: onSelectDate,
                            icon: const Icon(Icons.edit_calendar_rounded),
                            label: const Text('Choose date'),
                          ),
                        ),
                        if (canNavigateNext)
                          _NavigationControl(
                            icon: Icons.chevron_right,
                            onPressed: onNavigateNext,
                          ),
                      ],
                    ),
                  )
                : const SizedBox(key: ValueKey('nav-collapsed')),
          ),
        ],
      ),
    );
  }
}

class _NavigationControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _NavigationControl({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: AppColors.primary,
      ),
    );
  }
}

class _EmptyMealsView extends StatelessWidget {
  const _EmptyMealsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 30,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryLight,
                    AppColors.surfaceVariant,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.restaurant_menu,
                size: 56,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No meals scheduled today',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Enjoy the pause or pick another date from the calendar.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NextMealCardSection extends StatelessWidget {
  const _NextMealCardSection({
    required this.meal,
    required this.onFollowed,
    required this.onAlternative,
  });

  final Meal meal;
  final VoidCallback onFollowed;
  final VoidCallback onAlternative;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.flash_on_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next meal to log',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      Text(
                        'Stay consistent to keep your momentum going.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          MealCard(
            key: ValueKey('next-${meal.id}'),
            meal: meal,
            mealLog: null,
            isLogged: false,
            onFollowed: onFollowed,
            onAlternative: onAlternative,
          ),
        ],
      ),
    );
  }
}

class _UnloggedMealsSection extends StatelessWidget {
  const _UnloggedMealsSection({
    required this.meals,
    required this.nextMeal,
    required this.selectedDate,
    required this.onFollowed,
    required this.onAlternative,
    required this.hasLoggedMeals,
  });

  final List<Meal> meals;
  final Meal? nextMeal;
  final DateTime selectedDate;
  final Function(Meal) onFollowed;
  final Function(Meal) onAlternative;
  final bool hasLoggedMeals;

  @override
  Widget build(BuildContext context) {
    final mealLogProvider = context.watch<MealLogProvider>();
    final mealsToDisplay = meals.where((meal) => meal != nextMeal);

    return Column(
      children: [
        ...mealsToDisplay.map((meal) {
          final mealLog = mealLogProvider.getLogForMeal(
            meal.id,
            selectedDate,
          );
          return MealCard(
            key: ValueKey(meal.id),
            meal: meal,
            mealLog: mealLog,
            isLogged: false,
            onFollowed: () => onFollowed(meal),
            onAlternative: () => onAlternative(meal),
          );
        }),
        if (hasLoggedMeals) const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _LoggedMealsSection extends StatelessWidget {
  const _LoggedMealsSection({
    required this.meals,
    required this.selectedDate,
  });

  final List<Meal> meals;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final mealLogProvider = context.watch<MealLogProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Completed meals (${meals.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          children: [
            ...meals.map((meal) {
              final mealLog = mealLogProvider.getLogForMeal(
                meal.id,
                selectedDate,
              );
              return MealCard(
                key: ValueKey('logged-${meal.id}'),
                meal: meal,
                mealLog: mealLog,
                isLogged: true,
                onFollowed: null,
                onAlternative: null,
              );
            }),
          ],
        ),
      ),
    );
  }
}
