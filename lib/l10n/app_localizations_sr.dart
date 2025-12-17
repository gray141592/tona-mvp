// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'Tona';

  @override
  String get settings => 'Podešavanja';

  @override
  String get language => 'Jezik';

  @override
  String get english => 'Engleski';

  @override
  String get german => 'Nemački';

  @override
  String get serbian => 'Srpski';

  @override
  String get resetOnboarding => 'Resetuj Onboarding';

  @override
  String get resetSwipeCoach => 'Resetuj Swipe Coach';

  @override
  String get changeTime => 'Promeni vreme u aplikaciji';

  @override
  String get consultationNotes => 'Beleške sa konsultacija';

  @override
  String get consultationNotFound => 'Konsultacija nije pronađena';

  @override
  String get reschedule => 'Zakaži ponovo';

  @override
  String get reschedulingDisabled =>
      'Ponovno zakazivanje je onemogućeno nakon otpremanja plana obroka za praćenje.';

  @override
  String get openPreparedReport => 'Otvori pripremljeni izveštaj';

  @override
  String get myNotes => 'Moje beleške';

  @override
  String get myNotesHint => 'Zabeležite zaključke, prilagođavanja, pitanja…';

  @override
  String get focusAreas => 'Oblasti fokusa';

  @override
  String get focusAreasHint =>
      'Jedna po redu (npr. punjenje gorivom pre treninga)';

  @override
  String get afterTheVisit => 'Nakon posete';

  @override
  String get mealPlanUploaded => 'Plan obroka je otpremljen';

  @override
  String get uploadNewMealPlan => 'Otpremi novi plan obroka';

  @override
  String get viewLinkedMealPlan => 'Pogledaj povezani plan obroka';

  @override
  String get viewReport => 'Pogledaj izveštaj';

  @override
  String consultationMoved(String date, String time) {
    return 'Konsultacija je premeštena na $date u $time.';
  }

  @override
  String get mealPlanUploadedAndLinked => 'Plan obroka je otpremljen i povezan';

  @override
  String get noReportAvailableYet => 'Izveštaj još uvek nije dostupan';

  @override
  String get resetSwipeCoachMessage => 'Podsetnik za prevlačenje je resetovan.';

  @override
  String get changeTimeMessage => 'Vreme je promenjeno.';

  @override
  String get alreadyOnYourCalendar => 'Već u vašem kalendaru';

  @override
  String get calendarUnavailable => 'Kalendar nije dostupan';

  @override
  String addedToCalendar(String date) {
    return 'Dodato u kalendar za $date';
  }

  @override
  String preparingForConsultation(String date) {
    return 'Priprema za konsultacije $date';
  }

  @override
  String get yourNutritionist => 'Vaš nutricionista';

  @override
  String consultationScheduledFor(String date) {
    return 'Konsultacije su zakazane za $date.';
  }

  @override
  String get noMealPlanLoaded =>
      'Nije učitan nijedan plan obroka za povezivanje.';

  @override
  String linkedMealPlanToConsultation(String mealPlanName, String date) {
    return 'Povezan $mealPlanName sa konsultacijama $date.';
  }

  @override
  String get noMealPlanLinked => 'Još uvek nema povezanog plana obroka';

  @override
  String get consultations => 'Konsultacije';

  @override
  String get consultationsSubtitle =>
      'Ostanite usklađeni sa svojim nutricionistom';

  @override
  String get scheduleConsultation => 'Zakažite konsultacije';

  @override
  String get noConsultationsYet => 'Još uvek nema konsultacija';

  @override
  String get noConsultationsYetBody =>
      'Otpremite plan obroka ili se povežite sa svojim nutricionistom da biste videli predstojeće termine.';

  @override
  String get uploadMealPlan => 'Otpremite plan obroka';

  @override
  String get glycemicIndexQuickGuide => 'Brzi vodič za glikemijski indeks';

  @override
  String get glycemicIndexQuickGuideBody =>
      'Koristite ovaj vodič da odlučite da li obrok povećava nivo šećera u krvi.';

  @override
  String get gotIt => 'Razumem';

  @override
  String get mealMarkedAsSkipped => 'Obrok je označen kao preskočen';

  @override
  String get unplannedMealLogged => 'Neplanirani obrok je zabeležen';

  @override
  String get newMealPlanProcessed =>
      'Odlično! Novi plan obroka će biti obrađen i povezan sa vašom konsultacijom.';

  @override
  String get uploadMealPlanToGetStarted =>
      'Otpremite plan obroka da biste započeli';

  @override
  String mealLoggedSuccess(String mealName) {
    return 'Samo tako nastavi! $mealName je zabeležen.';
  }

  @override
  String alternativeLoggedSuccess(String mealName) {
    return 'Dobra odluka. Vaša alternativa za $mealName je zabeležena.';
  }

  @override
  String get groceriesNeedMealPlan =>
      'Potreban vam je plan obroka da biste napravili listu za kupovinu.';

  @override
  String get groceriesNoItemsFound =>
      'Za izabrane dane nisu pronađene namirnice.';

  @override
  String groceriesConversionError(String preview, String suffix) {
    return 'Neke stavke nije bilo moguće pretvoriti u grame: $preview$suffix.';
  }

  @override
  String get groceriesAddCustomItem => 'Dodaj prilagođenu stavku';

  @override
  String get groceriesIngredientName => 'Naziv sastojka';

  @override
  String get groceriesIngredientNameHint => 'npr. dodatne banane';

  @override
  String get groceriesIngredientNameError => 'Molimo unesite naziv sastojka';

  @override
  String get groceriesQuantityGrams => 'Količina (grami)';

  @override
  String get groceriesQuantityGramsHint => 'npr. 250';

  @override
  String get groceriesQuantityGramsError => 'Molimo unesite količinu u gramima';

  @override
  String get groceriesPositiveNumberError => 'Unesite pozitivan broj';

  @override
  String get cancel => 'Otkaži';

  @override
  String get add => 'Dodaj';

  @override
  String get groceriesNoItemsToShare => 'Nema stavki za deljenje.';

  @override
  String get groceriesList => 'Lista za kupovinu';

  @override
  String groceriesShoppingForDays(int days) {
    return 'Kupovina za $days dan(a)';
  }

  @override
  String groceriesGeneratedOn(String date) {
    return 'Generisano $date';
  }

  @override
  String groceriesShareError(String error) {
    return 'Nije moguće podeliti listu za kupovinu: $error';
  }

  @override
  String get groceriesTitle => 'Lista za kupovinu';

  @override
  String groceriesSubtitle(int days) {
    return 'Kupovina za $days dan(a)';
  }

  @override
  String get groceriesStep1Title => 'Izaberite period planiranja';

  @override
  String get groceriesStep1Subtitle => 'Za koliko dana obroka kupujete?';

  @override
  String get groceriesGenerateButton => 'Generiši listu za kupovinu';

  @override
  String get groceriesStep2Title => 'Pregledajte i prilagodite';

  @override
  String get groceriesStep2Subtitle =>
      'Uklonite sve što već imate i dodajte dodatne stavke.';

  @override
  String get groceriesGeneratedListPlaceholder =>
      'Vaša generisana lista će se pojaviti ovde. Dodirnite dugme iznad kada izaberete za koliko dana želite da kupujete.';

  @override
  String get groceriesAddCustomItemButton => 'Dodaj prilagođenu stavku';

  @override
  String get groceriesStep3Title => 'Podelite svoju listu';

  @override
  String get groceriesStep3Subtitle =>
      'Pošaljite na svoj telefon, treneru ili bilo kome ko pomaže u kupovini.';

  @override
  String get groceriesShareButton => 'Podeli listu za kupovinu';

  @override
  String get groceriesRemoveItem => 'Ukloni stavku';

  @override
  String get groceriesCustom => 'prilagođeno';

  @override
  String get groceriesEstimated => 'procenjeno';

  @override
  String groceriesDays(int days) {
    return '$days dana';
  }

  @override
  String get groceriesCustomRange => 'Ili postavite prilagođeni opseg';

  @override
  String groceriesDayRange(int days) {
    return '$days dan(a)';
  }

  @override
  String get mealPlanOverviewTitle => 'Pregled plana obroka';

  @override
  String get noMealPlanAvailable => 'Nema dostupnog plana obroka';

  @override
  String get noMealsScheduled => 'Nema zakazanih obroka';

  @override
  String get day_monday => 'Ponedeljak';

  @override
  String get day_tuesday => 'Utorak';

  @override
  String get day_wednesday => 'Sreda';

  @override
  String get day_thursday => 'Četvrtak';

  @override
  String get day_friday => 'Petak';

  @override
  String get day_saturday => 'Subota';

  @override
  String get day_sunday => 'Nedelja';

  @override
  String get mealPlanProcessing_title => 'Priprema vašeg plana';

  @override
  String get mealPlanProcessing_stageUploading_title =>
      'Otpremanje vašeg plana';

  @override
  String get mealPlanProcessing_stageUploading_subtitle =>
      'Bezbedno slanje na IRresistible servere';

  @override
  String get mealPlanProcessing_stageAnalyzing_title => 'Analiziranje detalja';

  @override
  String get mealPlanProcessing_stageAnalyzing_subtitle =>
      'Razumevanje ciljeva ishrane';

  @override
  String get mealPlanProcessing_stageExtracting_title => 'Izdvajanje obroka';

  @override
  String get mealPlanProcessing_stageExtracting_subtitle =>
      'Hvatanje obroka i dodataka ishrani';

  @override
  String get mealPlanProcessing_stageFinalizing_title => 'Završni detalji';

  @override
  String get mealPlanProcessing_stageFinalizing_subtitle =>
      'Primena IRresistible strukture';

  @override
  String mealPlanProcessing_progress(String progress) {
    return 'Napredak $progress';
  }

  @override
  String get mealPlanProcessing_cancel => 'Otkaži i izaberi drugu datoteku';

  @override
  String get mealPlanReview_title => 'Pregledaj plan obroka';

  @override
  String get mealPlanReview_changeFile => 'Promeni datoteku';

  @override
  String get mealPlanReview_confirmPlan => 'Potvrdi plan';

  @override
  String get menuProgress => 'Napredak';

  @override
  String get dashboardMenu_closeMenu => 'Zatvori meni';

  @override
  String get glycemicInfo_lowTitle => 'Nizak GI (0-55)';

  @override
  String get glycemicInfo_lowDesc =>
      'Stabilna energija, najbolje za održavanje uravnoteženog šećera u krvi.';

  @override
  String get glycemicInfo_lowExample1 => 'Lisnato povrće, povrće bez skroba';

  @override
  String get glycemicInfo_lowExample2 => 'Pasulj, sočivo, leblebije';

  @override
  String get glycemicInfo_lowExample3 =>
      'Integral žitarice poput ječma ili kinoe';

  @override
  String get glycemicInfo_mediumTitle => 'Srednji GI (56-69)';

  @override
  String get glycemicInfo_mediumDesc =>
      'Umeren uticaj, uravnotežite proteinima ili zdravim mastima.';

  @override
  String get glycemicInfo_mediumExample1 => 'Hleb od celog zrna, ovas';

  @override
  String get glycemicInfo_mediumExample2 => 'Kukuruz šećerac, slatki krompir';

  @override
  String get glycemicInfo_mediumExample3 =>
      'Tropsko voće poput ananasa ili manga';

  @override
  String get glycemicInfo_highTitle => 'Visok GI (70+)';

  @override
  String get glycemicInfo_highDesc =>
      'Brzo povećava šećer u krvi; ograničite kada je moguće.';

  @override
  String get glycemicInfo_highExample1 => 'Beli hleb, đevreci, perece';

  @override
  String get glycemicInfo_highExample2 =>
      'Zasećerene žitarice, slatkiši, peciva';

  @override
  String get glycemicInfo_highExample3 =>
      'Beli pirinač, pomfrit, prerađene grickalice';

  @override
  String get swipeCoach_followedPlan => 'Pratio plan';

  @override
  String get swipeCoach_skippedMeal => 'Preskočio obrok';

  @override
  String get quickActions_groceriesTitle => 'Namirnice';

  @override
  String get quickActions_groceriesSubtitle => 'Napravi listu';

  @override
  String get quickActions_addUnplannedTitle => 'Dodaj neplanirano';

  @override
  String get quickActions_addUnplannedSubtitle => 'Zapiši obrok';

  @override
  String get alternativeMeal_addUnplannedTitle => 'Dodaj neplanirani obrok';

  @override
  String get alternativeMeal_logAlternativeTitle => 'Zapiši alternativu';

  @override
  String get alternativeMeal_whatDidYouEat => 'Šta ste jeli?';

  @override
  String get alternativeMeal_whatDidYouEatInstead =>
      'Šta ste jeli umesto toga?';

  @override
  String get alternativeMeal_describeMeal => 'Opišite obrok...';

  @override
  String get alternativeMeal_describeMealHad =>
      'Opišite obrok koji ste imali...';

  @override
  String get alternativeMeal_validationError => 'Molimo vas dajte kratak opis';

  @override
  String get alternativeMeal_notesOptional => 'Beleške (opciono)';

  @override
  String get alternativeMeal_bloodSugarImpact => 'Uticaj na šećer u krvi';

  @override
  String get alternativeMeal_containsSugar => 'Sadrži dodatni šećer';

  @override
  String get alternativeMeal_containsSugarSubtitle =>
      'Označite ako alternativni obrok uključuje rafinisani šećer ili slatke sirupe.';

  @override
  String get alternativeMeal_highGI => 'Visok glikemijski indeks';

  @override
  String get alternativeMeal_highGISubtitle =>
      'Izaberite kada je verovatno da će obrok izazvati nagli skok šećera u krvi.';

  @override
  String get alternativeMeal_saveMeal => 'Sačuvaj obrok';

  @override
  String get alternativeMeal_saveAlternative => 'Sačuvaj alternativu';

  @override
  String get alternativeMeal_saving => 'Čuvanje...';

  @override
  String get consultationSchedule_title => 'Zakažite konsultacije';

  @override
  String get consultationSchedule_nutritionistName => 'Ime nutricioniste';

  @override
  String get consultationSchedule_selectDate => 'Izaberite datum';

  @override
  String get consultationSchedule_selectTime => 'Izaberite vreme';

  @override
  String get consultationSchedule_videoCall => 'Video poziv';

  @override
  String get consultationSchedule_inPerson => 'Lično';

  @override
  String get consultationSchedule_phone => 'Telefon';

  @override
  String get consultationSchedule_format => 'Format';

  @override
  String get consultationSchedule_location => 'Lokacija';

  @override
  String get consultationSchedule_meetingLink => 'Link sastanka';

  @override
  String get consultationSchedule_prepNotes =>
      'Beleške za pripremu (odvojene zarezom)';

  @override
  String get consultationSchedule_saveButton => 'Sačuvaj termin';

  @override
  String get consultationCard_mealPlanInEffect => 'Plan obroka na snazi';

  @override
  String get consultationCard_focusAreas => 'Oblasti fokusa';

  @override
  String get consultationCard_preparation => 'Priprema';

  @override
  String get consultationCard_happeningNow => 'Dešava se sada';

  @override
  String consultationCard_inDays(int count) {
    return 'Za $count dana';
  }

  @override
  String get consultationCard_inDay => 'Za 1 dan';

  @override
  String consultationCard_inHours(int count) {
    return 'Za $count sati';
  }

  @override
  String get consultationCard_inHour => 'Za 1 sat';

  @override
  String consultationCard_inMinutes(int count) {
    return 'Za $count minuta';
  }

  @override
  String get consultationCard_inMinute => 'Za 1 minut';

  @override
  String consultationCard_daysAgo(int count) {
    return 'Pre $count dana';
  }

  @override
  String get consultationCard_dayAgo => 'Pre 1 dan';

  @override
  String consultationCard_hoursAgo(int count) {
    return 'Pre $count sati';
  }

  @override
  String get consultationCard_hourAgo => 'Pre 1 sat';

  @override
  String consultationCard_minutesAgo(int count) {
    return 'Pre $count minuta';
  }

  @override
  String get consultationCard_minuteAgo => 'Pre 1 minut';

  @override
  String get consultationOverview_upcoming => 'Predstojeće';

  @override
  String get consultationOverview_nextAppointment => 'Sledeći termin';

  @override
  String get consultationOverview_addedToSchedule => 'Dodato u raspored';

  @override
  String get consultationOverview_addToSchedule => 'Dodaj u raspored';

  @override
  String get consultationOverview_prepareReport => 'Pripremi izveštaj';

  @override
  String get consultationOverview_mostRecent => 'Najnovija poseta';

  @override
  String get consultationOverview_lastAppointment => 'Poslednji termin';

  @override
  String get consultationOverview_linkMealPlan => 'Poveži trenutni plan obroka';

  @override
  String get consultationOverview_viewMealPlan => 'Pogledaj plan obroka';

  @override
  String get consultationHistory_title => 'Istorija';

  @override
  String get consultationHistory_consultationPrefix => 'Konsultacija';

  @override
  String get consultationFollowup_title => 'Kako je prošlo?';

  @override
  String consultationFollowup_subtitle(String date) {
    return 'Vaša konsultacija $date je možda ažurirala vaš plan obroka.';
  }

  @override
  String get consultationFollowup_body =>
      'Ako ste primili novi plan obroka ili promene, možete ih sada otpremiti kako bismo odmah prilagodili vaš raspored.';

  @override
  String get consultationFollowup_highlights => 'Izdvajamo';

  @override
  String get consultationFollowup_uploadNewPlan => 'Otpremi novi plan';

  @override
  String get consultationFollowup_reviewNotes => 'Pregledaj beleške';

  @override
  String get consultationReminder_title => 'Konsultacije uskoro';

  @override
  String consultationReminder_body(String name) {
    return 'Pripremite svoje beleške tako da $name ima najnovije uvide. Generisanje izveštaja sada drži sve spremnim za zajednički pregled.';
  }

  @override
  String get consultationReminder_viewAgenda => 'Pogledaj dnevni red';

  @override
  String get consultationReminder_happeningSoon => 'Uskoro';

  @override
  String get consultationReminder_tomorrow => 'Sutra';

  @override
  String get openReport => 'Otvori izveštaj';

  @override
  String get report_followed => 'Praćeno';

  @override
  String get report_alternatives => 'Alternative';

  @override
  String get report_skipped => 'Preskočeno';

  @override
  String get report_totalLogs => 'Ukupno zapisa';

  @override
  String get report_snapshotSummary => 'Rezime snimka';

  @override
  String get report_longestStreak => 'Najduži niz';

  @override
  String report_asOfDate(String date) {
    return 'Na dan $date';
  }

  @override
  String get report_mealsWithSugar => 'Obroci sa šećerom';

  @override
  String get report_highGIMeals => 'Obroci sa visokim GI';

  @override
  String get progress_logToUnlock =>
      'Zapišite svoje obroke da otključate uvide u napredak';

  @override
  String get progress_logToStartStreak =>
      'Zapišite svoje obroke da započnete niz';

  @override
  String get streak_fire => 'Neverovatan niz! Održavajte vatru! 🔥';

  @override
  String get streak_stacking =>
      'Neverovatna doslednost — nastavite da slažete dane! 💪';

  @override
  String get streak_strongStart => 'Snažan početak — hajde da ga produžimo! 🚀';

  @override
  String get streak_owningWeek => 'Obrok po obrok, vladate ovom nedeljom! 🍽️';

  @override
  String get streak_momentum =>
      'Jedan po jedan obrok — zadržite taj momentum! 🙌';

  @override
  String get streak_freshDay => 'Svež dan, nova prilika da zablistate! 🌟';

  @override
  String get progress_dailyHistory => 'Dnevna istorija';

  @override
  String get progress_allLogs => 'Svi vaši zapisi';

  @override
  String get progress_noMealsLogged => 'Još uvek nema zabeleženih obroka';

  @override
  String get progress_logFirstMeal =>
      'Zapišite svoj prvi obrok da započnete vremensku liniju napretka.';

  @override
  String get report_progressReportTitle => 'Izveštaj o napretku';

  @override
  String get report_shareTooltip => 'Podeli izveštaj';

  @override
  String report_shareError(String error) {
    return 'Greška pri deljenju izveštaja: $error';
  }

  @override
  String get reportText_title => 'Izveštaj o napretku';

  @override
  String reportText_client(String name) {
    return 'Klijent: $name';
  }

  @override
  String reportText_email(String email) {
    return 'E-pošta: $email';
  }

  @override
  String reportText_period(String start, String end) {
    return 'Period: $start - $end';
  }

  @override
  String get reportText_summary => 'Rezime:';

  @override
  String reportText_totalMeals(int count) {
    return 'Ukupno obroka: $count';
  }

  @override
  String reportText_mealsFollowed(int count) {
    return 'Praćeni obroci: $count';
  }

  @override
  String reportText_mealsAlternatives(int count) {
    return 'Alternativni obroci: $count';
  }

  @override
  String reportText_mealsSkipped(int count) {
    return 'Preskočeni obroci: $count';
  }

  @override
  String reportText_mealsDue(int count) {
    return 'Dospeli obroci do sada: $count';
  }

  @override
  String reportText_unloggedDue(int count) {
    return 'Nezabeleženi dospeli obroci: $count';
  }

  @override
  String reportText_longestStreak(String streak) {
    return 'Najduži niz: $streak';
  }

  @override
  String reportText_mealsWithSugar(int count) {
    return 'Obroci sa šećerom: $count';
  }

  @override
  String reportText_mealsHighGI(int count) {
    return 'Obroci sa visokim glikemijskim indeksom: $count';
  }

  @override
  String get reportText_dailyBreakdown => 'Dnevni pregled:';

  @override
  String reportText_notes(String notes) {
    return '    Beleške: $notes';
  }

  @override
  String get reportGen_title => 'Generiši izveštaj';

  @override
  String get reportGen_subtitle => 'Rezimei spremni za deljenje';

  @override
  String get reportGen_choosePeriod => 'Izaberite period';

  @override
  String get reportGen_periodDesc =>
      'Sumiraćemo sve aktivnosti u okviru izabranog opsega.';

  @override
  String get reportGen_last7Days => 'Poslednjih 7 dana';

  @override
  String get reportGen_last30Days => 'Poslednjih 30 dana';

  @override
  String get reportGen_customRange => 'Prilagođeni opseg';

  @override
  String get reportGen_from => 'Od';

  @override
  String get reportGen_to => 'Do';

  @override
  String get reportGen_includeTitle => 'Vaš izveštaj će uključivati';

  @override
  String get reportGen_include1 => 'Kompletna istorija zapisa obroka za period';

  @override
  String get reportGen_include2 => 'Uvidi u pridržavanje i doslednost';

  @override
  String get reportGen_include3 => 'Beleške klijenta i alternativni izbori';

  @override
  String get reportGen_include4 => 'Nedeljni rezimei spremni za deljenje';

  @override
  String get reportGen_button => 'Generiši izveštaj';

  @override
  String get uploadPlan_title => 'Otpremite svoj plan obroka';

  @override
  String get uploadPlan_subtitle =>
      'Izaberite datoteku plana obroka da biste započeli';

  @override
  String get uploadPlan_fileSelected => 'Datoteka izabrana';

  @override
  String get uploadPlan_tapToSelect => 'Dodirnite da izaberete datoteku';

  @override
  String get uploadPlan_fileFormats => 'PDF, DOC ili bilo koji format datoteke';

  @override
  String get continueButton => 'Nastavi';

  @override
  String get mealDrawer_ingredients => 'Sastojci';

  @override
  String get mealDrawer_noIngredients => 'Nema liste sastojaka za ovaj obrok.';

  @override
  String get mealDrawer_preparation => 'Priprema';

  @override
  String get mealDrawer_noPrep => 'Nema uputstava za pripremu za ovaj obrok.';

  @override
  String get appName => 'IRresistible';

  @override
  String get settings_debug => 'Otklanjanje grešaka';

  @override
  String get settings_skipOnboarding => 'Preskoči uvod';

  @override
  String get splashTitle => 'IRresistible';

  @override
  String get splashSubtitle => 'Vaše personalizovano putovanje u ishrani';

  @override
  String get mock_meal_1_breakfast_name => 'Ovsena kaša sa bobičastim voćem';

  @override
  String get mock_meal_1_breakfast_desc =>
      '1 šolja kuvane ovsene kaše, 1/2 šolje mešanog bobičastog voća, 1 kašika putera od badema, med';

  @override
  String get mock_meal_1_snack1_name => 'Jabuka sa puterom od badema';

  @override
  String get mock_meal_1_snack1_desc =>
      '1 srednja jabuka, 1 kašika putera od badema';

  @override
  String get mock_meal_1_lunch_name => 'Salata sa grilovanom piletinom';

  @override
  String get mock_meal_1_lunch_desc =>
      '120g grilovane pilećih prsa, mešana zelena salata, čeri paradajz, krastavac, preliv od maslinovog ulja';

  @override
  String get mock_meal_1_snack2_name => 'Grčki jogurt sa bobičastim voćem';

  @override
  String get mock_meal_1_snack2_desc =>
      '1 šolja običnog grčkog jogurta, 1/4 šolje mešanog bobičastog voća';

  @override
  String get mock_meal_1_dinner_name => 'Pečeni losos sa povrćem';

  @override
  String get mock_meal_1_dinner_desc =>
      '150g fileta lososa, pečeni brokoli i slatki krompir';

  @override
  String get mock_meal_1_breakfast_ingredient_0 =>
      '1 šolja kuvanih zobenih pahuljica';

  @override
  String get mock_meal_1_breakfast_ingredient_1 => '1/2 šolje mešanih bobica';

  @override
  String get mock_meal_1_breakfast_ingredient_2 => '1 kašika bademovog putera';

  @override
  String get mock_meal_1_breakfast_ingredient_3 => '1 kašičica meda';

  @override
  String get mock_meal_1_breakfast_instruction_0 =>
      'Kuvati zobene pahuljice sa vodom ili mlekom dok ne postanu kremaste.';

  @override
  String get mock_meal_1_breakfast_instruction_1 =>
      'Posuti mešanim bobama, bademovim puterom i kapljicom meda.';

  @override
  String get mock_meal_1_snack1_ingredient_0 => '1 srednja jabuka';

  @override
  String get mock_meal_1_snack1_ingredient_1 => '1 kašika bademovog putera';

  @override
  String get mock_meal_1_snack1_instruction_0 =>
      'Iseći jabuku na kriške ili kolutove.';

  @override
  String get mock_meal_1_snack1_instruction_1 =>
      'Servirati sa bademovim puterom za umakanje ili mazanje.';

  @override
  String get mock_meal_1_lunch_ingredient_0 => '120g pečenog pilećeg filea';

  @override
  String get mock_meal_1_lunch_ingredient_1 => '2 šolje mešanog zelenog salata';

  @override
  String get mock_meal_1_lunch_ingredient_2 => '1/2 šolje čeri paradajza';

  @override
  String get mock_meal_1_lunch_ingredient_3 => '1/2 krastavac';

  @override
  String get mock_meal_1_lunch_ingredient_4 =>
      '2 kašike preliva od maslinovog ulja';

  @override
  String get mock_meal_1_lunch_instruction_0 => 'Iseći pečeno pile i povrće.';

  @override
  String get mock_meal_1_lunch_instruction_1 =>
      'Sve kombinovati u činiji i preliti prelivom od maslinovog ulja.';

  @override
  String get mock_meal_1_snack2_ingredient_0 =>
      '1 šolja običnog grčkog jogurta';

  @override
  String get mock_meal_1_snack2_ingredient_1 => '1/4 šolje mešanih bobica';

  @override
  String get mock_meal_1_snack2_instruction_0 => 'Staviti jogurt u činiju.';

  @override
  String get mock_meal_1_snack2_instruction_1 =>
      'Posuti mešanim bobama neposredno pre serviranja.';

  @override
  String get mock_meal_1_dinner_ingredient_0 => '150g fileta lososa';

  @override
  String get mock_meal_1_dinner_ingredient_1 => '1 šolja pečenog brokolija';

  @override
  String get mock_meal_1_dinner_ingredient_2 => '1 srednji slatki krompir';

  @override
  String get mock_meal_1_dinner_ingredient_3 => '1 kriška limuna';

  @override
  String get mock_meal_1_dinner_instruction_0 =>
      'Peći začinjeni losos i povrće dok ne postanu mekani.';

  @override
  String get mock_meal_1_dinner_instruction_1 =>
      'Servirati sa prstom limuna preko.';

  @override
  String get mock_meal_2_breakfast_name => 'Kajgana sa tostom od avokada';

  @override
  String get mock_meal_2_breakfast_desc =>
      '2 umućena jaja, 1 kriška integralnog tosta, 1/2 avokada, čeri paradajz';

  @override
  String get mock_meal_2_snack1_name => 'Proteinski smuti';

  @override
  String get mock_meal_2_snack1_desc =>
      'Banana, proteinski prah, bademovo mleko, spanać';

  @override
  String get mock_meal_2_lunch_name => 'Vrap sa ćuretinom i humusom';

  @override
  String get mock_meal_2_lunch_desc =>
      'Integralna tortilja, 120g ćurećih prsa, humus, zelena salata, paprika';

  @override
  String get mock_meal_2_snack2_name => 'Štapići šargarepe sa humusom';

  @override
  String get mock_meal_2_snack2_desc =>
      '1 šolja štapića šargarepe, 1/4 šolje humusa';

  @override
  String get mock_meal_2_dinner_name => 'Piletina u voku';

  @override
  String get mock_meal_2_dinner_desc =>
      '150g pilećih prsa, mešano povrće, smeđi pirinač, terijaki sos';

  @override
  String get mock_meal_2_breakfast_ingredient_0 => '2 velika jaja';

  @override
  String get mock_meal_2_breakfast_ingredient_1 => '1 kriška integralnog hleba';

  @override
  String get mock_meal_2_breakfast_ingredient_2 => '1/2 avokada';

  @override
  String get mock_meal_2_breakfast_ingredient_3 => '4 čeri paradajza';

  @override
  String get mock_meal_2_breakfast_instruction_0 =>
      'Umućiti jaja u nelepljivoj tavi dok ne postanu mekana.';

  @override
  String get mock_meal_2_breakfast_instruction_1 =>
      'Ispeći hleb, staviti zgnječen avokado i servirati sa paradajzom.';

  @override
  String get mock_meal_2_snack1_ingredient_0 => '1 banana';

  @override
  String get mock_meal_2_snack1_ingredient_1 => '1 merica proteinskog praha';

  @override
  String get mock_meal_2_snack1_ingredient_2 => '1 šolja bademovog mleka';

  @override
  String get mock_meal_2_snack1_ingredient_3 => '1 šolja spanaća';

  @override
  String get mock_meal_2_snack1_instruction_0 =>
      'Dodati sve sastojke u blender.';

  @override
  String get mock_meal_2_snack1_instruction_1 =>
      'Blendovati dok ne postane glatko i kremasto, zatim odmah servirati.';

  @override
  String get mock_meal_2_lunch_ingredient_0 => '1 integralna tortilja';

  @override
  String get mock_meal_2_lunch_ingredient_1 => '120g isečene ćureće prsa';

  @override
  String get mock_meal_2_lunch_ingredient_2 => '2 kašike humusa';

  @override
  String get mock_meal_2_lunch_ingredient_3 => '1 šolja salate';

  @override
  String get mock_meal_2_lunch_ingredient_4 => '1/4 šolje isečene paprike';

  @override
  String get mock_meal_2_lunch_instruction_0 =>
      'Namazati humus preko tortilje.';

  @override
  String get mock_meal_2_lunch_instruction_1 =>
      'Složiti ćureće meso, salatu i papriku, zatim čvrsto zamotati i iseći.';

  @override
  String get mock_meal_2_snack2_ingredient_0 => '1 šolja štapića mrkve';

  @override
  String get mock_meal_2_snack2_ingredient_1 => '1/4 šolje humusa';

  @override
  String get mock_meal_2_snack2_instruction_0 =>
      'Oguliti i iseći mrkvu u štapiće ako je potrebno.';

  @override
  String get mock_meal_2_snack2_instruction_1 =>
      'Servirati sa humusom za umakanje.';

  @override
  String get mock_meal_2_dinner_ingredient_0 => '150g pilećih prsa';

  @override
  String get mock_meal_2_dinner_ingredient_1 => '2 šolje mešanog povrća';

  @override
  String get mock_meal_2_dinner_ingredient_2 => '1 šolja braon pirinča';

  @override
  String get mock_meal_2_dinner_ingredient_3 => '2 kašike terijaki sosa';

  @override
  String get mock_meal_2_dinner_instruction_0 =>
      'Pržiti pile dok ne bude skoro gotovo.';

  @override
  String get mock_meal_2_dinner_instruction_1 =>
      'Dodati povrće i sos, kuvati dok ne postane hrskavo-mekano, i servirati preko pirinča.';

  @override
  String get mock_meal_3_breakfast_name => 'Parfe od grčkog jogurta';

  @override
  String get mock_meal_3_breakfast_desc =>
      'Grčki jogurt sa granolom, bobičastim voćem i medom';

  @override
  String get mock_meal_3_snack1_name => 'Mešani orašasti plodovi';

  @override
  String get mock_meal_3_snack1_desc =>
      '1/4 šolje mešanih badema, indijskih oraha i oraha';

  @override
  String get mock_meal_3_lunch_name => 'Kinoa Buda činija';

  @override
  String get mock_meal_3_lunch_desc =>
      'Kinoa, pečene leblebije, avokado, povrće, tahini preliv';

  @override
  String get mock_meal_3_snack2_name => 'Sveži sir sa ananasom';

  @override
  String get mock_meal_3_snack2_desc =>
      '1 šolja nemasnog svežeg sira, 1/2 šolje komadića ananasa';

  @override
  String get mock_meal_3_dinner_name => 'Takosi sa nemasnom govedinom';

  @override
  String get mock_meal_3_dinner_desc =>
      'Nemasna mlevena govedina, kukuruzne tortilje, zelena salata, paradajz, salsa';

  @override
  String get mock_meal_3_breakfast_ingredient_0 => '1 šolja grčkog jogurta';

  @override
  String get mock_meal_3_breakfast_ingredient_1 => '1/2 šolje granole';

  @override
  String get mock_meal_3_breakfast_ingredient_2 => '1/2 šolje mešanih bobica';

  @override
  String get mock_meal_3_breakfast_ingredient_3 => '1 kašičica meda';

  @override
  String get mock_meal_3_breakfast_instruction_0 =>
      'Složiti jogurt, granolu i bobice u čašu ili činiju.';

  @override
  String get mock_meal_3_breakfast_instruction_1 =>
      'Preliti medom preko pre serviranja.';

  @override
  String get mock_meal_3_snack1_ingredient_0 =>
      '1/4 šolje mešanih orašastih plodova';

  @override
  String get mock_meal_3_snack1_instruction_0 =>
      'Podeliti mešane orašaste plodove u malu činiju ili kontejner.';

  @override
  String get mock_meal_3_snack1_instruction_1 =>
      'Uživati odmah ili spakovati za kasnije.';

  @override
  String get mock_meal_3_lunch_ingredient_0 => '1 šolja kuvanog kvinoe';

  @override
  String get mock_meal_3_lunch_ingredient_1 => '1/2 šolje pečenog leblebija';

  @override
  String get mock_meal_3_lunch_ingredient_2 => '1/2 avokada';

  @override
  String get mock_meal_3_lunch_ingredient_3 => '1 šolja mešanog povrća';

  @override
  String get mock_meal_3_lunch_ingredient_4 => '2 kašike tahini preliva';

  @override
  String get mock_meal_3_lunch_instruction_0 =>
      'Zagrejati kvinoju i rasporediti u činiju.';

  @override
  String get mock_meal_3_lunch_instruction_1 =>
      'Posuti leblebijem, povrćem, avokadom i preliti tahini prelivom.';

  @override
  String get mock_meal_3_snack2_ingredient_0 => '1 šolja nemasnog sira';

  @override
  String get mock_meal_3_snack2_ingredient_1 => '1/2 šolje komada ananasa';

  @override
  String get mock_meal_3_snack2_instruction_0 =>
      'Staviti sir u činiju za serviranje.';

  @override
  String get mock_meal_3_snack2_instruction_1 =>
      'Posuti komadima ananasa i uživati.';

  @override
  String get mock_meal_3_dinner_ingredient_0 => '150g mlevenog goveđeg mesa';

  @override
  String get mock_meal_3_dinner_ingredient_1 => '2 kukuruzne tortilje';

  @override
  String get mock_meal_3_dinner_ingredient_2 => '1 šolja iseckane salate';

  @override
  String get mock_meal_3_dinner_ingredient_3 => '1 isečen paradajz';

  @override
  String get mock_meal_3_dinner_ingredient_4 => '2 kašike salse';

  @override
  String get mock_meal_3_dinner_instruction_0 =>
      'Kuvati mleveno meso sa začinima dok ne porumeni.';

  @override
  String get mock_meal_3_dinner_instruction_1 =>
      'Zagrejati tortilje, zatim sastaviti sa salatom, paradajzom i salsom.';

  @override
  String get mock_meal_4_breakfast_name => 'Palačinke od integralnog brašna';

  @override
  String get mock_meal_4_breakfast_desc =>
      '2 integralne palačinke, sveže bobičasto voće, javorov sirup';

  @override
  String get mock_meal_4_snack1_name => 'Kruška sa sirom';

  @override
  String get mock_meal_4_snack1_desc => '1 srednja kruška, 1 komad sira';

  @override
  String get mock_meal_4_lunch_name => 'Salata od tunjevine';

  @override
  String get mock_meal_4_lunch_desc =>
      'Tunjevina, mešana zelena salata, tvrdo kuvano jaje, masline, maslinovo ulje';

  @override
  String get mock_meal_4_snack2_name => 'Proteinska pločica';

  @override
  String get mock_meal_4_snack2_desc =>
      '1 proteinska pločica (ciljajte 10g+ proteina)';

  @override
  String get mock_meal_4_dinner_name => 'Pečena piletina sa kinoom';

  @override
  String get mock_meal_4_dinner_desc =>
      'Pileća prsa u korici od bilja, kinoa, pečena špargla';

  @override
  String get mock_meal_4_breakfast_ingredient_0 => '2 integralne palačinke';

  @override
  String get mock_meal_4_breakfast_ingredient_1 =>
      '1/2 šolje svežeg bobičastog voća';

  @override
  String get mock_meal_4_breakfast_ingredient_2 => '1 kašika javorovog sirupa';

  @override
  String get mock_meal_4_breakfast_instruction_0 =>
      'Zagrejati palačinke u tavi ili tosteru ako je potrebno.';

  @override
  String get mock_meal_4_breakfast_instruction_1 =>
      'Servirati sa bobičastim voćem preko i preliti javorovim sirupom.';

  @override
  String get mock_meal_4_snack1_ingredient_0 => '1 srednja kruška';

  @override
  String get mock_meal_4_snack1_ingredient_1 => '1 štapić sira';

  @override
  String get mock_meal_4_snack1_instruction_0 =>
      'Oprati krušku i iseći ako želite.';

  @override
  String get mock_meal_4_snack1_instruction_1 =>
      'Kombinovati sa štapićem sira za brzi međuobrok.';

  @override
  String get mock_meal_4_lunch_ingredient_0 => '1 konzerva tunjevine u vodi';

  @override
  String get mock_meal_4_lunch_ingredient_1 => '2 šolje mešanog zelenog salata';

  @override
  String get mock_meal_4_lunch_ingredient_2 => '1 tvrdo kuvano jaje';

  @override
  String get mock_meal_4_lunch_ingredient_3 => '5 maslina';

  @override
  String get mock_meal_4_lunch_ingredient_4 => '2 kašike maslinovog ulja';

  @override
  String get mock_meal_4_lunch_instruction_0 =>
      'Ocediti tunjevinu i iseći jaje i masline.';

  @override
  String get mock_meal_4_lunch_instruction_1 =>
      'Kombinovati sastojke sa zelenim salatom i preliti maslinovim uljem.';

  @override
  String get mock_meal_4_snack2_ingredient_0 => '1 proteinski bar';

  @override
  String get mock_meal_4_snack2_instruction_0 =>
      'Raspakovati proteinski bar i uživati kao brzi međuobrok.';

  @override
  String get mock_meal_4_dinner_ingredient_0 => '150g pilećih prsa';

  @override
  String get mock_meal_4_dinner_ingredient_1 => '1 šolja kuvanog kvinoe';

  @override
  String get mock_meal_4_dinner_ingredient_2 => '1 šolja pečenog špargle';

  @override
  String get mock_meal_4_dinner_ingredient_3 =>
      'po ukusu začini i začinska zrna';

  @override
  String get mock_meal_4_dinner_instruction_0 =>
      'Peći začinjena pileća prsa dok ne budu gotova.';

  @override
  String get mock_meal_4_dinner_instruction_1 =>
      'Servirati uz kvinoju i pečeni špargla.';

  @override
  String get mock_meal_5_breakfast_name => 'Omlet sa povrćem';

  @override
  String get mock_meal_5_breakfast_desc =>
      'Omlet od 3 jaja sa spanaćem, pečurkama i feta sirom';

  @override
  String get mock_meal_5_snack1_name => 'Banana sa puterom od kikirikija';

  @override
  String get mock_meal_5_snack1_desc =>
      '1 srednja banana, 1 kašika putera od kikirikija';

  @override
  String get mock_meal_5_lunch_name => 'Mediteranska piletina činija';

  @override
  String get mock_meal_5_lunch_desc =>
      'Grilovana piletina, smeđi pirinač, humus, krastavac, paradajz, masline';

  @override
  String get mock_meal_5_snack2_name => 'Pirinčane galete sa avokadom';

  @override
  String get mock_meal_5_snack2_desc =>
      '2 pirinčane galete prelivene izgnječenim avokadom';

  @override
  String get mock_meal_5_dinner_name => 'Testenina sa škampima Primavera';

  @override
  String get mock_meal_5_dinner_desc =>
      'Integralna testenina, škampi, mešano povrće, beli luk i maslinovo ulje';

  @override
  String get mock_meal_5_breakfast_ingredient_0 => '3 velika jaja';

  @override
  String get mock_meal_5_breakfast_ingredient_1 => '1 šolja spanaća';

  @override
  String get mock_meal_5_breakfast_ingredient_2 => '1/2 šolje pečuraka';

  @override
  String get mock_meal_5_breakfast_ingredient_3 => '2 kašike feta sira';

  @override
  String get mock_meal_5_breakfast_instruction_0 =>
      'Dinstati pečurke i spanać dok ne postanu mekani.';

  @override
  String get mock_meal_5_breakfast_instruction_1 =>
      'Dodati umućena jaja, kuvati dok ne postanu čvrsta, i posuti fetom pre savijanja.';

  @override
  String get mock_meal_5_snack1_ingredient_0 => '1 srednja banana';

  @override
  String get mock_meal_5_snack1_ingredient_1 => '1 kašika kikiriki putera';

  @override
  String get mock_meal_5_snack1_instruction_0 =>
      'Oguliti bananu i iseći ako želite.';

  @override
  String get mock_meal_5_snack1_instruction_1 =>
      'Servirati sa kikiriki puterom za umakanje ili mazanje.';

  @override
  String get mock_meal_5_lunch_ingredient_0 => '120g pečene piletine';

  @override
  String get mock_meal_5_lunch_ingredient_1 => '1 šolja braon pirinča';

  @override
  String get mock_meal_5_lunch_ingredient_2 => '2 kašike humusa';

  @override
  String get mock_meal_5_lunch_ingredient_3 => '1/2 krastavac';

  @override
  String get mock_meal_5_lunch_ingredient_4 => '1/2 šolje paradajza';

  @override
  String get mock_meal_5_lunch_ingredient_5 => '5 maslina';

  @override
  String get mock_meal_5_lunch_instruction_0 =>
      'Složiti pirinač u činiju i posuti isečenom piletinom.';

  @override
  String get mock_meal_5_lunch_instruction_1 =>
      'Dodati humus, krastavac, paradajz i masline pre serviranja.';

  @override
  String get mock_meal_5_snack2_ingredient_0 => '2 pirinčane pločice';

  @override
  String get mock_meal_5_snack2_ingredient_1 => '1/2 avokada';

  @override
  String get mock_meal_5_snack2_instruction_0 =>
      'Zgnječiti avokado viljuškom i začiniti ako želite.';

  @override
  String get mock_meal_5_snack2_instruction_1 =>
      'Namazati preko pirinčanih pločica i odmah servirati.';

  @override
  String get mock_meal_5_dinner_ingredient_0 => '60g integralnih testenina';

  @override
  String get mock_meal_5_dinner_ingredient_1 => '150g škampi';

  @override
  String get mock_meal_5_dinner_ingredient_2 => '2 šolje mešanog povrća';

  @override
  String get mock_meal_5_dinner_ingredient_3 =>
      '2 kašike belog luka i maslinovog ulja';

  @override
  String get mock_meal_5_dinner_instruction_0 =>
      'Kuvati testenine dok ne budu al dente i zadržati malo vode za kuvanje.';

  @override
  String get mock_meal_5_dinner_instruction_1 =>
      'Pržiti škampe i povrće u belom luku i ulju, zatim pomešati sa testeninama.';

  @override
  String get mock_meal_6_breakfast_name => 'Burito za doručak';

  @override
  String get mock_meal_6_breakfast_desc =>
      'Kajgana, crni pasulj, sir, salsa u integralnoj tortilji';

  @override
  String get mock_meal_6_snack1_name => 'Mešavina za stazu';

  @override
  String get mock_meal_6_snack1_desc =>
      'Orašasti plodovi, sušene brusnice, komadići tamne čokolade';

  @override
  String get mock_meal_6_lunch_name => 'Sendvič sa grilovanim povrćem';

  @override
  String get mock_meal_6_lunch_desc =>
      'Grilovane tikvice, paprike, mocarela na integralnom hlebu';

  @override
  String get mock_meal_6_snack2_name => 'Edamame';

  @override
  String get mock_meal_6_snack2_desc =>
      '1 šolja parenih edamame zrna sa morskom solju';

  @override
  String get mock_meal_6_dinner_name => 'Grilovani biftek sa povrćem';

  @override
  String get mock_meal_6_dinner_desc =>
      'Nemasni biftek, pečeni prokelj i šargarepa';

  @override
  String get mock_meal_6_breakfast_ingredient_0 => '2 umućena jaja';

  @override
  String get mock_meal_6_breakfast_ingredient_1 => '1/4 šolje crnih pasulja';

  @override
  String get mock_meal_6_breakfast_ingredient_2 => '2 kašike rendanog sira';

  @override
  String get mock_meal_6_breakfast_ingredient_3 => '2 kašike salse';

  @override
  String get mock_meal_6_breakfast_ingredient_4 => '1 integralna tortilja';

  @override
  String get mock_meal_6_breakfast_instruction_0 =>
      'Zagrejati tortilju i umućiti jaja sa pasuljem.';

  @override
  String get mock_meal_6_breakfast_instruction_1 =>
      'Napuniti tortilju, posuti sirom i salsom, zatim čvrsto zamotati.';

  @override
  String get mock_meal_6_snack1_ingredient_0 =>
      '1/4 šolje mešanih orašastih plodova';

  @override
  String get mock_meal_6_snack1_ingredient_1 => '2 kašike suvih brusnica';

  @override
  String get mock_meal_6_snack1_ingredient_2 =>
      '1 kašika tamnih čokoladnih komadića';

  @override
  String get mock_meal_6_snack1_instruction_0 =>
      'Kombinovati orašaste plodove, brusnice i čokoladne komadiće u maloj činiji.';

  @override
  String get mock_meal_6_snack1_instruction_1 =>
      'Podeliti u kontejner za poneti ako je potrebno.';

  @override
  String get mock_meal_6_lunch_ingredient_0 => '2 kriške integralnog hleba';

  @override
  String get mock_meal_6_lunch_ingredient_1 => '1/2 pečena tikvica';

  @override
  String get mock_meal_6_lunch_ingredient_2 => '1/4 šolje pečene paprike';

  @override
  String get mock_meal_6_lunch_ingredient_3 => '2 kriške svežeg mocarela sira';

  @override
  String get mock_meal_6_lunch_ingredient_4 => '1 kašika balzamičnog preliva';

  @override
  String get mock_meal_6_lunch_instruction_0 =>
      'Složiti pečeno povrće i mocarela na hleb.';

  @override
  String get mock_meal_6_lunch_instruction_1 =>
      'Preliti balzamičnim prelivom i ispeći dok se sir ne istopi ako želite.';

  @override
  String get mock_meal_6_snack2_ingredient_0 => '1 šolja edamame';

  @override
  String get mock_meal_6_snack2_ingredient_1 => 'po ukusu morska sol';

  @override
  String get mock_meal_6_snack2_instruction_0 =>
      'Kuvati ili zagrejati edamame u mikrotalasnoj dok ne budu zagrejani.';

  @override
  String get mock_meal_6_snack2_instruction_1 =>
      'Posuti morskom solju pre serviranja.';

  @override
  String get mock_meal_6_dinner_ingredient_0 => '150g mlevenog goveđeg mesa';

  @override
  String get mock_meal_6_dinner_ingredient_1 => '1 šolja pečene prokulice';

  @override
  String get mock_meal_6_dinner_ingredient_2 => '1 šolja pečene šargarepe';

  @override
  String get mock_meal_6_dinner_instruction_0 =>
      'Peći ili pržiti meso dok ne postigne željeni stepen pečenja.';

  @override
  String get mock_meal_6_dinner_instruction_1 =>
      'Servirati sa pečenom prokulicom i šargarepom.';

  @override
  String get mock_meal_7_breakfast_name => 'Prženice sa voćem';

  @override
  String get mock_meal_7_breakfast_desc =>
      'Integralni hleb, sveže bobičasto voće, preliv od jogurta';

  @override
  String get mock_meal_7_snack1_name => 'Celer sa puterom od kikirikija';

  @override
  String get mock_meal_7_snack1_desc =>
      '4 štapića celera sa 2 kašike putera od kikirikija';

  @override
  String get mock_meal_7_lunch_name => 'Cezar salata sa piletinom';

  @override
  String get mock_meal_7_lunch_desc =>
      'Grilovana piletina, rimska salata, parmezan, lagani Cezar preliv';

  @override
  String get mock_meal_7_snack2_name => 'Smuti činija';

  @override
  String get mock_meal_7_snack2_desc =>
      'Blendirano bobičasto voće, banana, preliv od granole i čia semenki';

  @override
  String get mock_meal_7_dinner_name => 'Pečeni bakalar sa slatkim krompirom';

  @override
  String get mock_meal_7_dinner_desc =>
      'Bakalar pečen sa biljem, pire od slatkog krompira, parena boranija';

  @override
  String get mock_meal_7_breakfast_ingredient_0 => '2 kriške integralnog hleba';

  @override
  String get mock_meal_7_breakfast_ingredient_1 => '1 jaje';

  @override
  String get mock_meal_7_breakfast_ingredient_2 => '1/2 šolje mešanih bobica';

  @override
  String get mock_meal_7_breakfast_ingredient_3 => '2 kašike grčkog jogurta';

  @override
  String get mock_meal_7_breakfast_ingredient_4 => '1 kašičica cimeta';

  @override
  String get mock_meal_7_breakfast_instruction_0 =>
      'Umućiti jaje sa cimetom i natopiti kriške hleba.';

  @override
  String get mock_meal_7_breakfast_instruction_1 =>
      'Peći na tavi dok ne porumeni, zatim posuti bobama i jogurtom.';

  @override
  String get mock_meal_7_snack1_ingredient_0 => '4 štapića celera';

  @override
  String get mock_meal_7_snack1_ingredient_1 => '2 kašike kikiriki putera';

  @override
  String get mock_meal_7_snack1_instruction_0 =>
      'Oprati i očistiti štapiće celera.';

  @override
  String get mock_meal_7_snack1_instruction_1 =>
      'Napuniti udubljenja celera kikiriki puterom.';

  @override
  String get mock_meal_7_lunch_ingredient_0 => '120g pečenog pilećeg filea';

  @override
  String get mock_meal_7_lunch_ingredient_1 => '2 šolje romen salate';

  @override
  String get mock_meal_7_lunch_ingredient_2 => '2 kašike parmezana';

  @override
  String get mock_meal_7_lunch_ingredient_3 => '2 kašike lakog cezar preliva';

  @override
  String get mock_meal_7_lunch_ingredient_4 => '1/2 šolje integralnih krutona';

  @override
  String get mock_meal_7_lunch_instruction_0 => 'Iseći salatu i pečeno pile.';

  @override
  String get mock_meal_7_lunch_instruction_1 =>
      'Pomešati sa prelivom, parmezanom i krutonima pre serviranja.';

  @override
  String get mock_meal_7_snack2_ingredient_0 => '1 šolja mešanih bobica';

  @override
  String get mock_meal_7_snack2_ingredient_1 => '1/2 banana';

  @override
  String get mock_meal_7_snack2_ingredient_2 => '1/4 šolje granole';

  @override
  String get mock_meal_7_snack2_ingredient_3 => '1 kašika čija semena';

  @override
  String get mock_meal_7_snack2_instruction_0 =>
      'Blendovati bobice i bananu dok ne postanu glatke.';

  @override
  String get mock_meal_7_snack2_instruction_1 =>
      'Sipati u činiju i posuti granolom i čija semenima.';

  @override
  String get mock_meal_7_dinner_ingredient_0 => '150g fileta bakalara';

  @override
  String get mock_meal_7_dinner_ingredient_1 => '1 srednji slatki krompir';

  @override
  String get mock_meal_7_dinner_ingredient_2 => '1 šolja boranije';

  @override
  String get mock_meal_7_dinner_ingredient_3 => 'po ukusu bilje i limun';

  @override
  String get mock_meal_7_dinner_instruction_0 =>
      'Začiniti bakalara biljem i limunom, zatim peći dok ne postane ljuskav.';

  @override
  String get mock_meal_7_dinner_instruction_1 =>
      'Servirati sa pireom od slatkog krompira i parnom boranijom.';

  @override
  String get dashboard_today => 'Danas';

  @override
  String get dashboard_greeting_unlogged_3 =>
      'Hajde da zabeležimo nekoliko obroka dok su detalji sveži.';

  @override
  String get dashboard_greeting_unlogged_2 =>
      'Dva obroka čekaju zapis – brza ažuriranja puno pomažu.';

  @override
  String get dashboard_greeting_unlogged_1 =>
      'Jednom obroku je potreban brz zapis da bi ostao na pravom putu.';

  @override
  String get dashboard_greeting_all_set => 'Sve je spremno do sledećeg obroka.';

  @override
  String get dashboard_greeting_good_job =>
      'Dobar posao, ostajete u toku – zadržite taj momentum.';

  @override
  String dashboard_status_overdue(int count, String label) {
    return '$count $label kasni';
  }

  @override
  String dashboard_status_logged(int count, String label) {
    return '$count $label zabeleženo';
  }

  @override
  String get mealLabel => 'obrok';

  @override
  String get mealsLabel => 'obroka';

  @override
  String get mock_mealPlanName => 'Plan ishrane za 1. nedelju';

  @override
  String get mock_endurancePlanName => 'Plan podrške izdržljivosti';

  @override
  String get mock_consultation_1_focusArea_0 => 'Stabilizovati natašte glukozu';

  @override
  String get mock_consultation_1_focusArea_1 =>
      'Ponovo uvesti gorivo za trening snage';

  @override
  String get mock_consultation_1_preparationNote_0 =>
      'Otpremiti najnovije izveštaje glukometra';

  @override
  String get mock_consultation_1_preparationNote_1 =>
      'Pratiti hidrataciju 3 dana unapred';

  @override
  String get mock_consultation_2_focusArea_0 =>
      'Optimizovati punjenje gorivom pre trčanja';

  @override
  String get mock_consultation_2_focusArea_1 => 'Prilagoditi ciljeve za vlakna';

  @override
  String get mock_consultation_2_preparationNote_0 =>
      'Doneti dnevnik ishrane za prethodnih 14 dana';

  @override
  String get mock_consultation_2_preparationNote_1 =>
      'Zabeležiti sve simptome hipoglikemije';

  @override
  String get dashboard_catchUp => 'Nadoknadi';

  @override
  String get dashboard_logNow => 'Zapiši sada';

  @override
  String get dashboard_needsAttention => 'Zahteva pažnju';

  @override
  String get dashboard_pendingMealsSwipeHint =>
      'Prevucite zakašnjele i zakazane obroke da biste zadržali svoj dnevnik ažurnim.';

  @override
  String get dashboard_pendingMealsSeveritySeveral =>
      'Nekoliko obroka čeka — zabeležavanje sada održava vaše podatke tačnim.';

  @override
  String get dashboard_pendingMealsSeverityTwo =>
      'Dva obroka zahtevaju pažnju — nekoliko brzih unosa će zatvoriti jaz.';

  @override
  String get dashboard_pendingMealsSeverityOne =>
      'Jedan obrok je spreman za zabeležavanje — odvojite trenutak da ga zabeležite.';

  @override
  String get dashboard_comingUp => 'Uskoro';

  @override
  String get dashboard_nextMeal => 'Sledeći obrok';

  @override
  String get dashboard_logged => 'Zabeleženo';

  @override
  String dashboard_scheduled(String time, String relativeTime) {
    return 'Zakazano $time • $relativeTime';
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
  String get dashboard_logSomethingElse => 'Zapiši nešto drugo';

  @override
  String get dashboard_greatJob => 'Odličan posao!';

  @override
  String get dashboard_noted => 'Zabeleženo';

  @override
  String get dashboard_logSuccess => 'Zapis je uspešno sačuvan';

  @override
  String get dashboard_followedRecipe => 'Recept praćen';

  @override
  String get dashboard_followedMeal => 'Obrok praćen';

  @override
  String get dashboard_skippedMeal => 'Obrok preskočen';

  @override
  String get dashboard_thanksTrack => 'Hvala što ostajete na pravom putu!';

  @override
  String get dashboard_notedAdjust => 'Zabeleženo, prilagodićemo vaš plan.';

  @override
  String get dashboard_followingRecipe => 'Praćenje recepta';

  @override
  String get dashboard_skippingMeal => 'Preskakanje obroka';

  @override
  String get dashboard_loggingMeal => 'Zapisivanje obroka...';

  @override
  String get dashboard_markingSkipped => 'Označavanje kao preskočeno...';

  @override
  String get dashboard_loggedExactly => 'Zabeleženo tačno po planu';

  @override
  String get dashboard_markedSkipped => 'Označeno kao preskočeno za danas';

  @override
  String get time_underMinuteFuture => 'za manje od minuta';

  @override
  String get time_underMinutePast => 'pre manje od minuta';

  @override
  String time_minutesFuture(int minutes) {
    return 'za $minutes min';
  }

  @override
  String time_minutesPast(int minutes) {
    return 'pre $minutes min';
  }

  @override
  String time_hoursFuture(int hours) {
    return 'za $hours h';
  }

  @override
  String time_hoursPast(int hours) {
    return 'pre $hours h';
  }

  @override
  String time_hoursMinutesFuture(int hours, int minutes) {
    return 'za ${hours}h ${minutes}m';
  }

  @override
  String time_hoursMinutesPast(int hours, int minutes) {
    return 'pre ${hours}h ${minutes}m';
  }

  @override
  String get dashboard_allMealsLogged => 'Svi obroci zabeleženi!';

  @override
  String get dashboard_allMealsLoggedBody =>
      'Odličan posao, ostajete na pravom putu danas. Možete pregledati svoje unose ili preći na raspored za naredne dane.';

  @override
  String get dashboard_mealsLogged => 'Zabeleženi obroci';

  @override
  String dashboard_mealsLoggedCount(int current, int total) {
    return '$current od $total zabeleženo';
  }

  @override
  String get dashboard_nothingLogged =>
      'Još uvek ništa nije zabeleženo. Vaša ažuriranja će se pojaviti ovde.';

  @override
  String get dashboard_containsSugar => 'Sadrži šećer';

  @override
  String get dashboard_highGI => 'Visok GI';

  @override
  String get status_followed => 'Praćen plan';

  @override
  String get status_alternative => 'Alternativni obrok';

  @override
  String get status_skipped => 'Preskočen obrok';
}
