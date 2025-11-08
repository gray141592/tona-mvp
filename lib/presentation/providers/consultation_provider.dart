import 'package:flutter/foundation.dart';

import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/utils/time_provider.dart';
import '../../data/models/consultation_appointment.dart';
import '../../data/models/meal_plan.dart';
import '../../data/repositories/consultation_repository.dart';

class ConsultationProvider extends ChangeNotifier {
  ConsultationProvider(this._repository);

  final ConsultationRepository _repository;

  List<ConsultationAppointment> get appointments =>
      _repository.getAppointments();

  void loadAppointments(List<ConsultationAppointment> appointments) {
    _repository.setAppointments(appointments);
    notifyListeners();
  }

  ConsultationAppointment? getAppointmentById(String id) {
    return _repository.getAppointmentById(id);
  }

  ConsultationAppointment? getNextAppointment() {
    final now = TimeProvider.now();
    for (final appointment in appointments) {
      if (appointment.scheduledAt.isAfter(now)) {
        return appointment;
      }
    }
    return null;
  }

  ConsultationAppointment? getLastAppointment() {
    final now = TimeProvider.now();
    final pastAppointments = appointments
        .where((appointment) => !appointment.scheduledAt.isAfter(now))
        .toList()
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
    if (pastAppointments.isEmpty) {
      return null;
    }
    return pastAppointments.first;
  }

  List<ConsultationAppointment> getPastAppointments() {
    final now = TimeProvider.now();
    return appointments
        .where((appointment) => !appointment.scheduledAt.isAfter(now))
        .toList()
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
  }

  bool isAddedToSchedule(String appointmentId) {
    return _repository.isAddedToSchedule(appointmentId);
  }

  void markAddedToSchedule(String appointmentId) {
    _repository.markAddedToSchedule(appointmentId);
    notifyListeners();
  }

  bool hasPreparedReport(String appointmentId) {
    return _repository.hasPreparedReport(appointmentId);
  }

  void markReportPrepared(String appointmentId) {
    _repository.markReportPrepared(appointmentId);
    notifyListeners();
  }

  void attachMealPlanToAppointment({
    required String appointmentId,
    required MealPlan mealPlan,
    DateTime? effectiveFrom,
    DateTime? effectiveUntil,
    List<String>? highlights,
  }) {
    final appointment = getAppointmentById(appointmentId);
    if (appointment == null) {
      return;
    }

    final existingOutcome = appointment.outcome;
    final snapshot = ConsultationMealPlanSummary(
      planId: mealPlan.id,
      title: mealPlan.name,
      effectiveFrom: effectiveFrom ?? mealPlan.startDate,
      effectiveUntil: effectiveUntil ?? mealPlan.endDate,
      highlights: highlights ?? _buildHighlights(mealPlan),
      plan: mealPlan,
    );

    final updatedOutcome = (existingOutcome ??
            const ConsultationOutcome(summary: 'Nutritionist follow-up notes'))
        .copyWith(mealPlan: snapshot);

    final updatedAppointment = appointment.copyWith(
      outcome: updatedOutcome,
      linkedMealPlan: mealPlan,
    );

    _repository.upsertAppointment(updatedAppointment);
    notifyListeners();
  }

  void scheduleAppointment({
    required DateTime scheduledAt,
    required String nutritionistName,
    required String meetingFormat,
    String? location,
    String? meetingLink,
    List<String> preparationNotes = const [],
  }) {
    final appointmentId =
        'consult_${scheduledAt.millisecondsSinceEpoch.toString()}';

    final appointment = ConsultationAppointment(
      id: appointmentId,
      scheduledAt: scheduledAt,
      nutritionistName: nutritionistName,
      meetingFormat: meetingFormat,
      location: location,
      meetingLink: meetingLink,
      focusAreas: const [],
      preparationNotes: preparationNotes,
    );

    _repository.upsertAppointment(appointment);
    notifyListeners();
  }

  void updateNotes({
    required String appointmentId,
    required String? notes,
  }) {
    final appointment = getAppointmentById(appointmentId);
    if (appointment == null) {
      return;
    }

    final updated = appointment.copyWith(notes: notes);
    _repository.upsertAppointment(updated);
    notifyListeners();
  }

  void updateFocusAreas({
    required String appointmentId,
    required List<String> focusAreas,
  }) {
    final appointment = getAppointmentById(appointmentId);
    if (appointment == null) {
      return;
    }

    final updated = appointment.copyWith(focusAreas: focusAreas);
    _repository.upsertAppointment(updated);
    notifyListeners();
  }

  void updateAppointment({
    required String appointmentId,
    DateTime? scheduledAt,
    String? nutritionistName,
    String? meetingFormat,
    String? location,
    String? meetingLink,
    List<String>? preparationNotes,
  }) {
    final appointment = getAppointmentById(appointmentId);
    if (appointment == null) {
      return;
    }

    if (appointment.hasUploadedFollowUpPlan) {
      return;
    }

    final updated = appointment.copyWith(
      scheduledAt: scheduledAt,
      nutritionistName: nutritionistName,
      meetingFormat: meetingFormat,
      location: location,
      meetingLink: meetingLink,
      preparationNotes: preparationNotes ?? appointment.preparationNotes,
    );
    _repository.upsertAppointment(updated);
    notifyListeners();
  }

  void rescheduleAppointment({
    required String appointmentId,
    required DateTime newDateTime,
  }) {
    updateAppointment(
      appointmentId: appointmentId,
      scheduledAt: newDateTime,
    );
  }

  void markFollowUpPlanUploaded(String appointmentId) {
    final appointment = getAppointmentById(appointmentId);
    if (appointment == null) {
      return;
    }

    final updated = appointment.copyWith(hasUploadedFollowUpPlan: true);
    _repository.upsertAppointment(updated);
    notifyListeners();
  }

  void clearFollowUpPlanFlag(String appointmentId) {
    final appointment = getAppointmentById(appointmentId);
    if (appointment == null) {
      return;
    }

    final updated = appointment.copyWith(hasUploadedFollowUpPlan: false);
    _repository.upsertAppointment(updated);
    notifyListeners();
  }

  bool hasUploadedFollowUpPlan(String appointmentId) {
    final appointment = getAppointmentById(appointmentId);
    return appointment?.hasUploadedFollowUpPlan ?? false;
  }

  List<String> _buildHighlights(MealPlan mealPlan) {
    final period =
        'Effective ${date_utils.DateUtils.formatDate(mealPlan.startDate)}'
        ' – ${date_utils.DateUtils.formatDate(mealPlan.endDate)}';
    final mealCoverage =
        'Covers ${mealPlan.meals.length} planned meals across the week';
    final sampleMeals =
        mealPlan.meals.take(3).map((meal) => meal.name).toList();
    final sampleSummary = sampleMeals.isNotEmpty
        ? 'Sample meals: ${sampleMeals.join(', ')}'
        : null;

    return [
      period,
      mealCoverage,
      if (sampleSummary != null) sampleSummary,
    ];
  }
}
