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

  @override
  String get menuProgress => 'Fortschritt';

  @override
  String get dashboardMenu_closeMenu => 'Menü schließen';

  @override
  String get glycemicInfo_lowTitle => 'Niedriger GI (0-55)';

  @override
  String get glycemicInfo_lowDesc =>
      'Stetige Energie, am besten für einen ausgeglichenen Blutzuckerspiegel.';

  @override
  String get glycemicInfo_lowExample1 =>
      'Blattgemüse, nicht stärkehaltiges Gemüse';

  @override
  String get glycemicInfo_lowExample2 => 'Bohnen, Linsen, Kichererbsen';

  @override
  String get glycemicInfo_lowExample3 =>
      'Vollkornprodukte wie Gerste oder Quinoa';

  @override
  String get glycemicInfo_mediumTitle => 'Mittlerer GI (56-69)';

  @override
  String get glycemicInfo_mediumDesc =>
      'Mäßiger Einfluss, Ausgleich mit Protein oder gesunden Fetten.';

  @override
  String get glycemicInfo_mediumExample1 => 'Vollkornbrot, Haferflocken';

  @override
  String get glycemicInfo_mediumExample2 => 'Zuckermais, Süßkartoffeln';

  @override
  String get glycemicInfo_mediumExample3 =>
      'Tropische Früchte wie Ananas oder Mango';

  @override
  String get glycemicInfo_highTitle => 'Hoher GI (70+)';

  @override
  String get glycemicInfo_highDesc =>
      'Lässt den Blutzucker schnell ansteigen; wenn möglich begrenzen.';

  @override
  String get glycemicInfo_highExample1 => 'Weißbrot, Bagels, Brezeln';

  @override
  String get glycemicInfo_highExample2 =>
      'Zuckerhaltiges Müsli, Süßigkeiten, Gebäck';

  @override
  String get glycemicInfo_highExample3 =>
      'Weißer Reis, Pommes frites, verarbeitete Snacks';

  @override
  String get swipeCoach_followedPlan => 'Plan gefolgt';

  @override
  String get swipeCoach_skippedMeal => 'Mahlzeit übersprungen';

  @override
  String get quickActions_groceriesTitle => 'Lebensmittel';

  @override
  String get quickActions_groceriesSubtitle => 'Liste erstellen';

  @override
  String get quickActions_addUnplannedTitle => 'Ungeplante Mahlzeit';

  @override
  String get quickActions_addUnplannedSubtitle => 'Mahlzeit protokollieren';

  @override
  String get alternativeMeal_addUnplannedTitle =>
      'Ungeplante Mahlzeit hinzufügen';

  @override
  String get alternativeMeal_logAlternativeTitle =>
      'Alternative protokollieren';

  @override
  String get alternativeMeal_whatDidYouEat => 'Was hast du gegessen?';

  @override
  String get alternativeMeal_whatDidYouEatInstead =>
      'Was hast du stattdessen gegessen?';

  @override
  String get alternativeMeal_describeMeal => 'Beschreibe die Mahlzeit...';

  @override
  String get alternativeMeal_describeMealHad =>
      'Beschreibe die Mahlzeit, die du hattest...';

  @override
  String get alternativeMeal_validationError =>
      'Bitte gib eine kurze Beschreibung an';

  @override
  String get alternativeMeal_notesOptional => 'Notizen (optional)';

  @override
  String get alternativeMeal_bloodSugarImpact => 'Blutzucker-Auswirkung';

  @override
  String get alternativeMeal_containsSugar => 'Enthält zugesetzten Zucker';

  @override
  String get alternativeMeal_containsSugarSubtitle =>
      'Markiere, wenn die Mahlzeit raffinierten Zucker oder süße Sirupe enthält.';

  @override
  String get alternativeMeal_highGI => 'Hoher glykämischer Index';

  @override
  String get alternativeMeal_highGISubtitle =>
      'Wähle aus, wenn die Mahlzeit wahrscheinlich einen starken Blutzuckeranstieg verursacht.';

  @override
  String get alternativeMeal_saveMeal => 'Mahlzeit speichern';

  @override
  String get alternativeMeal_saveAlternative => 'Alternative speichern';

  @override
  String get alternativeMeal_saving => 'Speichern...';

  @override
  String get consultationSchedule_title => 'Beratung planen';

  @override
  String get consultationSchedule_nutritionistName =>
      'Name des Ernährungsberaters';

  @override
  String get consultationSchedule_selectDate => 'Datum auswählen';

  @override
  String get consultationSchedule_selectTime => 'Zeit auswählen';

  @override
  String get consultationSchedule_videoCall => 'Videoanruf';

  @override
  String get consultationSchedule_inPerson => 'Persönlich';

  @override
  String get consultationSchedule_phone => 'Telefon';

  @override
  String get consultationSchedule_format => 'Format';

  @override
  String get consultationSchedule_location => 'Ort';

  @override
  String get consultationSchedule_meetingLink => 'Meeting-Link';

  @override
  String get consultationSchedule_prepNotes =>
      'Vorbereitungsnotizen (durch Komma getrennt)';

  @override
  String get consultationSchedule_saveButton => 'Termin speichern';

  @override
  String get consultationCard_mealPlanInEffect => 'Speiseplan aktiv';

  @override
  String get consultationCard_focusAreas => 'Fokusbereiche';

  @override
  String get consultationCard_preparation => 'Vorbereitung';

  @override
  String get consultationCard_happeningNow => 'Findet jetzt statt';

  @override
  String consultationCard_inDays(int count) {
    return 'In $count Tagen';
  }

  @override
  String get consultationCard_inDay => 'In 1 Tag';

  @override
  String consultationCard_inHours(int count) {
    return 'In $count Stunden';
  }

  @override
  String get consultationCard_inHour => 'In 1 Stunde';

  @override
  String consultationCard_inMinutes(int count) {
    return 'In $count Minuten';
  }

  @override
  String get consultationCard_inMinute => 'In 1 Minute';

  @override
  String consultationCard_daysAgo(int count) {
    return 'Vor $count Tagen';
  }

  @override
  String get consultationCard_dayAgo => 'Vor 1 Tag';

  @override
  String consultationCard_hoursAgo(int count) {
    return 'Vor $count Stunden';
  }

  @override
  String get consultationCard_hourAgo => 'Vor 1 Stunde';

  @override
  String consultationCard_minutesAgo(int count) {
    return 'Vor $count Minuten';
  }

  @override
  String get consultationCard_minuteAgo => 'Vor 1 Minute';

  @override
  String get consultationOverview_upcoming => 'Bevorstehend';

  @override
  String get consultationOverview_nextAppointment => 'Nächster Termin';

  @override
  String get consultationOverview_addedToSchedule => 'Zum Zeitplan hinzugefügt';

  @override
  String get consultationOverview_addToSchedule => 'Zum Zeitplan hinzufügen';

  @override
  String get consultationOverview_prepareReport => 'Bericht vorbereiten';

  @override
  String get consultationOverview_mostRecent => 'Letzter Besuch';

  @override
  String get consultationOverview_lastAppointment => 'Letzter Termin';

  @override
  String get consultationOverview_linkMealPlan =>
      'Aktuellen Speiseplan verknüpfen';

  @override
  String get consultationOverview_viewMealPlan => 'Speiseplan ansehen';

  @override
  String get consultationHistory_title => 'Verlauf';

  @override
  String get consultationHistory_consultationPrefix => 'Beratung';

  @override
  String get consultationFollowup_title => 'Wie ist es gelaufen?';

  @override
  String consultationFollowup_subtitle(String date) {
    return 'Deine Beratung am $date hat möglicherweise deinen Speiseplan aktualisiert.';
  }

  @override
  String get consultationFollowup_body =>
      'Wenn du einen neuen Speiseplan oder Änderungen erhalten hast, kannst du diese jetzt hochladen, damit wir deinen Zeitplan sofort anpassen können.';

  @override
  String get consultationFollowup_highlights => 'Highlights';

  @override
  String get consultationFollowup_uploadNewPlan => 'Neuen Plan hochladen';

  @override
  String get consultationFollowup_reviewNotes => 'Notizen überprüfen';

  @override
  String get consultationReminder_title => 'Beratung steht an';

  @override
  String consultationReminder_body(String name) {
    return 'Bereite deine Notizen vor, damit $name die neuesten Erkenntnisse hat. Wenn du jetzt einen Bericht erstellst, ist alles bereit für die gemeinsame Durchsicht.';
  }

  @override
  String get consultationReminder_viewAgenda => 'Agenda ansehen';

  @override
  String get consultationReminder_happeningSoon => 'Findet bald statt';

  @override
  String get consultationReminder_tomorrow => 'Morgen';

  @override
  String get openReport => 'Bericht öffnen';

  @override
  String get report_followed => 'Gefolgt';

  @override
  String get report_alternatives => 'Alternativen';

  @override
  String get report_skipped => 'Übersprungen';

  @override
  String get report_totalLogs => 'Gesamtprotokolle';

  @override
  String get report_snapshotSummary => 'Momentaufnahme';

  @override
  String get report_longestStreak => 'Längste Serie';

  @override
  String report_asOfDate(String date) {
    return 'Stand: $date';
  }

  @override
  String get report_mealsWithSugar => 'Mahlzeiten mit Zucker';

  @override
  String get report_highGIMeals => 'Mahlzeiten mit hohem GI';

  @override
  String get progress_logToUnlock =>
      'Protokolliere deine Mahlzeiten, um Fortschrittseinblicke freizuschalten';

  @override
  String get progress_logToStartStreak =>
      'Protokolliere deine Mahlzeiten, um eine Serie zu starten';

  @override
  String get streak_fire =>
      'Unglaublicher Lauf! Halte das Feuer am Brennen! 🔥';

  @override
  String get streak_stacking =>
      'Erstaunliche Beständigkeit – stapele weiter Tage! 💪';

  @override
  String get streak_strongStart =>
      'Starker Start – lass es uns weiter ausbauen! 🚀';

  @override
  String get streak_owningWeek =>
      'Mahlzeit für Mahlzeit, du beherrschst diese Woche! 🍽️';

  @override
  String get streak_momentum =>
      'Eine Mahlzeit nach der anderen – behalte den Schwung bei! 🙌';

  @override
  String get streak_freshDay =>
      'Frischer Tag, frische Gelegenheit zu glänzen! 🌟';

  @override
  String get progress_dailyHistory => 'Täglicher Verlauf';

  @override
  String get progress_allLogs => 'Alle deine Protokolle';

  @override
  String get progress_noMealsLogged => 'Noch keine Mahlzeiten protokolliert';

  @override
  String get progress_logFirstMeal =>
      'Protokolliere deine erste Mahlzeit, um deine Fortschrittszeitleiste zu starten.';

  @override
  String get report_progressReportTitle => 'Fortschrittsbericht';

  @override
  String get report_shareTooltip => 'Bericht teilen';

  @override
  String report_shareError(String error) {
    return 'Fehler beim Teilen des Berichts: $error';
  }

  @override
  String get reportText_title => 'Fortschrittsbericht';

  @override
  String reportText_client(String name) {
    return 'Klient: $name';
  }

  @override
  String reportText_email(String email) {
    return 'E-Mail: $email';
  }

  @override
  String reportText_period(String start, String end) {
    return 'Zeitraum: $start - $end';
  }

  @override
  String get reportText_summary => 'Zusammenfassung:';

  @override
  String reportText_totalMeals(int count) {
    return 'Gesamtmahlzeiten: $count';
  }

  @override
  String reportText_mealsFollowed(int count) {
    return 'Mahlzeiten gefolgt: $count';
  }

  @override
  String reportText_mealsAlternatives(int count) {
    return 'Alternative Mahlzeiten: $count';
  }

  @override
  String reportText_mealsSkipped(int count) {
    return 'Mahlzeiten übersprungen: $count';
  }

  @override
  String reportText_mealsDue(int count) {
    return 'Fällige Mahlzeiten bisher: $count';
  }

  @override
  String reportText_unloggedDue(int count) {
    return 'Nicht protokollierte fällige Mahlzeiten: $count';
  }

  @override
  String reportText_longestStreak(String streak) {
    return 'Längste Serie: $streak';
  }

  @override
  String reportText_mealsWithSugar(int count) {
    return 'Mahlzeiten mit Zucker: $count';
  }

  @override
  String reportText_mealsHighGI(int count) {
    return 'Mahlzeiten mit hohem glykämischen Index: $count';
  }

  @override
  String get reportText_dailyBreakdown => 'Tägliche Aufschlüsselung:';

  @override
  String reportText_notes(String notes) {
    return '    Notizen: $notes';
  }

  @override
  String get reportGen_title => 'Bericht generieren';

  @override
  String get reportGen_subtitle => 'Zusammenfassungen zum Teilen bereit';

  @override
  String get reportGen_choosePeriod => 'Wähle einen Zeitraum';

  @override
  String get reportGen_periodDesc =>
      'Wir fassen alle Aktivitäten innerhalb des ausgewählten Bereichs zusammen.';

  @override
  String get reportGen_last7Days => 'Letzte 7 Tage';

  @override
  String get reportGen_last30Days => 'Letzte 30 Tage';

  @override
  String get reportGen_customRange => 'Benutzerdefinierter Bereich';

  @override
  String get reportGen_from => 'Von';

  @override
  String get reportGen_to => 'Bis';

  @override
  String get reportGen_includeTitle => 'Dein Bericht wird enthalten';

  @override
  String get reportGen_include1 =>
      'Vollständiger Mahlzeitenprotokollverlauf für den Zeitraum';

  @override
  String get reportGen_include2 => 'Einblicke in Einhaltung und Beständigkeit';

  @override
  String get reportGen_include3 =>
      'Klientennotizen und alternative Auswahlmöglichkeiten';

  @override
  String get reportGen_include4 =>
      'Wöchentliche Zusammenfassungen zum Teilen bereit';

  @override
  String get reportGen_button => 'Bericht generieren';

  @override
  String get uploadPlan_title => 'Laden Sie Ihren Speiseplan hoch';

  @override
  String get uploadPlan_subtitle =>
      'Wählen Sie Ihre Speiseplandatei aus, um zu beginnen';

  @override
  String get uploadPlan_fileSelected => 'Datei ausgewählt';

  @override
  String get uploadPlan_tapToSelect => 'Tippen Sie, um eine Datei auszuwählen';

  @override
  String get uploadPlan_fileFormats => 'PDF, DOC oder beliebiges Dateiformat';

  @override
  String get continueButton => 'Weiter';

  @override
  String get mealDrawer_ingredients => 'Zutaten';

  @override
  String get mealDrawer_noIngredients =>
      'Keine Zutatenliste für diese Mahlzeit bereitgestellt.';

  @override
  String get mealDrawer_preparation => 'Zubereitung';

  @override
  String get mealDrawer_noPrep =>
      'Keine Zubereitungsanweisungen für diese Mahlzeit bereitgestellt.';

  @override
  String get appName => 'IRresistible';

  @override
  String get settings_debug => 'Debuggen';

  @override
  String get settings_skipOnboarding => 'Onboarding überspringen';

  @override
  String get splashTitle => 'IRresistible';

  @override
  String get splashSubtitle => 'Deine persönliche Ernährungsreise';

  @override
  String get mock_meal_1_breakfast_name => 'Haferflocken mit Beeren';

  @override
  String get mock_meal_1_breakfast_desc =>
      '1 Tasse gekochte Haferflocken, 1/2 Tasse gemischte Beeren, 1 EL Mandelbutter, Honig';

  @override
  String get mock_meal_1_snack1_name => 'Apfel mit Mandelbutter';

  @override
  String get mock_meal_1_snack1_desc => '1 mittlerer Apfel, 1 EL Mandelbutter';

  @override
  String get mock_meal_1_lunch_name => 'Gegrillter Hähnchensalat';

  @override
  String get mock_meal_1_lunch_desc =>
      '120g gegrillte Hähnchenbrust, gemischter Salat, Kirschtomaten, Gurke, Olivenöl-Dressing';

  @override
  String get mock_meal_1_snack2_name => 'Griechischer Joghurt mit Beeren';

  @override
  String get mock_meal_1_snack2_desc =>
      '1 Becher griechischer Naturjoghurt, 1/4 Tasse gemischte Beeren';

  @override
  String get mock_meal_1_dinner_name => 'Gebackener Lachs mit Gemüse';

  @override
  String get mock_meal_1_dinner_desc =>
      '150g Lachsfilet, gerösteter Brokkoli und Süßkartoffel';

  @override
  String get mock_meal_1_breakfast_ingredient_0 =>
      '1 Tasse gekochter Haferbrei';

  @override
  String get mock_meal_1_breakfast_ingredient_1 => '1/2 Tasse gemischte Beeren';

  @override
  String get mock_meal_1_breakfast_ingredient_2 => '1 EL Mandelbutter';

  @override
  String get mock_meal_1_breakfast_ingredient_3 => '1 TL Honig';

  @override
  String get mock_meal_1_breakfast_instruction_0 =>
      'Den Haferbrei mit Wasser oder Milch kochen, bis er cremig ist.';

  @override
  String get mock_meal_1_breakfast_instruction_1 =>
      'Mit gemischten Beeren, Mandelbutter und einem Spritzer Honig belegen.';

  @override
  String get mock_meal_1_snack1_ingredient_0 => '1 mittelgroßer Apfel';

  @override
  String get mock_meal_1_snack1_ingredient_1 => '1 EL Mandelbutter';

  @override
  String get mock_meal_1_snack1_instruction_0 =>
      'Den Apfel in Spalten oder Scheiben schneiden.';

  @override
  String get mock_meal_1_snack1_instruction_1 =>
      'Mit Mandelbutter zum Dippen oder Streichen servieren.';

  @override
  String get mock_meal_1_lunch_ingredient_0 => '120g gegrillte Hähnchenbrust';

  @override
  String get mock_meal_1_lunch_ingredient_1 => '2 Tassen gemischter Salat';

  @override
  String get mock_meal_1_lunch_ingredient_2 => '1/2 Tasse Kirschtomaten';

  @override
  String get mock_meal_1_lunch_ingredient_3 => '1/2 Gurke';

  @override
  String get mock_meal_1_lunch_ingredient_4 => '2 EL Olivenöl-Dressing';

  @override
  String get mock_meal_1_lunch_instruction_0 =>
      'Das gegrillte Hähnchen und das Gemüse in Scheiben schneiden.';

  @override
  String get mock_meal_1_lunch_instruction_1 =>
      'Alles in einer Schüssel vermengen und mit Olivenöl-Dressing beträufeln.';

  @override
  String get mock_meal_1_snack2_ingredient_0 =>
      '1 Tasse Naturjoghurt griechischer Art';

  @override
  String get mock_meal_1_snack2_ingredient_1 => '1/4 Tasse gemischte Beeren';

  @override
  String get mock_meal_1_snack2_instruction_0 =>
      'Den Joghurt in eine Schüssel geben.';

  @override
  String get mock_meal_1_snack2_instruction_1 =>
      'Kurz vor dem Servieren mit gemischten Beeren belegen.';

  @override
  String get mock_meal_1_dinner_ingredient_0 => '150g Lachsfilet';

  @override
  String get mock_meal_1_dinner_ingredient_1 => '1 Tasse gerösteter Brokkoli';

  @override
  String get mock_meal_1_dinner_ingredient_2 => '1 mittelgroße Süßkartoffel';

  @override
  String get mock_meal_1_dinner_ingredient_3 => '1 Zitronenspalte';

  @override
  String get mock_meal_1_dinner_instruction_0 =>
      'Den gewürzten Lachs und das Gemüse backen, bis sie zart sind.';

  @override
  String get mock_meal_1_dinner_instruction_1 =>
      'Mit einem Spritzer Zitrone darüber servieren.';

  @override
  String get mock_meal_2_breakfast_name => 'Rührei mit Avocado-Toast';

  @override
  String get mock_meal_2_breakfast_desc =>
      '2 Rühreier, 1 Scheibe Vollkornbrot, 1/2 Avocado, Kirschtomaten';

  @override
  String get mock_meal_2_snack1_name => 'Protein-Smoothie';

  @override
  String get mock_meal_2_snack1_desc =>
      'Banane, Proteinpulver, Mandelmilch, Spinat';

  @override
  String get mock_meal_2_lunch_name => 'Truthahn-Wrap mit Hummus';

  @override
  String get mock_meal_2_lunch_desc =>
      'Vollkorntortilla, 120g Putenbrust, Hummus, Salat, Paprika';

  @override
  String get mock_meal_2_snack2_name => 'Karottensticks mit Hummus';

  @override
  String get mock_meal_2_snack2_desc =>
      '1 Tasse Karottensticks, 1/4 Tasse Hummus';

  @override
  String get mock_meal_2_dinner_name => 'Hähnchen-Pfanne';

  @override
  String get mock_meal_2_dinner_desc =>
      '150g Hähnchenbrust, gemischtes Gemüse, brauner Reis, Teriyaki-Sauce';

  @override
  String get mock_meal_2_breakfast_ingredient_0 => '2 große Eier';

  @override
  String get mock_meal_2_breakfast_ingredient_1 => '1 Scheibe Vollkornbrot';

  @override
  String get mock_meal_2_breakfast_ingredient_2 => '1/2 Avocado';

  @override
  String get mock_meal_2_breakfast_ingredient_3 => '4 Kirschtomaten';

  @override
  String get mock_meal_2_breakfast_instruction_0 =>
      'Die Eier in einer beschichteten Pfanne weich rühren.';

  @override
  String get mock_meal_2_breakfast_instruction_1 =>
      'Das Brot toasten, mit zerdrückter Avocado belegen und mit Tomaten servieren.';

  @override
  String get mock_meal_2_snack1_ingredient_0 => '1 Banane';

  @override
  String get mock_meal_2_snack1_ingredient_1 => '1 Portion Proteinpulver';

  @override
  String get mock_meal_2_snack1_ingredient_2 => '1 Tasse Mandelmilch';

  @override
  String get mock_meal_2_snack1_ingredient_3 => '1 Tasse Spinat';

  @override
  String get mock_meal_2_snack1_instruction_0 =>
      'Alle Zutaten in einen Mixer geben.';

  @override
  String get mock_meal_2_snack1_instruction_1 =>
      'Mixen, bis es glatt und cremig ist, dann sofort servieren.';

  @override
  String get mock_meal_2_lunch_ingredient_0 => '1 Vollweizen-Tortilla';

  @override
  String get mock_meal_2_lunch_ingredient_1 =>
      '120g geschnittene Truthahnbrust';

  @override
  String get mock_meal_2_lunch_ingredient_2 => '2 EL Hummus';

  @override
  String get mock_meal_2_lunch_ingredient_3 => '1 Tasse Salat';

  @override
  String get mock_meal_2_lunch_ingredient_4 => '1/4 Tasse geschnittene Paprika';

  @override
  String get mock_meal_2_lunch_instruction_0 =>
      'Hummus auf die Tortilla streichen.';

  @override
  String get mock_meal_2_lunch_instruction_1 =>
      'Truthahn, Salat und Paprika schichten, dann fest einrollen und in Scheiben schneiden.';

  @override
  String get mock_meal_2_snack2_ingredient_0 => '1 Tasse Karottensticks';

  @override
  String get mock_meal_2_snack2_ingredient_1 => '1/4 Tasse Hummus';

  @override
  String get mock_meal_2_snack2_instruction_0 =>
      'Die Karotten bei Bedarf schälen und in Stifte schneiden.';

  @override
  String get mock_meal_2_snack2_instruction_1 =>
      'Mit Hummus zum Dippen servieren.';

  @override
  String get mock_meal_2_dinner_ingredient_0 => '150g Hähnchenbrust';

  @override
  String get mock_meal_2_dinner_ingredient_1 => '2 Tassen gemischtes Gemüse';

  @override
  String get mock_meal_2_dinner_ingredient_2 => '1 Tasse brauner Reis';

  @override
  String get mock_meal_2_dinner_ingredient_3 => '2 EL Teriyaki-Sauce';

  @override
  String get mock_meal_2_dinner_instruction_0 =>
      'Das Hähnchen anbraten, bis es fast durchgegart ist.';

  @override
  String get mock_meal_2_dinner_instruction_1 =>
      'Gemüse und Sauce hinzufügen, bissfest garen und über Reis servieren.';

  @override
  String get mock_meal_3_breakfast_name => 'Griechisches Joghurt-Parfait';

  @override
  String get mock_meal_3_breakfast_desc =>
      'Griechischer Joghurt geschichtet mit Müsli, Beeren und Honig';

  @override
  String get mock_meal_3_snack1_name => 'Nussmischung';

  @override
  String get mock_meal_3_snack1_desc =>
      '1/4 Tasse gemischte Mandeln, Cashewnüsse und Walnüsse';

  @override
  String get mock_meal_3_lunch_name => 'Quinoa Buddha Bowl';

  @override
  String get mock_meal_3_lunch_desc =>
      'Quinoa, geröstete Kichererbsen, Avocado, Gemüse, Tahini-Dressing';

  @override
  String get mock_meal_3_snack2_name => 'Hüttenkäse mit Ananas';

  @override
  String get mock_meal_3_snack2_desc =>
      '1 Becher fettarmer Hüttenkäse, 1/2 Tasse Ananasstücke';

  @override
  String get mock_meal_3_dinner_name => 'Magere Rindfleisch-Tacos';

  @override
  String get mock_meal_3_dinner_desc =>
      'Mageres Rinderhackfleisch, Maistortillas, Salat, Tomate, Salsa';

  @override
  String get mock_meal_3_breakfast_ingredient_0 =>
      '1 Tasse griechischer Joghurt';

  @override
  String get mock_meal_3_breakfast_ingredient_1 => '1/2 Tasse Müsli';

  @override
  String get mock_meal_3_breakfast_ingredient_2 => '1/2 Tasse gemischte Beeren';

  @override
  String get mock_meal_3_breakfast_ingredient_3 => '1 TL Honig';

  @override
  String get mock_meal_3_breakfast_instruction_0 =>
      'Joghurt, Müsli und Beeren in einem Glas oder einer Schüssel schichten.';

  @override
  String get mock_meal_3_breakfast_instruction_1 =>
      'Vor dem Servieren mit Honig beträufeln.';

  @override
  String get mock_meal_3_snack1_ingredient_0 => '1/4 Tasse gemischte Nüsse';

  @override
  String get mock_meal_3_snack1_instruction_0 =>
      'Die gemischten Nüsse in eine kleine Schüssel oder einen Behälter portionieren.';

  @override
  String get mock_meal_3_snack1_instruction_1 =>
      'Sofort genießen oder für später einpacken.';

  @override
  String get mock_meal_3_lunch_ingredient_0 => '1 Tasse gekochter Quinoa';

  @override
  String get mock_meal_3_lunch_ingredient_1 =>
      '1/2 Tasse geröstete Kichererbsen';

  @override
  String get mock_meal_3_lunch_ingredient_2 => '1/2 Avocado';

  @override
  String get mock_meal_3_lunch_ingredient_3 => '1 Tasse gemischtes Gemüse';

  @override
  String get mock_meal_3_lunch_ingredient_4 => '2 EL Tahini-Dressing';

  @override
  String get mock_meal_3_lunch_instruction_0 =>
      'Den Quinoa erwärmen und in einer Schüssel anrichten.';

  @override
  String get mock_meal_3_lunch_instruction_1 =>
      'Mit Kichererbsen, Gemüse, Avocado belegen und mit Tahini-Dressing beträufeln.';

  @override
  String get mock_meal_3_snack2_ingredient_0 => '1 Tasse fettarmer Hüttenkäse';

  @override
  String get mock_meal_3_snack2_ingredient_1 => '1/2 Tasse Ananasstücke';

  @override
  String get mock_meal_3_snack2_instruction_0 =>
      'Den Hüttenkäse in eine Servierschüssel geben.';

  @override
  String get mock_meal_3_snack2_instruction_1 =>
      'Mit Ananasstücken belegen und genießen.';

  @override
  String get mock_meal_3_dinner_ingredient_0 =>
      '150g mageres Rinderhackfleisch';

  @override
  String get mock_meal_3_dinner_ingredient_1 => '2 Mais-Tortillas';

  @override
  String get mock_meal_3_dinner_ingredient_2 => '1 Tasse geriebener Salat';

  @override
  String get mock_meal_3_dinner_ingredient_3 => '1 gewürfelte Tomate';

  @override
  String get mock_meal_3_dinner_ingredient_4 => '2 EL Salsa';

  @override
  String get mock_meal_3_dinner_instruction_0 =>
      'Das Hackfleisch mit Gewürzen braten, bis es braun ist.';

  @override
  String get mock_meal_3_dinner_instruction_1 =>
      'Die Tortillas erwärmen, dann mit Salat, Tomate und Salsa belegen.';

  @override
  String get mock_meal_4_breakfast_name => 'Vollkornpfannkuchen';

  @override
  String get mock_meal_4_breakfast_desc =>
      '2 Vollkornpfannkuchen, frische Beeren, Ahornsirup';

  @override
  String get mock_meal_4_snack1_name => 'Birne mit Käse';

  @override
  String get mock_meal_4_snack1_desc => '1 mittlere Birne, 1 Käsestick';

  @override
  String get mock_meal_4_lunch_name => 'Thunfischsalat';

  @override
  String get mock_meal_4_lunch_desc =>
      'Thunfisch, gemischter Salat, hartgekochtes Ei, Oliven, Olivenöl';

  @override
  String get mock_meal_4_snack2_name => 'Proteinriegel';

  @override
  String get mock_meal_4_snack2_desc => '1 Proteinriegel (mind. 10g Protein)';

  @override
  String get mock_meal_4_dinner_name => 'Gebackenes Hähnchen mit Quinoa';

  @override
  String get mock_meal_4_dinner_desc =>
      'Hähnchenbrust mit Kräuterkruste, Quinoa, gerösteter Spargel';

  @override
  String get mock_meal_4_breakfast_ingredient_0 => '2 Vollkornpfannkuchen';

  @override
  String get mock_meal_4_breakfast_ingredient_1 => '1/2 Tasse frische Beeren';

  @override
  String get mock_meal_4_breakfast_ingredient_2 => '1 EL Ahornsirup';

  @override
  String get mock_meal_4_breakfast_instruction_0 =>
      'Die Pfannkuchen bei Bedarf in einer Pfanne oder im Toaster erwärmen.';

  @override
  String get mock_meal_4_breakfast_instruction_1 =>
      'Mit Beeren belegen und mit Ahornsirup beträufeln.';

  @override
  String get mock_meal_4_snack1_ingredient_0 => '1 mittlere Birne';

  @override
  String get mock_meal_4_snack1_ingredient_1 => '1 Käsestick';

  @override
  String get mock_meal_4_snack1_instruction_0 =>
      'Die Birne waschen und bei Bedarf in Scheiben schneiden.';

  @override
  String get mock_meal_4_snack1_instruction_1 =>
      'Mit Käsestick als schnellen Snack kombinieren.';

  @override
  String get mock_meal_4_lunch_ingredient_0 => '1 Dose Thunfisch in Wasser';

  @override
  String get mock_meal_4_lunch_ingredient_1 => '2 Tassen gemischter Salat';

  @override
  String get mock_meal_4_lunch_ingredient_2 => '1 hartgekochtes Ei';

  @override
  String get mock_meal_4_lunch_ingredient_3 => '5 Oliven';

  @override
  String get mock_meal_4_lunch_ingredient_4 => '2 EL Olivenöl';

  @override
  String get mock_meal_4_lunch_instruction_0 =>
      'Den Thunfisch abtropfen lassen und das Ei und die Oliven in Scheiben schneiden.';

  @override
  String get mock_meal_4_lunch_instruction_1 =>
      'Zutaten mit Salat vermengen und mit Olivenöl beträufeln.';

  @override
  String get mock_meal_4_snack2_ingredient_0 => '1 Proteinriegel';

  @override
  String get mock_meal_4_snack2_instruction_0 =>
      'Den Proteinriegel auspacken und als schnellen Snack genießen.';

  @override
  String get mock_meal_4_dinner_ingredient_0 => '150g Hähnchenbrust';

  @override
  String get mock_meal_4_dinner_ingredient_1 => '1 Tasse gekochter Quinoa';

  @override
  String get mock_meal_4_dinner_ingredient_2 => '1 Tasse gerösteter Spargel';

  @override
  String get mock_meal_4_dinner_ingredient_3 =>
      'nach Geschmack Kräuter und Gewürze';

  @override
  String get mock_meal_4_dinner_instruction_0 =>
      'Das gewürzte Hähnchen backen, bis es durchgegart ist.';

  @override
  String get mock_meal_4_dinner_instruction_1 =>
      'Neben Quinoa und geröstetem Spargel servieren.';

  @override
  String get mock_meal_5_breakfast_name => 'Gemüse-Omelett';

  @override
  String get mock_meal_5_breakfast_desc =>
      'Omelett aus 3 Eiern mit Spinat, Pilzen und Feta-Käse';

  @override
  String get mock_meal_5_snack1_name => 'Banane mit Erdnussbutter';

  @override
  String get mock_meal_5_snack1_desc => '1 mittlere Banane, 1 EL Erdnussbutter';

  @override
  String get mock_meal_5_lunch_name => 'Mediterrane Hähnchen-Bowl';

  @override
  String get mock_meal_5_lunch_desc =>
      'Gegrilltes Hähnchen, brauner Reis, Hummus, Gurke, Tomaten, Oliven';

  @override
  String get mock_meal_5_snack2_name => 'Reiswaffeln mit Avocado';

  @override
  String get mock_meal_5_snack2_desc =>
      '2 Reiswaffeln belegt mit zerdrückter Avocado';

  @override
  String get mock_meal_5_dinner_name => 'Garnelen-Pasta Primavera';

  @override
  String get mock_meal_5_dinner_desc =>
      'Vollkornnudeln, Garnelen, gemischtes Gemüse, Knoblauch-Olivenöl';

  @override
  String get mock_meal_5_breakfast_ingredient_0 => '3 große Eier';

  @override
  String get mock_meal_5_breakfast_ingredient_1 => '1 Tasse Spinat';

  @override
  String get mock_meal_5_breakfast_ingredient_2 => '1/2 Tasse Pilze';

  @override
  String get mock_meal_5_breakfast_ingredient_3 => '2 EL Feta-Käse';

  @override
  String get mock_meal_5_breakfast_instruction_0 =>
      'Pilze und Spinat anbraten, bis sie zart sind.';

  @override
  String get mock_meal_5_breakfast_instruction_1 =>
      'Verrührte Eier hinzufügen, garen bis sie fest sind, und vor dem Falten mit Feta bestreuen.';

  @override
  String get mock_meal_5_snack1_ingredient_0 => '1 mittlere Banane';

  @override
  String get mock_meal_5_snack1_ingredient_1 => '1 EL Erdnussbutter';

  @override
  String get mock_meal_5_snack1_instruction_0 =>
      'Die Banane schälen und bei Bedarf in Scheiben schneiden.';

  @override
  String get mock_meal_5_snack1_instruction_1 =>
      'Mit Erdnussbutter zum Dippen oder Streichen servieren.';

  @override
  String get mock_meal_5_lunch_ingredient_0 => '120g gegrilltes Hähnchen';

  @override
  String get mock_meal_5_lunch_ingredient_1 => '1 Tasse brauner Reis';

  @override
  String get mock_meal_5_lunch_ingredient_2 => '2 EL Hummus';

  @override
  String get mock_meal_5_lunch_ingredient_3 => '1/2 Gurke';

  @override
  String get mock_meal_5_lunch_ingredient_4 => '1/2 Tasse Tomaten';

  @override
  String get mock_meal_5_lunch_ingredient_5 => '5 Oliven';

  @override
  String get mock_meal_5_lunch_instruction_0 =>
      'Reis in einer Schüssel schichten und mit geschnittenem Hähnchen belegen.';

  @override
  String get mock_meal_5_lunch_instruction_1 =>
      'Vor dem Servieren Hummus, Gurke, Tomaten und Oliven hinzufügen.';

  @override
  String get mock_meal_5_snack2_ingredient_0 => '2 Reiswaffeln';

  @override
  String get mock_meal_5_snack2_ingredient_1 => '1/2 Avocado';

  @override
  String get mock_meal_5_snack2_instruction_0 =>
      'Die Avocado mit einer Gabel zerdrücken und bei Bedarf würzen.';

  @override
  String get mock_meal_5_snack2_instruction_1 =>
      'Auf Reiswaffeln streichen und sofort servieren.';

  @override
  String get mock_meal_5_dinner_ingredient_0 => '60g Vollkornnudeln';

  @override
  String get mock_meal_5_dinner_ingredient_1 => '150g Garnelen';

  @override
  String get mock_meal_5_dinner_ingredient_2 => '2 Tassen gemischtes Gemüse';

  @override
  String get mock_meal_5_dinner_ingredient_3 => '2 EL Knoblauch-Olivenöl';

  @override
  String get mock_meal_5_dinner_instruction_0 =>
      'Die Nudeln bissfest kochen und etwas Kochwasser zurückbehalten.';

  @override
  String get mock_meal_5_dinner_instruction_1 =>
      'Garnelen und Gemüse in Knoblauchöl anbraten, dann mit Nudeln vermengen.';

  @override
  String get mock_meal_6_breakfast_name => 'Frühstücks-Burrito';

  @override
  String get mock_meal_6_breakfast_desc =>
      'Rührei, schwarze Bohnen, Käse, Salsa in Vollkorntortilla';

  @override
  String get mock_meal_6_snack1_name => 'Studentenfutter';

  @override
  String get mock_meal_6_snack1_desc =>
      'Nüsse, getrocknete Cranberries, dunkle Schokostückchen';

  @override
  String get mock_meal_6_lunch_name => 'Gegrilltes Gemüse-Sandwich';

  @override
  String get mock_meal_6_lunch_desc =>
      'Gegrillte Zucchini, Paprika, Mozzarella auf Vollkornbrot';

  @override
  String get mock_meal_6_snack2_name => 'Edamame';

  @override
  String get mock_meal_6_snack2_desc =>
      '1 Tasse gedämpfte Edamame mit Meersalz';

  @override
  String get mock_meal_6_dinner_name => 'Gegrilltes Steak mit Gemüse';

  @override
  String get mock_meal_6_dinner_desc =>
      'Mageres Lendensteak, gerösteter Rosenkohl und Karotten';

  @override
  String get mock_meal_6_breakfast_ingredient_0 => '2 Rühreier';

  @override
  String get mock_meal_6_breakfast_ingredient_1 => '1/4 Tasse schwarze Bohnen';

  @override
  String get mock_meal_6_breakfast_ingredient_2 => '2 EL geriebener Käse';

  @override
  String get mock_meal_6_breakfast_ingredient_3 => '2 EL Salsa';

  @override
  String get mock_meal_6_breakfast_ingredient_4 => '1 Vollweizen-Tortilla';

  @override
  String get mock_meal_6_breakfast_instruction_0 =>
      'Die Tortilla erwärmen und die Eier mit Bohnen verrühren.';

  @override
  String get mock_meal_6_breakfast_instruction_1 =>
      'Die Tortilla füllen, mit Käse und Salsa belegen, dann fest einrollen.';

  @override
  String get mock_meal_6_snack1_ingredient_0 => '1/4 Tasse gemischte Nüsse';

  @override
  String get mock_meal_6_snack1_ingredient_1 => '2 EL getrocknete Cranberries';

  @override
  String get mock_meal_6_snack1_ingredient_2 =>
      '1 EL dunkle Schokoladenstückchen';

  @override
  String get mock_meal_6_snack1_instruction_0 =>
      'Nüsse, Cranberries und Schokoladenstückchen in einer kleinen Schüssel vermengen.';

  @override
  String get mock_meal_6_snack1_instruction_1 =>
      'Bei Bedarf in einen To-go-Behälter portionieren.';

  @override
  String get mock_meal_6_lunch_ingredient_0 => '2 Scheiben Vollkornbrot';

  @override
  String get mock_meal_6_lunch_ingredient_1 => '1/2 gegrillte Zucchini';

  @override
  String get mock_meal_6_lunch_ingredient_2 => '1/4 Tasse gegrillte Paprika';

  @override
  String get mock_meal_6_lunch_ingredient_3 => '2 Scheiben frischer Mozzarella';

  @override
  String get mock_meal_6_lunch_ingredient_4 => '1 EL Balsamico-Glasur';

  @override
  String get mock_meal_6_lunch_instruction_0 =>
      'Gegrilltes Gemüse und Mozzarella auf das Brot schichten.';

  @override
  String get mock_meal_6_lunch_instruction_1 =>
      'Mit Balsamico-Glasur beträufeln und bei Bedarf toasten, bis der Käse schmilzt.';

  @override
  String get mock_meal_6_snack2_ingredient_0 => '1 Tasse Edamame';

  @override
  String get mock_meal_6_snack2_ingredient_1 => 'nach Geschmack Meersalz';

  @override
  String get mock_meal_6_snack2_instruction_0 =>
      'Die Edamame dämpfen oder in der Mikrowelle erhitzen, bis sie durchgewärmt sind.';

  @override
  String get mock_meal_6_snack2_instruction_1 =>
      'Vor dem Servieren mit Meersalz bestreuen.';

  @override
  String get mock_meal_6_dinner_ingredient_0 => '150g mageres Rindersteak';

  @override
  String get mock_meal_6_dinner_ingredient_1 => '1 Tasse gerösteter Rosenkohl';

  @override
  String get mock_meal_6_dinner_ingredient_2 => '1 Tasse geröstete Karotten';

  @override
  String get mock_meal_6_dinner_instruction_0 =>
      'Das Steak grillen oder anbraten, bis es den gewünschten Gargrad erreicht hat.';

  @override
  String get mock_meal_6_dinner_instruction_1 =>
      'Mit geröstetem Rosenkohl und Karotten servieren.';

  @override
  String get mock_meal_7_breakfast_name => 'Armer Ritter mit Obst';

  @override
  String get mock_meal_7_breakfast_desc =>
      'Vollkorn-French-Toast, frische Beeren, Joghurt';

  @override
  String get mock_meal_7_snack1_name => 'Sellerie mit Erdnussbutter';

  @override
  String get mock_meal_7_snack1_desc =>
      '4 Selleriestangen mit 2 EL Erdnussbutter';

  @override
  String get mock_meal_7_lunch_name => 'Chicken Caesar Salad';

  @override
  String get mock_meal_7_lunch_desc =>
      'Gegrilltes Hähnchen, Römersalat, Parmesan, leichtes Caesar-Dressing';

  @override
  String get mock_meal_7_snack2_name => 'Smoothie Bowl';

  @override
  String get mock_meal_7_snack2_desc =>
      'Pürierte Beeren, Banane, belegt mit Müsli und Chiasamen';

  @override
  String get mock_meal_7_dinner_name => 'Gebackener Kabeljau mit Süßkartoffel';

  @override
  String get mock_meal_7_dinner_desc =>
      'Kabeljau mit Kräutern, Süßkartoffelpüree, gedämpfte grüne Bohnen';

  @override
  String get mock_meal_7_breakfast_ingredient_0 => '2 Scheiben Vollkornbrot';

  @override
  String get mock_meal_7_breakfast_ingredient_1 => '1 Ei';

  @override
  String get mock_meal_7_breakfast_ingredient_2 => '1/2 Tasse gemischte Beeren';

  @override
  String get mock_meal_7_breakfast_ingredient_3 => '2 EL griechischer Joghurt';

  @override
  String get mock_meal_7_breakfast_ingredient_4 => '1 TL Zimt';

  @override
  String get mock_meal_7_breakfast_instruction_0 =>
      'Das Ei mit Zimt verquirlen und die Brotscheiben darin einweichen.';

  @override
  String get mock_meal_7_breakfast_instruction_1 =>
      'Auf einer Pfanne goldbraun braten, dann mit Beeren und Joghurt belegen.';

  @override
  String get mock_meal_7_snack1_ingredient_0 => '4 Selleriestangen';

  @override
  String get mock_meal_7_snack1_ingredient_1 => '2 EL Erdnussbutter';

  @override
  String get mock_meal_7_snack1_instruction_0 =>
      'Die Selleriestangen waschen und zurechtschneiden.';

  @override
  String get mock_meal_7_snack1_instruction_1 =>
      'Die Sellerierillen mit Erdnussbutter füllen.';

  @override
  String get mock_meal_7_lunch_ingredient_0 => '120g gegrillte Hähnchenbrust';

  @override
  String get mock_meal_7_lunch_ingredient_1 => '2 Tassen Römersalat';

  @override
  String get mock_meal_7_lunch_ingredient_2 => '2 EL Parmesan';

  @override
  String get mock_meal_7_lunch_ingredient_3 => '2 EL leichtes Caesar-Dressing';

  @override
  String get mock_meal_7_lunch_ingredient_4 => '1/2 Tasse Vollkorn-Croutons';

  @override
  String get mock_meal_7_lunch_instruction_0 =>
      'Den Salat hacken und das gegrillte Hähnchen in Scheiben schneiden.';

  @override
  String get mock_meal_7_lunch_instruction_1 =>
      'Mit Dressing, Parmesan und Croutons vermengen, bevor serviert wird.';

  @override
  String get mock_meal_7_snack2_ingredient_0 => '1 Tasse gemischte Beeren';

  @override
  String get mock_meal_7_snack2_ingredient_1 => '1/2 Banane';

  @override
  String get mock_meal_7_snack2_ingredient_2 => '1/4 Tasse Müsli';

  @override
  String get mock_meal_7_snack2_ingredient_3 => '1 EL Chiasamen';

  @override
  String get mock_meal_7_snack2_instruction_0 =>
      'Die Beeren und Banane mixen, bis sie glatt sind.';

  @override
  String get mock_meal_7_snack2_instruction_1 =>
      'In eine Schüssel gießen und mit Müsli und Chiasamen belegen.';

  @override
  String get mock_meal_7_dinner_ingredient_0 => '150g Kabeljaufilet';

  @override
  String get mock_meal_7_dinner_ingredient_1 => '1 mittelgroße Süßkartoffel';

  @override
  String get mock_meal_7_dinner_ingredient_2 => '1 Tasse grüne Bohnen';

  @override
  String get mock_meal_7_dinner_ingredient_3 =>
      'nach Geschmack Kräuter und Zitrone';

  @override
  String get mock_meal_7_dinner_instruction_0 =>
      'Den Kabeljau mit Kräutern und Zitrone würzen, dann backen, bis er flockig ist.';

  @override
  String get mock_meal_7_dinner_instruction_1 =>
      'Mit Süßkartoffelpüree und gedämpften grünen Bohnen servieren.';

  @override
  String get dashboard_today => 'Heute';

  @override
  String get dashboard_greeting_unlogged_3 =>
      'Lass uns ein paar Mahlzeiten protokollieren, solange die Details noch frisch sind.';

  @override
  String get dashboard_greeting_unlogged_2 =>
      'Zwei Mahlzeiten warten auf ein Protokoll – schnelle Updates helfen sehr.';

  @override
  String get dashboard_greeting_unlogged_1 =>
      'Eine Mahlzeit benötigt ein schnelles Protokoll, um auf Kurs zu bleiben.';

  @override
  String get dashboard_greeting_all_set =>
      'Du bist bereit bis zur nächsten Mahlzeit.';

  @override
  String get dashboard_greeting_good_job =>
      'Gute Arbeit, aktuell zu bleiben – behalte den Schwung bei.';

  @override
  String dashboard_status_overdue(int count, String label) {
    return '$count $label überfällig';
  }

  @override
  String dashboard_status_logged(int count, String label) {
    return '$count $label protokolliert';
  }

  @override
  String get mealLabel => 'Mahlzeit';

  @override
  String get mealsLabel => 'Mahlzeiten';

  @override
  String get mock_mealPlanName => 'Woche 1 Speiseplan';

  @override
  String get mock_endurancePlanName => 'Ausdauer-Support-Plan';

  @override
  String get mock_consultation_1_focusArea_0 =>
      'Nüchternblutzucker stabilisieren';

  @override
  String get mock_consultation_1_focusArea_1 =>
      'Krafttraining-Brennstoff wieder einführen';

  @override
  String get mock_consultation_1_preparationNote_0 =>
      'Neueste Blutzuckermessgerät-Exporte hochladen';

  @override
  String get mock_consultation_1_preparationNote_1 =>
      'Flüssigkeitszufuhr 3 Tage vorher verfolgen';

  @override
  String get mock_consultation_2_focusArea_0 => 'Vor-Lauf-Betankung optimieren';

  @override
  String get mock_consultation_2_focusArea_1 => 'Ballaststoffziele anpassen';

  @override
  String get mock_consultation_2_preparationNote_0 =>
      'Ernährungstagebuch der letzten 14 Tage mitbringen';

  @override
  String get mock_consultation_2_preparationNote_1 =>
      'Alle Hypoglykämie-Symptome notieren';

  @override
  String get dashboard_catchUp => 'Aufholen';

  @override
  String get dashboard_logNow => 'Jetzt protokollieren';

  @override
  String get dashboard_needsAttention => 'Benötigt Aufmerksamkeit';

  @override
  String get dashboard_pendingMealsSwipeHint =>
      'Wischen Sie über überfällige und fällige Mahlzeiten, um Ihr Protokoll aktuell zu halten.';

  @override
  String get dashboard_pendingMealsSeveritySeveral =>
      'Mehrere Mahlzeiten warten — das Erfassen jetzt hält Ihre Daten genau.';

  @override
  String get dashboard_pendingMealsSeverityTwo =>
      'Zwei Mahlzeiten benötigen Aufmerksamkeit — ein paar schnelle Protokolle schließen die Lücke.';

  @override
  String get dashboard_pendingMealsSeverityOne =>
      'Eine Mahlzeit ist bereit zum Protokollieren — nehmen Sie sich einen Moment Zeit, um sie zu erfassen.';

  @override
  String get dashboard_comingUp => 'Demnächst';

  @override
  String get dashboard_nextMeal => 'Nächste Mahlzeit';

  @override
  String get dashboard_logged => 'Protokolliert';

  @override
  String dashboard_scheduled(String time, String relativeTime) {
    return 'Geplant $time • $relativeTime';
  }

  @override
  String dashboard_scheduled_full(
      String time, String mealType, String relativeTime) {
    return '$time • $mealType • $relativeTime';
  }

  @override
  String dashboard_logged_full(String time, String mealType) {
    return '$time • $mealType';
  }

  @override
  String get dashboard_logSomethingElse => 'Etwas anderes protokollieren';

  @override
  String get dashboard_greatJob => 'Gut gemacht!';

  @override
  String get dashboard_noted => 'Notiert';

  @override
  String get dashboard_logSuccess => 'Protokoll erfolgreich gespeichert';

  @override
  String get dashboard_followedRecipe => 'Rezept gefolgt';

  @override
  String get dashboard_followedMeal => 'Mahlzeit gefolgt';

  @override
  String get dashboard_skippedMeal => 'Mahlzeit übersprungen';

  @override
  String get dashboard_thanksTrack => 'Danke, dass du dranbleibst!';

  @override
  String get dashboard_notedAdjust => 'Notiert, wir passen deinen Plan an.';

  @override
  String get dashboard_followingRecipe => 'Rezept folgen';

  @override
  String get dashboard_skippingMeal => 'Mahlzeit überspringen';

  @override
  String get dashboard_loggingMeal => 'Mahlzeit wird protokolliert...';

  @override
  String get dashboard_markingSkipped => 'Wird als übersprungen markiert...';

  @override
  String get dashboard_loggedExactly => 'Genau wie geplant protokolliert';

  @override
  String get dashboard_markedSkipped => 'Für heute als übersprungen markiert';

  @override
  String get time_underMinuteFuture => 'in weniger als einer Minute';

  @override
  String get time_underMinutePast => 'vor weniger als einer Minute';

  @override
  String time_minutesFuture(int minutes) {
    return 'in $minutes Min';
  }

  @override
  String time_minutesPast(int minutes) {
    return 'vor $minutes Min';
  }

  @override
  String time_hoursFuture(int hours) {
    return 'in $hours Std';
  }

  @override
  String time_hoursPast(int hours) {
    return 'vor $hours Std';
  }

  @override
  String time_hoursMinutesFuture(int hours, int minutes) {
    return 'in ${hours}Std ${minutes}Min';
  }

  @override
  String time_hoursMinutesPast(int hours, int minutes) {
    return 'vor ${hours}Std ${minutes}Min';
  }

  @override
  String get dashboard_allMealsLogged => 'Alle Mahlzeiten protokolliert!';

  @override
  String get dashboard_allMealsLoggedBody =>
      'Tolle Arbeit, heute auf Kurs zu bleiben. Du kannst deine Einträge überprüfen oder in den Zeitplan für die kommenden Tage springen.';

  @override
  String get dashboard_mealsLogged => 'Mahlzeiten protokolliert';

  @override
  String dashboard_mealsLoggedCount(int current, int total) {
    return '$current von $total protokolliert';
  }

  @override
  String get dashboard_nothingLogged =>
      'Noch nichts protokolliert. Deine Updates erscheinen hier.';

  @override
  String get dashboard_containsSugar => 'Enthält Zucker';

  @override
  String get dashboard_highGI => 'Hoher GI';

  @override
  String get status_followed => 'Plan gefolgt';

  @override
  String get status_alternative => 'Alternative Mahlzeit';

  @override
  String get status_skipped => 'Mahlzeit übersprungen';
}
