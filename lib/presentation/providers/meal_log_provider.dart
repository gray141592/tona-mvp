import 'package:flutter/foundation.dart';
import '../../data/models/meal_log.dart';
import '../../data/models/meal_log_status.dart';
import '../../data/repositories/meal_log_repository.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/time_provider.dart';

class MealLogProvider extends ChangeNotifier {
  final MealLogRepository _repository;

  MealLogProvider(this._repository);

  Future<void> logMealAsFollowed({
    required String clientId,
    required String mealId,
    required DateTime loggedDate,
  }) async {
    final now = TimeProvider.now();
    final log = MealLog(
      id: 'log_${now.millisecondsSinceEpoch}',
      clientId: clientId,
      mealId: mealId,
      loggedDate: DateUtils.getDateOnly(loggedDate),
      loggedTime: now,
      status: MealLogStatus.followed,
      createdAt: now,
    );

    await _repository.saveMealLog(log);
    notifyListeners();
  }

  Future<void> logMealAsAlternative({
    required String clientId,
    required String mealId,
    required DateTime loggedDate,
    required String alternativeMeal,
    String? notes,
  }) async {
    final now = TimeProvider.now();
    final log = MealLog(
      id: 'log_${now.millisecondsSinceEpoch}',
      clientId: clientId,
      mealId: mealId,
      loggedDate: DateUtils.getDateOnly(loggedDate),
      loggedTime: now,
      status: MealLogStatus.alternative,
      alternativeMeal: alternativeMeal,
      notes: notes,
      createdAt: now,
    );

    await _repository.saveMealLog(log);
    notifyListeners();
  }

  Future<void> logMealAsSkipped({
    required String clientId,
    required String mealId,
    required DateTime loggedDate,
    String? notes,
  }) async {
    final now = TimeProvider.now();
    final log = MealLog(
      id: 'log_${now.millisecondsSinceEpoch}',
      clientId: clientId,
      mealId: mealId,
      loggedDate: DateUtils.getDateOnly(loggedDate),
      loggedTime: now,
      status: MealLogStatus.skipped,
      notes: notes,
      createdAt: now,
    );

    await _repository.saveMealLog(log);
    notifyListeners();
  }

  List<MealLog> getLogsForDate(DateTime date) {
    return _repository.getLogsForDate(date);
  }

  MealLog? getLogForMeal(String mealId, DateTime date) {
    return _repository.getLogForMeal(mealId, date);
  }

  bool hasLoggedMeal(String mealId, DateTime date) {
    return _repository.hasLoggedMeal(mealId, date);
  }

  List<MealLog> getLogsForDateRange(DateTime startDate, DateTime endDate) {
    return _repository.getLogsForDateRange(startDate, endDate);
  }
}
