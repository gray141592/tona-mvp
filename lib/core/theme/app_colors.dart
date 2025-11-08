import 'package:flutter/material.dart';

class AppColors {
  // Core brand palette - Science-based calming colors
  // Primary: Soft sage green - associated with nature, healing, calm, and trust
  // Research shows green reduces anxiety and promotes feelings of safety
  static const Color primary = Color(0xFF2F7A8A);
  static const Color primaryDark = Color(0xFF5A8A6A);
  static const Color primaryLight = Color(0xFFE8F0EB);

  // Secondary: Soft teal - calming and refreshing, reduces stress
  static const Color secondary = Color(0xFF7FB3B3);
  // Accent: Gentle blue - trustworthy and calming, promotes focus
  static const Color accent = Color(0xFF7A9BC4);

  // Feedback colors - Muted tones to avoid triggering stress responses
  // Success: Soft green - positive but not overwhelming
  static const Color success = Color(0xFF5FAF7A);
  // Warning: Soft amber - gentle alert without alarm
  static const Color warning = Color(0xFFD4A574);
  // Error: Soft coral - informative but not panic-inducing
  static const Color error = Color(0xFFD48A7A);
  // Info: Soft sky blue - calming and informative
  static const Color info = Color(0xFF7A9BC4);

  // Surfaces & backgrounds - Warm tones reduce eye strain and feel welcoming
  // Background: Warm off-white - reduces harsh contrast, feels inviting
  static const Color background = Color(0xFFFAF8F5);
  // Surface: Warm white - soft and approachable
  static const Color surface = Color(0xFFFFFEFB);
  // Surface variant: Very light warm gray - subtle separation
  static const Color surfaceVariant = Color(0xFFF5F3F0);

  // Text & support - Warm dark grays instead of pure black for softer appearance
  // Text primary: Warm dark gray - high contrast but less harsh than black
  static const Color textPrimary = Color(0xFF2C2C2C);
  // Text secondary: Medium warm gray - comfortable reading
  static const Color textSecondary = Color(0xFF6B6B6B);
  // Text disabled: Light warm gray - clearly inactive but not jarring
  static const Color textDisabled = Color(0xFFB8B8B8);

  // Divider: Soft warm gray - subtle separation
  static const Color divider = Color(0xFFE8E6E3);

  // Meal type accents - Soft, muted tones that feel nourishing
  static const Color mealBreakfast = Color(0xFFF5EDE0);
  static const Color mealLunch = Color(0xFFE8F0EB);
  static const Color mealDinner = Color(0xFFF0E8F0);
  static const Color mealSnack = Color(0xFFE8F0EB);

  // Solid fills
  static const Color buttonPrimary = primary;
  static const Color buttonSuccess = success;
}
