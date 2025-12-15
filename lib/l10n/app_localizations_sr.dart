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
}
