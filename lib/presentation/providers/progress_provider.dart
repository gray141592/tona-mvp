import 'package:flutter/foundation.dart';
import '../../data/models/weekly_progress.dart';
import '../../data/models/daily_progress.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/time_provider.dart';
import '../../domain/services/progress_service.dart';

class ProgressProvider extends ChangeNotifier {
  final ProgressService _service;

  ProgressProvider(this._service);

  DailyProgress getDailyProgress(DateTime date) {
    return _service.calculateDailyProgress(date);
  }

  WeeklyProgress getWeeklyProgress(DateTime weekStart) {
    return _service.calculateWeeklyProgress(weekStart);
  }

  WeeklyProgress getCurrentWeekProgress() {
    final weekStart = DateUtils.getWeekStart(TimeProvider.now());
    return getWeeklyProgress(weekStart);
  }

  void refresh() {
    notifyListeners();
  }
}
