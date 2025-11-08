import 'meal_plan.dart';

class ConsultationAppointment {
  const ConsultationAppointment({
    required this.id,
    required this.scheduledAt,
    required this.nutritionistName,
    required this.meetingFormat,
    this.location,
    this.meetingLink,
    this.focusAreas = const [],
    this.preparationNotes = const [],
    this.outcome,
    this.linkedMealPlan,
    this.notes,
    this.hasUploadedFollowUpPlan = false,
  });

  final String id;
  final DateTime scheduledAt;
  final String nutritionistName;
  final String meetingFormat;
  final String? location;
  final String? meetingLink;
  final List<String> focusAreas;
  final List<String> preparationNotes;
  final ConsultationOutcome? outcome;
  final MealPlan? linkedMealPlan;
  final String? notes;
  final bool hasUploadedFollowUpPlan;

  bool get hasOutcome => outcome != null;

  ConsultationAppointment copyWith({
    DateTime? scheduledAt,
    String? nutritionistName,
    String? meetingFormat,
    String? location,
    String? meetingLink,
    List<String>? focusAreas,
    List<String>? preparationNotes,
    ConsultationOutcome? outcome,
    MealPlan? linkedMealPlan,
    String? notes,
    bool? hasUploadedFollowUpPlan,
  }) {
    return ConsultationAppointment(
      id: id,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      nutritionistName: nutritionistName ?? this.nutritionistName,
      meetingFormat: meetingFormat ?? this.meetingFormat,
      location: location ?? this.location,
      meetingLink: meetingLink ?? this.meetingLink,
      focusAreas: focusAreas ?? this.focusAreas,
      preparationNotes: preparationNotes ?? this.preparationNotes,
      outcome: outcome ?? this.outcome,
      linkedMealPlan: linkedMealPlan ?? this.linkedMealPlan,
      notes: notes ?? this.notes,
      hasUploadedFollowUpPlan:
          hasUploadedFollowUpPlan ?? this.hasUploadedFollowUpPlan,
    );
  }
}

class ConsultationOutcome {
  const ConsultationOutcome({
    required this.summary,
    this.mealPlan,
    this.report,
    this.actionItems = const [],
  });

  final String summary;
  final ConsultationMealPlanSummary? mealPlan;
  final ConsultationReportSummary? report;
  final List<String> actionItems;

  ConsultationOutcome copyWith({
    String? summary,
    ConsultationMealPlanSummary? mealPlan,
    ConsultationReportSummary? report,
    List<String>? actionItems,
  }) {
    return ConsultationOutcome(
      summary: summary ?? this.summary,
      mealPlan: mealPlan ?? this.mealPlan,
      report: report ?? this.report,
      actionItems: actionItems ?? this.actionItems,
    );
  }
}

class ConsultationMealPlanSummary {
  const ConsultationMealPlanSummary({
    required this.planId,
    required this.title,
    required this.effectiveFrom,
    this.effectiveUntil,
    this.highlights = const [],
    this.plan,
  });

  final String planId;
  final String title;
  final DateTime effectiveFrom;
  final DateTime? effectiveUntil;
  final List<String> highlights;
  final MealPlan? plan;

  ConsultationMealPlanSummary copyWith({
    String? planId,
    String? title,
    DateTime? effectiveFrom,
    DateTime? effectiveUntil,
    List<String>? highlights,
    MealPlan? plan,
  }) {
    return ConsultationMealPlanSummary(
      planId: planId ?? this.planId,
      title: title ?? this.title,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveUntil: effectiveUntil ?? this.effectiveUntil,
      highlights: highlights ?? this.highlights,
      plan: plan ?? this.plan,
    );
  }
}

class ConsultationReportSummary {
  const ConsultationReportSummary({
    required this.id,
    required this.title,
    required this.generatedAt,
    required this.description,
    this.downloadUrl,
  });

  final String id;
  final String title;
  final DateTime generatedAt;
  final String description;
  final String? downloadUrl;

  ConsultationReportSummary copyWith({
    String? id,
    String? title,
    DateTime? generatedAt,
    String? description,
    String? downloadUrl,
  }) {
    return ConsultationReportSummary(
      id: id ?? this.id,
      title: title ?? this.title,
      generatedAt: generatedAt ?? this.generatedAt,
      description: description ?? this.description,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }
}
