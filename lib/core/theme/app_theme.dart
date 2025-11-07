import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        tertiary: AppColors.accent,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        outline: AppColors.divider,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );

    final textTheme = base.textTheme
        .apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        )
        .copyWith(
          displayLarge:
              AppTypography.displayLarge.copyWith(color: AppColors.textPrimary),
          displayMedium: AppTypography.displayMedium
              .copyWith(color: AppColors.textPrimary),
          displaySmall:
              AppTypography.displaySmall.copyWith(color: AppColors.textPrimary),
          headlineMedium: AppTypography.headlineMedium
              .copyWith(color: AppColors.textPrimary),
          titleLarge:
              AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
          titleMedium:
              AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          bodyLarge:
              AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
          bodyMedium:
              AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
          bodySmall:
              AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
          labelLarge:
              AppTypography.labelLarge.copyWith(color: AppColors.textPrimary),
          labelMedium: AppTypography.labelMedium
              .copyWith(color: AppColors.textSecondary),
        );

    return base.copyWith(
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: AppTypography.labelLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          textStyle: AppTypography.labelLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: const BorderSide(color: AppColors.divider, width: 1.2),
          textStyle: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        labelStyle:
            AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        hintStyle:
            AppTypography.bodyMedium.copyWith(color: AppColors.textDisabled),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 32,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primary.withValues(alpha: 0.12),
        secondarySelectedColor: AppColors.primary,
        labelStyle:
            AppTypography.labelMedium.copyWith(color: AppColors.textPrimary),
      ),
      listTileTheme: base.listTileTheme.copyWith(
        iconColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        tileColor: AppColors.surface,
        selectedTileColor: AppColors.primary.withValues(alpha: 0.08),
      ),
      dialogTheme: base.dialogTheme.copyWith(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
