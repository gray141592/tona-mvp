import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_spacing.dart';
import 'core/utils/page_transitions.dart';
import 'data/repositories/meal_plan_repository.dart';
import 'data/repositories/meal_log_repository.dart';
import 'data/models/meal_plan.dart';
import 'data/mock_data/mock_data.dart';
import 'domain/services/progress_service.dart';
import 'presentation/providers/meal_plan_provider.dart';
import 'presentation/providers/meal_log_provider.dart';
import 'presentation/providers/progress_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/meal_plan_upload_screen.dart';
import 'presentation/screens/meal_plan_review_screen.dart';
import 'presentation/screens/meal_plan_overview_screen.dart';
import 'presentation/screens/daily_view_screen.dart';
import 'presentation/screens/weekly_progress_screen.dart';
import 'presentation/screens/report_generation_screen.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_typography.dart';

void main() {
  runApp(const TonaApp());
}

class TonaApp extends StatelessWidget {
  const TonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mealPlanRepository = MealPlanRepository();
    final mealLogRepository = MealLogRepository();
    final progressService = ProgressService(
      mealPlanRepository: mealPlanRepository,
      mealLogRepository: mealLogRepository,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MealPlanProvider(mealPlanRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => MealLogProvider(mealLogRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ProgressProvider(progressService),
        ),
      ],
      child: MaterialApp(
        title: 'Tona',
        theme: AppTheme.lightTheme.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: SlidePageTransition(),
              TargetPlatform.android: SlidePageTransition(),
            },
          ),
        ),
        home: const OnboardingFlow(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _currentStep = 0; // 0: splash, 1: upload, 2: review, 3: home
  MealPlan? _selectedMealPlan;

  void _onSplashComplete() {
    debugPrint('Splash complete, moving to upload screen');
    setState(() {
      _currentStep = 1;
    });
  }

  void _onFileSelected() {
    debugPrint('_onFileSelected called in main.dart');
    debugPrint('Creating mock meal plan and moving to review...');
    setState(() {
      _selectedMealPlan = MockData.getMockMealPlan();
      _currentStep = 2;
    });
  }

  void _onMealPlanAccepted() {
    debugPrint('Meal plan accepted, moving to home screen');
    if (_selectedMealPlan != null) {
      final mealPlanProvider = context.read<MealPlanProvider>();
      mealPlanProvider.loadMealPlan(_selectedMealPlan!);
    }
    setState(() {
      _currentStep = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mealPlanProvider = context.watch<MealPlanProvider>();
    if (mealPlanProvider.currentMealPlan != null || _currentStep == 3) {
      return const HomeScreen();
    }

    switch (_currentStep) {
      case 0:
        return SplashScreen(onComplete: _onSplashComplete);
      case 1:
        return MealPlanUploadScreen(onFileSelected: _onFileSelected);
      case 2:
        return MealPlanReviewScreen(
          mealPlan: _selectedMealPlan!,
          onAccept: _onMealPlanAccepted,
        );
      default:
        return const HomeScreen();
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    const DailyViewScreen(key: ValueKey('daily')),
    const WeeklyProgressScreen(key: ValueKey('weekly')),
    const ReportGenerationScreen(key: ValueKey('reports')),
  ];

  void _showMealPlanOverview() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MealPlanOverviewScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.04, 0.0),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
            child: _screens[_selectedIndex],
          ),
          _FloatingMealPlanButton(onTap: _showMealPlanOverview),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class _FloatingMealPlanButton extends StatelessWidget {
  final VoidCallback onTap;

  const _FloatingMealPlanButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + AppSpacing.sm,
      right: AppSpacing.md,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.85),
              AppColors.primaryDark.withValues(alpha: 0.9),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            splashColor: Colors.white24,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Meal plan',
                    style: AppTypography.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              _NavItem(
                index: 0,
                icon: Icons.restaurant_menu,
                label: 'Today',
                isSelected: selectedIndex == 0,
                onTap: onItemTapped,
              ),
              _NavItem(
                index: 1,
                icon: Icons.show_chart_outlined,
                label: 'Progress',
                isSelected: selectedIndex == 1,
                onTap: onItemTapped,
              ),
              _NavItem(
                index: 2,
                icon: Icons.insert_chart_outlined_rounded,
                label: 'Reports',
                isSelected: selectedIndex == 2,
                onTap: onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool isSelected;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: isSelected ? 36 : 0,
                    height: isSelected ? 36 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(
                    icon,
                    color:
                        isSelected ? AppColors.primary : AppColors.textSecondary,
                    size: 22,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color:
                      isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: 0.2,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

