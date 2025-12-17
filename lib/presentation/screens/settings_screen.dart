import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:tona_mvp/presentation/providers/meal_plan_provider.dart';
import 'package:tona_mvp/core/constants/app_constants.dart';
import 'package:tona_mvp/core/theme/app_colors.dart';
import 'package:tona_mvp/core/theme/app_spacing.dart';
import 'package:tona_mvp/core/theme/app_typography.dart';
import 'package:tona_mvp/core/utils/time_provider.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';
import 'package:tona_mvp/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences _prefs;
  bool _isLoading = true;
  String _currentLanguage = 'en';
  bool _skipOnboarding = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLanguage = _prefs.getString('languageCode') ?? 'en';
      _skipOnboarding = _prefs.getBool('skipOnboarding') ?? false;
      _isLoading = false;
    });
  }

  void _toggleSkipOnboarding(bool value) {
    setState(() {
      _skipOnboarding = value;
    });
    _prefs.setBool('skipOnboarding', value);
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
    });
    _prefs.setString('languageCode', languageCode);
    MyApp.setLocale(context, Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(localizations.settings),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildSectionHeader(localizations.language),
          const SizedBox(height: AppSpacing.sm),
          _buildLanguageCard(localizations),
          const SizedBox(height: AppSpacing.xl),
          _buildSectionHeader(localizations.settings_debug),
          const SizedBox(height: AppSpacing.sm),
          _buildDebugCard(localizations),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Text(
        title,
        style: AppTypography.titleMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLanguageCard(AppLocalizations localizations) {
    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.surfaceVariant),
      ),
      child: Column(
        children: [
          _buildLanguageTile(
            title: localizations.english,
            code: 'en',
            isFirst: true,
          ),
          _buildDivider(),
          _buildLanguageTile(
            title: localizations.german,
            code: 'de',
          ),
          _buildDivider(),
          _buildLanguageTile(
            title: localizations.serbian,
            code: 'sr',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({
    required String title,
    required String code,
    bool isFirst = false,
    bool isLast = false,
  }) {
    final isSelected = _currentLanguage == code;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _changeLanguage(code),
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(20) : Radius.zero,
          bottom: isLast ? const Radius.circular(20) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.bodyLarge.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDebugCard(AppLocalizations localizations) {
    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.surfaceVariant),
      ),
      child: Column(
        children: [
          SwitchListTile(
            title: Text(
              localizations.settings_skipOnboarding,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            value: _skipOnboarding,
            onChanged: _toggleSkipOnboarding,
            activeThumbColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          ),
          _buildDivider(),
          _buildActionTile(
            icon: Icons.restart_alt_rounded,
            title: localizations.resetOnboarding,
            onTap: () {
              // Clear persistent state
              _prefs.setBool('onboardingComplete', false);
              _prefs.setBool('skipOnboarding', false);
              
              // Clear in-memory provider state
              context.read<MealPlanProvider>().clearMealPlan();
              
              // Navigate to splash/onboarding
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/splash', (route) => false);
            },
            isFirst: false, // Changed from true since it's not first anymore
          ),
          _buildDivider(),
          _buildActionTile(
            icon: Icons.swipe_rounded,
            title: localizations.resetSwipeCoach,
            onTap: () {
              _prefs.setBool(AppConstants.hasSeenNextMealSwipeHintKey, false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.resetSwipeCoachMessage)),
              );
            },
          ),
          _buildDivider(),
          _buildActionTile(
            icon: Icons.access_time_rounded,
            title: localizations.changeTime,
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                final now = DateTime.now();
                final newTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  selectedTime.hour,
                  selectedTime.minute,
                  244,
                );
                TimeProvider.setOverride(newTime);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.changeTimeMessage)),
                  );
                }
              }
            },
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(20) : Radius.zero,
          bottom: isLast ? const Radius.circular(20) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textDisabled,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.surfaceVariant,
      indent: AppSpacing.md,
      endIndent: AppSpacing.md,
    );
  }
}
