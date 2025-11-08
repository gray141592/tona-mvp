import 'time_provider.dart';

class MessageGenerator {
  static String getMealLoggedMessage(String mealName) {
    final messages = [
      'Amazing! $mealName logged! 🎉',
      'You\'re crushing it! $mealName is done! 💪',
      'Perfect! $mealName logged successfully! ✨',
      'Great job logging $mealName! Keep it up! 🌟',
      '$mealName logged! You\'re on fire! 🔥',
    ];
    return messages[TimeProvider.now().millisecond % messages.length];
  }

  static String getAlternativeLoggedMessage(String mealName) {
    final messages = [
      'Nice! Alternative logged for $mealName! 🍽️',
      'Got it! $mealName alternative saved! ✅',
      'Perfect! Alternative logged for $mealName! 📝',
    ];
    return messages[TimeProvider.now().millisecond % messages.length];
  }

  static String getProgressMessage(
    int completed,
    int total,
    double percentage,
  ) {
    if (percentage >= 100) {
      return 'Perfect day! All meals logged! 🏆';
    }
    if (percentage >= 80) {
      return 'Almost there! $completed/$total meals done! 💪';
    }
    if (percentage >= 50) {
      return 'Halfway there! $completed/$total meals logged! 📈';
    }
    return 'Keep going! $completed/$total meals logged so far! 🌱';
  }

  static String getStreakMessage(int days) {
    if (days >= 7) {
      return 'Incredible! $days day streak! 🔥';
    }
    if (days >= 3) {
      return 'Great streak! $days days in a row! 💪';
    }
    return 'Keep it up! Day $days of your streak! 🌟';
  }

  static String getNextMealMessage(String mealName, String time) {
    return 'Next up: $mealName at $time ⏰';
  }

  static String getEncouragementMessage() {
    final messages = [
      'You\'ve got this! 💪',
      'One meal at a time! 🌟',
      'Every meal counts! ✨',
      'You\'re doing great! 🎯',
      'Keep the momentum going! 🚀',
    ];
    return messages[TimeProvider.now().millisecond % messages.length];
  }
}
