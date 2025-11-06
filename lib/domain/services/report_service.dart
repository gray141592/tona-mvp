import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../data/models/client.dart';
import '../../data/models/meal_log.dart';
import '../../data/repositories/meal_log_repository.dart';
import '../../data/repositories/meal_plan_repository.dart';
import '../../core/utils/date_utils.dart';

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
    final meals = mealPlanRepository.getMealsForWeek(
      DateUtils.getWeekStart(startDate),
      DateUtils.getWeekEnd(endDate),
    );
    
    final totalMeals = meals.length;
    final mealsFollowed = logs.where(
      (log) => log.status.name == 'followed',
    ).length;
    final mealsWithAlternatives = logs.where(
      (log) => log.status.name == 'alternative',
    ).length;
    final adherencePercentage = totalMeals > 0
        ? (mealsFollowed / totalMeals) * 100
        : 0.0;

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
              pw.Text('Meals Followed: $mealsFollowed (${adherencePercentage.toStringAsFixed(1)}%)'),
              pw.Text('Alternative Meals: $mealsWithAlternatives'),
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
      final dayLogs = logs.where((log) => DateUtils.isSameDay(log.loggedDate, date)).toList();
      
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
            ...dayLogs.map((log) => pw.Padding(
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

