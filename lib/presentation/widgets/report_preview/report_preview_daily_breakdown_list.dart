import 'package:flutter/material.dart';

import '../../../data/models/meal_log.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import 'report_preview_day_card.dart';

class ReportPreviewDailyBreakdownList extends StatelessWidget {
  final List<MealLog> logs;
  final DateTime startDate;
  final DateTime endDate;

  const ReportPreviewDailyBreakdownList({
    super.key,
    required this.logs,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var date = startDate;
        !date.isAfter(endDate);
        date = date.add(const Duration(days: 1))) {
      final dayLogs = logs
          .where((log) => date_utils.DateUtils.isSameDay(log.loggedDate, date))
          .toList();

      if (dayLogs.isEmpty) continue;

      widgets.add(
        ReportPreviewDayCard(
          key: ValueKey(date.toIso8601String()),
          date: date,
          logs: dayLogs,
        ),
      );
    }

    return Column(children: widgets);
  }
}
