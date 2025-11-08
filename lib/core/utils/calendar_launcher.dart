import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/consultation_appointment.dart';

class CalendarLauncher {
  static Future<void> addToCalendar(ConsultationAppointment appointment) async {
    final start = appointment.scheduledAt.toUtc();
    final end = start.add(const Duration(hours: 1));

    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS)) {
      await _launchAppleCalendar(appointment, start, end);
      return;
    }

    // Default to Google Calendar compatible link for Android, web, and other platforms.
    await _launchGoogleCalendar(appointment, start, end);
  }

  static Future<void> _launchAppleCalendar(
    ConsultationAppointment appointment,
    DateTime startUtc,
    DateTime endUtc,
  ) async {
    final formatter = DateFormat("yyyyMMdd'T'HHmmss'Z'");
    final buffer = StringBuffer()
      ..writeln('BEGIN:VCALENDAR')
      ..writeln('VERSION:2.0')
      ..writeln('BEGIN:VEVENT')
      ..writeln('DTSTAMP:${formatter.format(DateTime.now().toUtc())}')
      ..writeln('DTSTART:${formatter.format(startUtc)}')
      ..writeln('DTEND:${formatter.format(endUtc)}')
      ..writeln('SUMMARY:${_escapeText(_buildSummary(appointment))}')
      ..writeln('DESCRIPTION:${_escapeText(_buildDescription(appointment))}')
      ..writeln('END:VEVENT')
      ..writeln('END:VCALENDAR');

    final uri = Uri.dataFromString(
      buffer.toString(),
      mimeType: 'text/calendar',
      encoding: utf8,
    );

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw Exception('Unable to open Apple Calendar');
    }
  }

  static Future<void> _launchGoogleCalendar(
    ConsultationAppointment appointment,
    DateTime startUtc,
    DateTime endUtc,
  ) async {
    final formatter = DateFormat("yyyyMMdd'T'HHmmss'Z'");
    final summary = _buildSummary(appointment);
    final details = _buildDescription(appointment);

    final params = <String, String>{
      'action': 'TEMPLATE',
      'text': summary,
      'details': details,
      'dates': '${formatter.format(startUtc)}/${formatter.format(endUtc)}',
    };

    final uri = Uri.https('calendar.google.com', '/calendar/render', params);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw Exception('Unable to open Google Calendar');
    }
  }

  static String _buildSummary(ConsultationAppointment appointment) {
    return 'Consultation with ${appointment.nutritionistName}';
  }

  static String _buildDescription(ConsultationAppointment appointment) {
    final buffer = StringBuffer('Format: ${appointment.meetingFormat}');
    if (appointment.location != null && appointment.location!.isNotEmpty) {
      buffer.writeln();
      buffer.write('Location: ${appointment.location}');
    }
    if (appointment.meetingLink != null &&
        appointment.meetingLink!.isNotEmpty) {
      buffer.writeln();
      buffer.write('Link: ${appointment.meetingLink}');
    }
    if (appointment.focusAreas.isNotEmpty) {
      buffer.writeln();
      buffer.write('Focus areas: ${appointment.focusAreas.join(', ')}');
    }
    if (appointment.preparationNotes.isNotEmpty) {
      buffer.writeln();
      buffer.write('Preparation: ${appointment.preparationNotes.join(', ')}');
    }
    return buffer.toString();
  }

  static String _escapeText(String value) {
    return value
        .replaceAll('\\', '\\\\')
        .replaceAll(';', '\\;')
        .replaceAll(',', '\\,')
        .replaceAll('\n', '\\n');
  }
}
