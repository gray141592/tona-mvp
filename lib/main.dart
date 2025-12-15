
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/page_transitions.dart';
import 'core/constants/app_constants.dart';
import 'data/repositories/meal_plan_repository.dart';
import 'data/repositories/meal_log_repository.dart';
import 'data/repositories/consultation_repository.dart';
import 'data/models/meal_plan.dart';
import 'data/mock_data/mock_data.dart';
import 'domain/services/progress_service.dart';
import 'presentation/providers/meal_plan_provider.dart';
import 'presentation/providers/meal_log_provider.dart';
import 'presentation/providers/progress_provider.dart';
import 'presentation/providers/consultation_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/meal_plan_upload_screen.dart';
import 'presentation/screens/meal_plan_review_screen.dart';
import 'presentation/screens/meal_plan_processing_screen.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
  
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      setState(() {
        _locale = Locale(languageCode);
      });
    }
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mealPlanRepository = MealPlanRepository();
    final mealLogRepository = MealLogRepository();
    final consultationRepository = ConsultationRepository();
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
        ChangeNotifierProvider(
          create: (_) {
            final provider = ConsultationProvider(consultationRepository);
            provider.loadAppointments(MockData.getMockConsultations());
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'IRresistible',
        theme: AppTheme.lightTheme.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: SlidePageTransition(),
              TargetPlatform.android: SlidePageTransition(),
            },
          ),
        ),
        locale: _locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('de', ''),
          Locale('sr', ''),
        ],
        home: const OnboardingFlow(),
        routes: {
          '/settings': (context) => const SettingsScreen(),
          '/splash': (context) => const SplashScreen(onComplete: MyApp.onSplashComplete),
        },
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
  int _currentStep = 0; // 0 splash, 1 upload, 2 processing, 3 review, 4 home
  MealPlan? _selectedMealPlan;

  @override
  void initState() {
    super.initState();
    if (AppConstants.skipOnboarding) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final mealPlanProvider = context.read<MealPlanProvider>();
        mealPlanProvider.loadMealPlan(MockData.getMockMealPlan());
      });
    }
  }
  
  static void onSplashComplete() {
    //This is a static method now and the state will be handled differently
  }

  void _onSplashComplete() {
    debugPrint('Splash complete, moving to upload screen');
    setState(() {
      _currentStep = 1;
    });
  }

  void _onFileSelected() {
    debugPrint('_onFileSelected called in main.dart');
    debugPrint('Moving to processing screen...');
    setState(() {
      _currentStep = 2;
    });
  }

  void _onProcessingComplete() {
    debugPrint('Processing complete, preparing review screen...');
    setState(() {
      _selectedMealPlan = MockData.getMockMealPlan();
      _currentStep = 3;
    });
  }

  void _onProcessingCancelled() {
    debugPrint('Processing cancelled, returning to upload screen');
    setState(() {
      _selectedMealPlan = null;
      _currentStep = 1;
    });
  }

  void _onReviewCancelled() {
    debugPrint('Review cancelled, returning to upload screen');
    setState(() {
      _selectedMealPlan = null;
      _currentStep = 1;
    });
  }

  void _onMealPlanAccepted() {
    debugPrint('Meal plan accepted, moving to home screen');
    if (_selectedMealPlan != null) {
      final mealPlanProvider = context.read<MealPlanProvider>();
      mealPlanProvider.loadMealPlan(_selectedMealPlan!);
    }
    setState(() {
      _currentStep = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (AppConstants.skipOnboarding) {
      return const HomeScreen();
    }

    final mealPlanProvider = context.watch<MealPlanProvider>();
    if (mealPlanProvider.currentMealPlan != null || _currentStep >= 4) {
      return const HomeScreen();
    }

    switch (_currentStep) {
      case 0:
        return SplashScreen(onComplete: _onSplashComplete);
      case 1:
        return MealPlanUploadScreen(onFileSelected: _onFileSelected);
      case 2:
        return MealPlanProcessingScreen(
          onComplete: _onProcessingComplete,
          onCancel: _onProcessingCancelled,
        );
      case 3:
        if (_selectedMealPlan == null) {
          return MealPlanUploadScreen(onFileSelected: _onFileSelected);
        }
        return MealPlanReviewScreen(
          mealPlan: _selectedMealPlan!,
          onAccept: _onMealPlanAccepted,
          onCancel: _onReviewCancelled,
        );
      default:
        return const HomeScreen();
    }
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreen();
  }
}
