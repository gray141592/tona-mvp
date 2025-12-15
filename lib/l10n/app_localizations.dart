import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_sr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('sr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tona'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @serbian.
  ///
  /// In en, this message translates to:
  /// **'Serbian'**
  String get serbian;

  /// No description provided for @resetOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Reset Onboarding'**
  String get resetOnboarding;

  /// No description provided for @resetSwipeCoach.
  ///
  /// In en, this message translates to:
  /// **'Reset Swipe Coach'**
  String get resetSwipeCoach;

  /// No description provided for @changeTime.
  ///
  /// In en, this message translates to:
  /// **'Change App Time'**
  String get changeTime;

  /// No description provided for @consultationNotes.
  ///
  /// In en, this message translates to:
  /// **'Consultation notes'**
  String get consultationNotes;

  /// No description provided for @consultationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Consultation not found'**
  String get consultationNotFound;

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @reschedulingDisabled.
  ///
  /// In en, this message translates to:
  /// **'Rescheduling disabled after uploading a follow-up meal plan.'**
  String get reschedulingDisabled;

  /// No description provided for @openPreparedReport.
  ///
  /// In en, this message translates to:
  /// **'Open prepared report'**
  String get openPreparedReport;

  /// No description provided for @myNotes.
  ///
  /// In en, this message translates to:
  /// **'My notes'**
  String get myNotes;

  /// No description provided for @myNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Capture takeaways, adjustments, questions…'**
  String get myNotesHint;

  /// No description provided for @focusAreas.
  ///
  /// In en, this message translates to:
  /// **'Focus areas'**
  String get focusAreas;

  /// No description provided for @focusAreasHint.
  ///
  /// In en, this message translates to:
  /// **'One per line (e.g. Pre-workout fueling)'**
  String get focusAreasHint;

  /// No description provided for @afterTheVisit.
  ///
  /// In en, this message translates to:
  /// **'After the visit'**
  String get afterTheVisit;

  /// No description provided for @mealPlanUploaded.
  ///
  /// In en, this message translates to:
  /// **'Meal plan uploaded'**
  String get mealPlanUploaded;

  /// No description provided for @uploadNewMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Upload new meal plan'**
  String get uploadNewMealPlan;

  /// No description provided for @viewLinkedMealPlan.
  ///
  /// In en, this message translates to:
  /// **'View linked meal plan'**
  String get viewLinkedMealPlan;

  /// No description provided for @viewReport.
  ///
  /// In en, this message translates to:
  /// **'View report'**
  String get viewReport;

  /// No description provided for @consultationMoved.
  ///
  /// In en, this message translates to:
  /// **'Consultation moved to {date} at {time}.'**
  String consultationMoved(String date, String time);

  /// No description provided for @mealPlanUploadedAndLinked.
  ///
  /// In en, this message translates to:
  /// **'Meal plan uploaded and linked'**
  String get mealPlanUploadedAndLinked;

  /// No description provided for @noReportAvailableYet.
  ///
  /// In en, this message translates to:
  /// **'No report available yet'**
  String get noReportAvailableYet;

  /// No description provided for @resetSwipeCoachMessage.
  ///
  /// In en, this message translates to:
  /// **'Swipe coach hint has been reset.'**
  String get resetSwipeCoachMessage;

  /// No description provided for @changeTimeMessage.
  ///
  /// In en, this message translates to:
  /// **'Time has been changed.'**
  String get changeTimeMessage;

  /// No description provided for @alreadyOnYourCalendar.
  ///
  /// In en, this message translates to:
  /// **'Already on your calendar'**
  String get alreadyOnYourCalendar;

  /// No description provided for @calendarUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Calendar unavailable'**
  String get calendarUnavailable;

  /// No description provided for @addedToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Added to calendar for {date}'**
  String addedToCalendar(String date);

  /// No description provided for @preparingForConsultation.
  ///
  /// In en, this message translates to:
  /// **'Preparing for {date} consultation'**
  String preparingForConsultation(String date);

  /// No description provided for @yourNutritionist.
  ///
  /// In en, this message translates to:
  /// **'Your nutritionist'**
  String get yourNutritionist;

  /// No description provided for @consultationScheduledFor.
  ///
  /// In en, this message translates to:
  /// **'Consultation scheduled for {date}.'**
  String consultationScheduledFor(String date);

  /// No description provided for @noMealPlanLoaded.
  ///
  /// In en, this message translates to:
  /// **'No meal plan loaded to link yet.'**
  String get noMealPlanLoaded;

  /// No description provided for @linkedMealPlanToConsultation.
  ///
  /// In en, this message translates to:
  /// **'Linked {mealPlanName} to {date} consultation.'**
  String linkedMealPlanToConsultation(String mealPlanName, String date);

  /// No description provided for @noMealPlanLinked.
  ///
  /// In en, this message translates to:
  /// **'No meal plan linked yet'**
  String get noMealPlanLinked;

  /// No description provided for @consultations.
  ///
  /// In en, this message translates to:
  /// **'Consultations'**
  String get consultations;

  /// No description provided for @consultationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay aligned with your nutritionist'**
  String get consultationsSubtitle;

  /// No description provided for @scheduleConsultation.
  ///
  /// In en, this message translates to:
  /// **'Schedule consultation'**
  String get scheduleConsultation;

  /// No description provided for @noConsultationsYet.
  ///
  /// In en, this message translates to:
  /// **'No consultations yet'**
  String get noConsultationsYet;

  /// No description provided for @noConsultationsYetBody.
  ///
  /// In en, this message translates to:
  /// **'Upload a meal plan or connect with your nutritionist to see upcoming appointments.'**
  String get noConsultationsYetBody;

  /// No description provided for @uploadMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Upload meal plan'**
  String get uploadMealPlan;

  /// No description provided for @glycemicIndexQuickGuide.
  ///
  /// In en, this message translates to:
  /// **'Glycemic index quick guide'**
  String get glycemicIndexQuickGuide;

  /// No description provided for @glycemicIndexQuickGuideBody.
  ///
  /// In en, this message translates to:
  /// **'Use this guide to decide whether a meal spikes blood sugar levels.'**
  String get glycemicIndexQuickGuideBody;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @mealMarkedAsSkipped.
  ///
  /// In en, this message translates to:
  /// **'Meal marked as skipped'**
  String get mealMarkedAsSkipped;

  /// No description provided for @unplannedMealLogged.
  ///
  /// In en, this message translates to:
  /// **'Unplanned meal logged'**
  String get unplannedMealLogged;

  /// No description provided for @newMealPlanProcessed.
  ///
  /// In en, this message translates to:
  /// **'Great! New meal plan will be processed and linked to your consultation.'**
  String get newMealPlanProcessed;

  /// No description provided for @uploadMealPlanToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Upload a meal plan to get started'**
  String get uploadMealPlanToGetStarted;

  /// No description provided for @mealLoggedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Way to go! {mealName} is logged.'**
  String mealLoggedSuccess(String mealName);

  /// No description provided for @alternativeLoggedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Good call. Your alternative to {mealName} is logged.'**
  String alternativeLoggedSuccess(String mealName);

  /// No description provided for @groceriesNeedMealPlan.
  ///
  /// In en, this message translates to:
  /// **'You need a meal plan to build a groceries list.'**
  String get groceriesNeedMealPlan;

  /// No description provided for @groceriesNoItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No grocery items found for the selected days.'**
  String get groceriesNoItemsFound;

  /// No description provided for @groceriesConversionError.
  ///
  /// In en, this message translates to:
  /// **'Some items could not be converted to grams: {preview}{suffix}.'**
  String groceriesConversionError(String preview, String suffix);

  /// No description provided for @groceriesAddCustomItem.
  ///
  /// In en, this message translates to:
  /// **'Add custom item'**
  String get groceriesAddCustomItem;

  /// No description provided for @groceriesIngredientName.
  ///
  /// In en, this message translates to:
  /// **'Ingredient name'**
  String get groceriesIngredientName;

  /// No description provided for @groceriesIngredientNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Extra bananas'**
  String get groceriesIngredientNameHint;

  /// No description provided for @groceriesIngredientNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter an ingredient name'**
  String get groceriesIngredientNameError;

  /// No description provided for @groceriesQuantityGrams.
  ///
  /// In en, this message translates to:
  /// **'Quantity (grams)'**
  String get groceriesQuantityGrams;

  /// No description provided for @groceriesQuantityGramsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 250'**
  String get groceriesQuantityGramsHint;

  /// No description provided for @groceriesQuantityGramsError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a quantity in grams'**
  String get groceriesQuantityGramsError;

  /// No description provided for @groceriesPositiveNumberError.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive number'**
  String get groceriesPositiveNumberError;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @groceriesNoItemsToShare.
  ///
  /// In en, this message translates to:
  /// **'No items to share.'**
  String get groceriesNoItemsToShare;

  /// No description provided for @groceriesList.
  ///
  /// In en, this message translates to:
  /// **'Groceries List'**
  String get groceriesList;

  /// No description provided for @groceriesShoppingForDays.
  ///
  /// In en, this message translates to:
  /// **'Shopping for {days} day(s)'**
  String groceriesShoppingForDays(int days);

  /// No description provided for @groceriesGeneratedOn.
  ///
  /// In en, this message translates to:
  /// **'Generated on {date}'**
  String groceriesGeneratedOn(String date);

  /// No description provided for @groceriesShareError.
  ///
  /// In en, this message translates to:
  /// **'Unable to share groceries list: {error}'**
  String groceriesShareError(String error);

  /// No description provided for @groceriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Groceries list'**
  String get groceriesTitle;

  /// No description provided for @groceriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping for {days} day(s)'**
  String groceriesSubtitle(int days);

  /// No description provided for @groceriesStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Choose planning window'**
  String get groceriesStep1Title;

  /// No description provided for @groceriesStep1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'How many days of meals are you shopping for?'**
  String get groceriesStep1Subtitle;

  /// No description provided for @groceriesGenerateButton.
  ///
  /// In en, this message translates to:
  /// **'Generate groceries list'**
  String get groceriesGenerateButton;

  /// No description provided for @groceriesStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Review and adjust'**
  String get groceriesStep2Title;

  /// No description provided for @groceriesStep2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Remove anything you already have and add extra items.'**
  String get groceriesStep2Subtitle;

  /// No description provided for @groceriesGeneratedListPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Your generated list will appear here. Tap the button above once you’ve selected how many days to shop for.'**
  String get groceriesGeneratedListPlaceholder;

  /// No description provided for @groceriesAddCustomItemButton.
  ///
  /// In en, this message translates to:
  /// **'Add custom item'**
  String get groceriesAddCustomItemButton;

  /// No description provided for @groceriesStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Share your list'**
  String get groceriesStep3Title;

  /// No description provided for @groceriesStep3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Send to your phone, a coach, or anyone helping with groceries.'**
  String get groceriesStep3Subtitle;

  /// No description provided for @groceriesShareButton.
  ///
  /// In en, this message translates to:
  /// **'Share groceries list'**
  String get groceriesShareButton;

  /// No description provided for @groceriesRemoveItem.
  ///
  /// In en, this message translates to:
  /// **'Remove item'**
  String get groceriesRemoveItem;

  /// No description provided for @groceriesCustom.
  ///
  /// In en, this message translates to:
  /// **'custom'**
  String get groceriesCustom;

  /// No description provided for @groceriesEstimated.
  ///
  /// In en, this message translates to:
  /// **'estimated'**
  String get groceriesEstimated;

  /// No description provided for @groceriesDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String groceriesDays(int days);

  /// No description provided for @groceriesCustomRange.
  ///
  /// In en, this message translates to:
  /// **'Or set a custom range'**
  String get groceriesCustomRange;

  /// No description provided for @groceriesDayRange.
  ///
  /// In en, this message translates to:
  /// **'{days} day(s)'**
  String groceriesDayRange(int days);

  /// No description provided for @mealPlanOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal plan overview'**
  String get mealPlanOverviewTitle;

  /// No description provided for @noMealPlanAvailable.
  ///
  /// In en, this message translates to:
  /// **'No meal plan available'**
  String get noMealPlanAvailable;

  /// No description provided for @noMealsScheduled.
  ///
  /// In en, this message translates to:
  /// **'No meals scheduled'**
  String get noMealsScheduled;

  /// No description provided for @day_monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get day_monday;

  /// No description provided for @day_tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get day_tuesday;

  /// No description provided for @day_wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get day_wednesday;

  /// No description provided for @day_thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get day_thursday;

  /// No description provided for @day_friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get day_friday;

  /// No description provided for @day_saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get day_saturday;

  /// No description provided for @day_sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get day_sunday;

  /// No description provided for @mealPlanProcessing_title.
  ///
  /// In en, this message translates to:
  /// **'Preparing your plan'**
  String get mealPlanProcessing_title;

  /// No description provided for @mealPlanProcessing_stageUploading_title.
  ///
  /// In en, this message translates to:
  /// **'Uploading your plan'**
  String get mealPlanProcessing_stageUploading_title;

  /// No description provided for @mealPlanProcessing_stageUploading_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Securely sending to IRresistible servers'**
  String get mealPlanProcessing_stageUploading_subtitle;

  /// No description provided for @mealPlanProcessing_stageAnalyzing_title.
  ///
  /// In en, this message translates to:
  /// **'Analyzing details'**
  String get mealPlanProcessing_stageAnalyzing_title;

  /// No description provided for @mealPlanProcessing_stageAnalyzing_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Understanding nutrition goals'**
  String get mealPlanProcessing_stageAnalyzing_subtitle;

  /// No description provided for @mealPlanProcessing_stageExtracting_title.
  ///
  /// In en, this message translates to:
  /// **'Extracting meals'**
  String get mealPlanProcessing_stageExtracting_title;

  /// No description provided for @mealPlanProcessing_stageExtracting_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Capturing meals and supplements'**
  String get mealPlanProcessing_stageExtracting_subtitle;

  /// No description provided for @mealPlanProcessing_stageFinalizing_title.
  ///
  /// In en, this message translates to:
  /// **'Final touches'**
  String get mealPlanProcessing_stageFinalizing_title;

  /// No description provided for @mealPlanProcessing_stageFinalizing_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Applying the IRresistible structure'**
  String get mealPlanProcessing_stageFinalizing_subtitle;

  /// No description provided for @mealPlanProcessing_progress.
  ///
  /// In en, this message translates to:
  /// **'Progress {progress}'**
  String mealPlanProcessing_progress(String progress);

  /// No description provided for @mealPlanProcessing_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel and choose another file'**
  String get mealPlanProcessing_cancel;

  /// No description provided for @mealPlanReview_title.
  ///
  /// In en, this message translates to:
  /// **'Review Meal Plan'**
  String get mealPlanReview_title;

  /// No description provided for @mealPlanReview_changeFile.
  ///
  /// In en, this message translates to:
  /// **'Change File'**
  String get mealPlanReview_changeFile;

  /// No description provided for @mealPlanReview_confirmPlan.
  ///
  /// In en, this message translates to:
  /// **'Confirm Plan'**
  String get mealPlanReview_confirmPlan;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'sr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'sr':
      return AppLocalizationsSr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
