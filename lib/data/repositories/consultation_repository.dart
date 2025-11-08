import '../models/consultation_appointment.dart';

class ConsultationRepository {
  List<ConsultationAppointment> _appointments = [];
  final Set<String> _scheduledAppointmentIds = {};
  final Set<String> _reportPreparedAppointmentIds = {};

  void setAppointments(List<ConsultationAppointment> appointments) {
    _appointments = [...appointments]
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
  }

  List<ConsultationAppointment> getAppointments() {
    return List.unmodifiable(_appointments);
  }

  ConsultationAppointment? getAppointmentById(String id) {
    try {
      return _appointments.firstWhere((appointment) => appointment.id == id);
    } catch (_) {
      return null;
    }
  }

  void markAddedToSchedule(String appointmentId) {
    _scheduledAppointmentIds.add(appointmentId);
  }

  bool isAddedToSchedule(String appointmentId) {
    return _scheduledAppointmentIds.contains(appointmentId);
  }

  void markReportPrepared(String appointmentId) {
    _reportPreparedAppointmentIds.add(appointmentId);
  }

  bool hasPreparedReport(String appointmentId) {
    return _reportPreparedAppointmentIds.contains(appointmentId);
  }

  void upsertAppointment(ConsultationAppointment appointment) {
    final index =
        _appointments.indexWhere((existing) => existing.id == appointment.id);
    if (index == -1) {
      _appointments = [..._appointments, appointment]
        ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    } else {
      final updated = [..._appointments];
      updated[index] = appointment;
      updated.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
      _appointments = updated;
    }
  }
}
