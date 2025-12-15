// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tona';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get serbian => 'Serbian';

  @override
  String get resetOnboarding => 'Reset Onboarding';

  @override
  String get resetSwipeCoach => 'Reset Swipe Coach';

  @override
  String get changeTime => 'Change App Time';

  @override
  String get consultationNotes => 'Consultation notes';

  @override
  String get consultationNotFound => 'Consultation not found';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get reschedulingDisabled =>
      'Rescheduling disabled after uploading a follow-up meal plan.';

  @override
  String get openPreparedReport => 'Open prepared report';

  @override
  String get myNotes => 'My notes';

  @override
  String get myNotesHint => 'Capture takeaways, adjustments, questions…';

  @override
  String get focusAreas => 'Focus areas';

  @override
  String get focusAreasHint => 'One per line (e.g. Pre-workout fueling)';

  @override
  String get afterTheVisit => 'After the visit';

  @override
  String get mealPlanUploaded => 'Meal plan uploaded';

  @override
  String get uploadNewMealPlan => 'Upload new meal plan';

  @override
  String get viewLinkedMealPlan => 'View linked meal plan';

  @override
  String get viewReport => 'View report';

  @override
  String consultationMoved(String date, String time) {
    return 'Consultation moved to $date at $time.';
  }

  @override
  String get mealPlanUploadedAndLinked => 'Meal plan uploaded and linked';

  @override
  String get noReportAvailableYet => 'No report available yet';

  @override
  String get resetSwipeCoachMessage => 'Swipe coach hint has been reset.';

  @override
  String get changeTimeMessage => 'Time has been changed.';

  @override
  String get alreadyOnYourCalendar => 'Already on your calendar';

  @override
  String get calendarUnavailable => 'Calendar unavailable';

  @override
  String addedToCalendar(String date) {
    return 'Added to calendar for $date';
  }

  @override
  String preparingForConsultation(String date) {
    return 'Preparing for $date consultation';
  }

  @override
  String get yourNutritionist => 'Your nutritionist';

  @override
  String consultationScheduledFor(String date) {
    return 'Consultation scheduled for $date.';
  }

  @override
  String get noMealPlanLoaded => 'No meal plan loaded to link yet.';

  @override
  String linkedMealPlanToConsultation(String mealPlanName, String date) {
    return 'Linked $mealPlanName to $date consultation.';
  }

  @override
  String get noMealPlanLinked => 'No meal plan linked yet';

  @override
  String get consultations => 'Consultations';

  @override
  String get consultationsSubtitle => 'Stay aligned with your nutritionist';

  @override
  String get scheduleConsultation => 'Schedule consultation';

  @override
  String get noConsultationsYet => 'No consultations yet';

  @override
  String get noConsultationsYetBody =>
      'Upload a meal plan or connect with your nutritionist to see upcoming appointments.';

  @override
  String get uploadMealPlan => 'Upload meal plan';

  @override
  String get glycemicIndexQuickGuide => 'Glycemic index quick guide';

  @override
  String get glycemicIndexQuickGuideBody =>
      'Use this guide to decide whether a meal spikes blood sugar levels.';

  @override
  String get gotIt => 'Got it';

  @override
  String get mealMarkedAsSkipped => 'Meal marked as skipped';

  @override
  String get unplannedMealLogged => 'Unplanned meal logged';

  @override
  String get newMealPlanProcessed =>
      'Great! New meal plan will be processed and linked to your consultation.';

  @override
  String get uploadMealPlanToGetStarted => 'Upload a meal plan to get started';

  @override
  String mealLoggedSuccess(String mealName) {
    return 'Way to go! $mealName is logged.';
  }

  @override
  String alternativeLoggedSuccess(String mealName) {
    return 'Good call. Your alternative to $mealName is logged.';
  }

  @override
  String get groceriesNeedMealPlan =>
      'You need a meal plan to build a groceries list.';

  @override
  String get groceriesNoItemsFound =>
      'No grocery items found for the selected days.';

  @override
  String groceriesConversionError(String preview, String suffix) {
    return 'Some items could not be converted to grams: $preview$suffix.';
  }

  @override
  String get groceriesAddCustomItem => 'Add custom item';

  @override
  String get groceriesIngredientName => 'Ingredient name';

  @override
  String get groceriesIngredientNameHint => 'e.g., Extra bananas';

  @override
  String get groceriesIngredientNameError => 'Please enter an ingredient name';

  @override
  String get groceriesQuantityGrams => 'Quantity (grams)';

  @override
  String get groceriesQuantityGramsHint => 'e.g., 250';

  @override
  String get groceriesQuantityGramsError => 'Please enter a quantity in grams';

  @override
  String get groceriesPositiveNumberError => 'Enter a positive number';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get groceriesNoItemsToShare => 'No items to share.';

  @override
  String get groceriesList => 'Groceries List';

  @override
  String groceriesShoppingForDays(int days) {
    return 'Shopping for $days day(s)';
  }

  @override
  String groceriesGeneratedOn(String date) {
    return 'Generated on $date';
  }

  @override
  String groceriesShareError(String error) {
    return 'Unable to share groceries list: $error';
  }

  @override
  String get groceriesTitle => 'Groceries list';

  @override
  String groceriesSubtitle(int days) {
    return 'Shopping for $days day(s)';
  }

  @override
  String get groceriesStep1Title => 'Choose planning window';

  @override
  String get groceriesStep1Subtitle =>
      'How many days of meals are you shopping for?';

  @override
  String get groceriesGenerateButton => 'Generate groceries list';

  @override
  String get groceriesStep2Title => 'Review and adjust';

  @override
  String get groceriesStep2Subtitle =>
      'Remove anything you already have and add extra items.';

  @override
  String get groceriesGeneratedListPlaceholder =>
      'Your generated list will appear here. Tap the button above once you’ve selected how many days to shop for.';

  @override
  String get groceriesAddCustomItemButton => 'Add custom item';

  @override
  String get groceriesStep3Title => 'Share your list';

  @override
  String get groceriesStep3Subtitle =>
      'Send to your phone, a coach, or anyone helping with groceries.';

  @override
  String get groceriesShareButton => 'Share groceries list';

  @override
  String get groceriesRemoveItem => 'Remove item';

  @override
  String get groceriesCustom => 'custom';

  @override
  String get groceriesEstimated => 'estimated';

  @override
  String groceriesDays(int days) {
    return '$days days';
  }

  @override
  String get groceriesCustomRange => 'Or set a custom range';

  @override
  String groceriesDayRange(int days) {
    return '$days day(s)';
  }

  @override
  String get mealPlanOverviewTitle => 'Meal plan overview';

  @override
  String get noMealPlanAvailable => 'No meal plan available';

  @override
  String get noMealsScheduled => 'No meals scheduled';

  @override
  String get day_monday => 'Monday';

  @override
  String get day_tuesday => 'Tuesday';

  @override
  String get day_wednesday => 'Wednesday';

  @override
  String get day_thursday => 'Thursday';

  @override
  String get day_friday => 'Friday';

  @override
  String get day_saturday => 'Saturday';

  @override
  String get day_sunday => 'Sunday';

  @override
  String get mealPlanProcessing_title => 'Preparing your plan';

  @override
  String get mealPlanProcessing_stageUploading_title => 'Uploading your plan';

  @override
  String get mealPlanProcessing_stageUploading_subtitle =>
      'Securely sending to IRresistible servers';

  @override
  String get mealPlanProcessing_stageAnalyzing_title => 'Analyzing details';

  @override
  String get mealPlanProcessing_stageAnalyzing_subtitle =>
      'Understanding nutrition goals';

  @override
  String get mealPlanProcessing_stageExtracting_title => 'Extracting meals';

  @override
  String get mealPlanProcessing_stageExtracting_subtitle =>
      'Capturing meals and supplements';

  @override
  String get mealPlanProcessing_stageFinalizing_title => 'Final touches';

  @override
  String get mealPlanProcessing_stageFinalizing_subtitle =>
      'Applying the IRresistible structure';

  @override
  String mealPlanProcessing_progress(String progress) {
    return 'Progress $progress';
  }

  @override
  String get mealPlanProcessing_cancel => 'Cancel and choose another file';

  @override
  String get mealPlanReview_title => 'Review Meal Plan';

  @override
  String get mealPlanReview_changeFile => 'Change File';

  @override
  String get mealPlanReview_confirmPlan => 'Confirm Plan';
}
