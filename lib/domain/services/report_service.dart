import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../data/models/client.dart';
import '../../data/models/meal_log.dart';
import '../../data/repositories/meal_log_repository.dart';
import '../../data/repositories/meal_plan_repository.dart';
import '../../core/utils/adherence_utils.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/time_provider.dart';

class ReportService {
  final MealLogRepository mealLogRepository;
  final MealPlanRepository mealPlanRepository;

  ReportService({
    required this.mealLogRepository,
    required this.mealPlanRepository,
  });

  Future<Uint8List> generateProgressReport({
    required DateTime startDate,
    required DateTime endDate,
    required Client client,
  }) async {
    final pdf = pw.Document();
    final logs = mealLogRepository.getLogsForDateRange(startDate, endDate);
    var totalMeals = 0;
    var mealsFollowed = 0;
    var mealsWithAlternatives = 0;
    var mealsSkipped = 0;
    var dueMeals = 0;
    var unloggedDueMeals = 0;
    final now = TimeProvider.now();

    for (var date = DateUtils.getDateOnly(startDate);
        !date.isAfter(endDate);
        date = date.add(const Duration(days: 1))) {
      final dayMeals = mealPlanRepository.getMealsForDate(date);
      final dayLogs = logs
          .where((log) => DateUtils.isSameDay(log.loggedDate, date))
          .toList();

      totalMeals += dayMeals.length;
      mealsFollowed +=
          dayLogs.where((log) => log.status.name == 'followed').length;
      mealsWithAlternatives +=
          dayLogs.where((log) => log.status.name == 'alternative').length;
      mealsSkipped +=
          dayLogs.where((log) => log.status.name == 'skipped').length;

      final dailyAdherence = AdherenceUtils.evaluate(
        date: date,
        meals: dayMeals,
        logs: dayLogs,
        now: now,
      );
      dueMeals += dailyAdherence.dueMeals;
      unloggedDueMeals += dailyAdherence.unloggedDueMeals;
    }

    final adherencePercentage = dueMeals == 0
        ? 100.0
        : ((dueMeals - unloggedDueMeals) / dueMeals) * 100;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Progress Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Client: ${client.name}'),
              pw.Text('Email: ${client.email}'),
              pw.Text(
                'Period: ${DateUtils.formatDate(startDate)} - ${DateUtils.formatDate(endDate)}',
              ),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Summary',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Total Meals: $totalMeals'),
              pw.Text(
                  'Meals Followed: $mealsFollowed (${adherencePercentage.toStringAsFixed(1)}%)'),
              pw.Text('Alternative Meals: $mealsWithAlternatives'),
              pw.Text('Skipped Meals: $mealsSkipped'),
              pw.Text('Meals due so far: $dueMeals'),
              pw.Text('Unlogged meals due: $unloggedDueMeals'),
              pw.SizedBox(height: 20),
              pw.Text(
                'Daily Breakdown',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              ..._buildDailyBreakdown(logs, startDate, endDate),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  List<pw.Widget> _buildDailyBreakdown(
    List<MealLog> logs,
    DateTime startDate,
    DateTime endDate,
  ) {
    final widgets = <pw.Widget>[];

    for (var date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final dayLogs = logs
          .where((log) => DateUtils.isSameDay(log.loggedDate, date))
          .toList();

      if (dayLogs.isEmpty) continue;

      widgets.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              DateUtils.formatDate(date),
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 5),
            ...dayLogs.map(
              (log) => pw.Padding(
                padding: const pw.EdgeInsets.only(left: 20, bottom: 5),
                child: pw.Text(
                  '${DateUtils.formatTime(log.loggedTime)} - ${log.status.displayName}${log.notes != null ? ": ${log.notes}" : ""}',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ),
            ),
            pw.SizedBox(height: 10),
          ],
        ),
      );
    }

    return widgets;
  }
}
