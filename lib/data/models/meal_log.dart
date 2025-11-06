import 'meal_log_status.dart';

class MealLog {
  final String id;
  final String clientId;
  final String mealId;
  final DateTime loggedDate;
  final DateTime loggedTime;
  final MealLogStatus status;
  final String? alternativeMeal;
  final String? notes;
  final DateTime createdAt;

  const MealLog({
    required this.id,
    required this.clientId,
    required this.mealId,
    required this.loggedDate,
    required this.loggedTime,
    required this.status,
    this.alternativeMeal,
    this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'meal_id': mealId,
      'logged_date': loggedDate.toIso8601String(),
      'logged_time': loggedTime.toIso8601String(),
      'status': status.name,
      'alternative_meal': alternativeMeal,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory MealLog.fromJson(Map<String, dynamic> json) {
    return MealLog(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      mealId: json['meal_id'] as String,
      loggedDate: DateTime.parse(json['logged_date'] as String),
      loggedTime: DateTime.parse(json['logged_time'] as String),
      status: MealLogStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      alternativeMeal: json['alternative_meal'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

