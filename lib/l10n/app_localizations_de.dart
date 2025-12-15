// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tona';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get serbian => 'Serbisch';

  @override
  String get resetOnboarding => 'Onboarding zurücksetzen';

  @override
  String get resetSwipeCoach => 'Swipe Coach zurücksetzen';

  @override
  String get changeTime => 'App-Zeit ändern';

  @override
  String get consultationNotes => 'Beratungsnotizen';

  @override
  String get consultationNotFound => 'Beratung nicht gefunden';

  @override
  String get reschedule => 'Neu planen';

  @override
  String get reschedulingDisabled =>
      'Neuplanung nach dem Hochladen eines Folgespeiseplans deaktiviert.';

  @override
  String get openPreparedReport => 'Vorbereiteten Bericht öffnen';

  @override
  String get myNotes => 'Meine Notizen';

  @override
  String get myNotesHint => 'Erkenntnisse, Anpassungen, Fragen erfassen…';

  @override
  String get focusAreas => 'Fokusbereiche';

  @override
  String get focusAreasHint => 'Einer pro Zeile (z.B. Pre-Workout-Betankung)';

  @override
  String get afterTheVisit => 'Nach dem Besuch';

  @override
  String get mealPlanUploaded => 'Speiseplan hochgeladen';

  @override
  String get uploadNewMealPlan => 'Neuen Speiseplan hochladen';

  @override
  String get viewLinkedMealPlan => 'Verknüpften Speiseplan ansehen';

  @override
  String get viewReport => 'Bericht ansehen';

  @override
  String consultationMoved(String date, String time) {
    return 'Beratung verschoben auf $date um $time.';
  }

  @override
  String get mealPlanUploadedAndLinked =>
      'Speiseplan hochgeladen und verknüpft';

  @override
  String get noReportAvailableYet => 'Noch kein Bericht verfügbar';

  @override
  String get resetSwipeCoachMessage =>
      'Swipe-Coach-Hinweis wurde zurückgesetzt.';

  @override
  String get changeTimeMessage => 'Die Zeit wurde geändert.';

  @override
  String get alreadyOnYourCalendar => 'Bereits in deinem Kalender';

  @override
  String get calendarUnavailable => 'Kalender nicht verfügbar';

  @override
  String addedToCalendar(String date) {
    return 'Zum Kalender für $date hinzugefügt';
  }

  @override
  String preparingForConsultation(String date) {
    return 'Vorbereitung auf die Beratung am $date';
  }

  @override
  String get yourNutritionist => 'Dein Ernährungsberater';

  @override
  String consultationScheduledFor(String date) {
    return 'Beratung geplant für $date.';
  }

  @override
  String get noMealPlanLoaded => 'Noch kein Speiseplan zum Verknüpfen geladen.';

  @override
  String linkedMealPlanToConsultation(String mealPlanName, String date) {
    return '$mealPlanName mit Beratung am $date verknüpft.';
  }

  @override
  String get noMealPlanLinked => 'Noch kein Speiseplan verknüpft';

  @override
  String get consultations => 'Beratungen';

  @override
  String get consultationsSubtitle =>
      'Bleiben Sie mit Ihrem Ernährungsberater auf einer Linie';

  @override
  String get scheduleConsultation => 'Beratung planen';

  @override
  String get noConsultationsYet => 'Noch keine Beratungen';

  @override
  String get noConsultationsYetBody =>
      'Laden Sie einen Speiseplan hoch oder verbinden Sie sich mit Ihrem Ernährungsberater, um bevorstehende Termine zu sehen.';

  @override
  String get uploadMealPlan => 'Speiseplan hochladen';

  @override
  String get glycemicIndexQuickGuide => 'Kurzanleitung zum glykämischen Index';

  @override
  String get glycemicIndexQuickGuideBody =>
      'Verwenden Sie diese Anleitung, um zu entscheiden, ob eine Mahlzeit den Blutzuckerspiegel in die Höhe treibt.';

  @override
  String get gotIt => 'Verstanden';

  @override
  String get mealMarkedAsSkipped => 'Mahlzeit als übersprungen markiert';

  @override
  String get unplannedMealLogged => 'Ungeplante Mahlzeit protokolliert';

  @override
  String get newMealPlanProcessed =>
      'Großartig! Der neue Speiseplan wird bearbeitet und mit Ihrer Beratung verknüpft.';

  @override
  String get uploadMealPlanToGetStarted =>
      'Laden Sie einen Speiseplan hoch, um loszulegen';

  @override
  String mealLoggedSuccess(String mealName) {
    return 'Weiter so! $mealName ist protokolliert.';
  }

  @override
  String alternativeLoggedSuccess(String mealName) {
    return 'Gute Entscheidung. Ihre Alternative zu $mealName ist protokolliert.';
  }

  @override
  String get groceriesNeedMealPlan =>
      'Du benötigst einen Speiseplan, um eine Einkaufsliste zu erstellen.';

  @override
  String get groceriesNoItemsFound =>
      'Für die ausgewählten Tage wurden keine Lebensmittel gefunden.';

  @override
  String groceriesConversionError(String preview, String suffix) {
    return 'Einige Artikel konnten nicht in Gramm umgerechnet werden: $preview$suffix.';
  }

  @override
  String get groceriesAddCustomItem => 'Benutzerdefinierten Artikel hinzufügen';

  @override
  String get groceriesIngredientName => 'Zutatenname';

  @override
  String get groceriesIngredientNameHint => 'z.B. Extra-Bananen';

  @override
  String get groceriesIngredientNameError =>
      'Bitte geben Sie einen Zutatenamen ein';

  @override
  String get groceriesQuantityGrams => 'Menge (Gramm)';

  @override
  String get groceriesQuantityGramsHint => 'z.B. 250';

  @override
  String get groceriesQuantityGramsError =>
      'Bitte geben Sie eine Menge in Gramm ein';

  @override
  String get groceriesPositiveNumberError => 'Geben Sie eine positive Zahl ein';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get groceriesNoItemsToShare => 'Keine Artikel zum Teilen.';

  @override
  String get groceriesList => 'Einkaufsliste';

  @override
  String groceriesShoppingForDays(int days) {
    return 'Einkauf für $days Tag(e)';
  }

  @override
  String groceriesGeneratedOn(String date) {
    return 'Erstellt am $date';
  }

  @override
  String groceriesShareError(String error) {
    return 'Einkaufsliste konnte nicht geteilt werden: $error';
  }

  @override
  String get groceriesTitle => 'Einkaufsliste';

  @override
  String groceriesSubtitle(int days) {
    return 'Einkauf für $days Tag(e)';
  }

  @override
  String get groceriesStep1Title => 'Planungsfenster auswählen';

  @override
  String get groceriesStep1Subtitle =>
      'Für wie viele Tage kaufen Sie Mahlzeiten ein?';

  @override
  String get groceriesGenerateButton => 'Einkaufsliste erstellen';

  @override
  String get groceriesStep2Title => 'Überprüfen und anpassen';

  @override
  String get groceriesStep2Subtitle =>
      'Entfernen Sie alles, was Sie bereits haben, und fügen Sie zusätzliche Artikel hinzu.';

  @override
  String get groceriesGeneratedListPlaceholder =>
      'Ihre generierte Liste wird hier angezeigt. Tippen Sie auf die Schaltfläche oben, nachdem Sie ausgewählt haben, für wie viele Tage Sie einkaufen möchten.';

  @override
  String get groceriesAddCustomItemButton =>
      'Benutzerdefinierten Artikel hinzufügen';

  @override
  String get groceriesStep3Title => 'Teile deine Liste';

  @override
  String get groceriesStep3Subtitle =>
      'Senden Sie es an Ihr Telefon, einen Trainer oder jeden, der beim Einkaufen hilft.';

  @override
  String get groceriesShareButton => 'Einkaufsliste teilen';

  @override
  String get groceriesRemoveItem => 'Artikel entfernen';

  @override
  String get groceriesCustom => 'benutzerdefiniert';

  @override
  String get groceriesEstimated => 'geschätzt';

  @override
  String groceriesDays(int days) {
    return '$days Tage';
  }

  @override
  String get groceriesCustomRange =>
      'Oder einen benutzerdefinierten Bereich festlegen';

  @override
  String groceriesDayRange(int days) {
    return '$days Tag(e)';
  }

  @override
  String get mealPlanOverviewTitle => 'Speiseplanübersicht';

  @override
  String get noMealPlanAvailable => 'Kein Speiseplan verfügbar';

  @override
  String get noMealsScheduled => 'Keine Mahlzeiten geplant';

  @override
  String get day_monday => 'Montag';

  @override
  String get day_tuesday => 'Dienstag';

  @override
  String get day_wednesday => 'Mittwoch';

  @override
  String get day_thursday => 'Donnerstag';

  @override
  String get day_friday => 'Freitag';

  @override
  String get day_saturday => 'Samstag';

  @override
  String get day_sunday => 'Sonntag';

  @override
  String get mealPlanProcessing_title => 'Dein Plan wird vorbereitet';

  @override
  String get mealPlanProcessing_stageUploading_title =>
      'Dein Plan wird hochgeladen';

  @override
  String get mealPlanProcessing_stageUploading_subtitle =>
      'Sicheres Senden an IRresistible-Server';

  @override
  String get mealPlanProcessing_stageAnalyzing_title =>
      'Details werden analysiert';

  @override
  String get mealPlanProcessing_stageAnalyzing_subtitle =>
      'Ernährungsziele werden verstanden';

  @override
  String get mealPlanProcessing_stageExtracting_title =>
      'Mahlzeiten werden extrahiert';

  @override
  String get mealPlanProcessing_stageExtracting_subtitle =>
      'Mahlzeiten und Nahrungsergänzungsmittel werden erfasst';

  @override
  String get mealPlanProcessing_stageFinalizing_title => 'Letzte Handgriffe';

  @override
  String get mealPlanProcessing_stageFinalizing_subtitle =>
      'Die IRresistible-Struktur wird angewendet';

  @override
  String mealPlanProcessing_progress(String progress) {
    return 'Fortschritt $progress';
  }

  @override
  String get mealPlanProcessing_cancel =>
      'Abbrechen und eine andere Datei auswählen';

  @override
  String get mealPlanReview_title => 'Speiseplan überprüfen';

  @override
  String get mealPlanReview_changeFile => 'Datei ändern';

  @override
  String get mealPlanReview_confirmPlan => 'Plan bestätigen';
}
