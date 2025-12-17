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

  /// No description provided for @menuProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get menuProgress;

  /// No description provided for @dashboardMenu_closeMenu.
  ///
  /// In en, this message translates to:
  /// **'Close menu'**
  String get dashboardMenu_closeMenu;

  /// No description provided for @glycemicInfo_lowTitle.
  ///
  /// In en, this message translates to:
  /// **'Low GI (0-55)'**
  String get glycemicInfo_lowTitle;

  /// No description provided for @glycemicInfo_lowDesc.
  ///
  /// In en, this message translates to:
  /// **'Steady energy, best for maintaining balanced blood sugar.'**
  String get glycemicInfo_lowDesc;

  /// No description provided for @glycemicInfo_lowExample1.
  ///
  /// In en, this message translates to:
  /// **'Leafy greens, non-starchy vegetables'**
  String get glycemicInfo_lowExample1;

  /// No description provided for @glycemicInfo_lowExample2.
  ///
  /// In en, this message translates to:
  /// **'Beans, lentils, chickpeas'**
  String get glycemicInfo_lowExample2;

  /// No description provided for @glycemicInfo_lowExample3.
  ///
  /// In en, this message translates to:
  /// **'Whole grains like barley or quinoa'**
  String get glycemicInfo_lowExample3;

  /// No description provided for @glycemicInfo_mediumTitle.
  ///
  /// In en, this message translates to:
  /// **'Medium GI (56-69)'**
  String get glycemicInfo_mediumTitle;

  /// No description provided for @glycemicInfo_mediumDesc.
  ///
  /// In en, this message translates to:
  /// **'Moderate impact, balance with protein or healthy fats.'**
  String get glycemicInfo_mediumDesc;

  /// No description provided for @glycemicInfo_mediumExample1.
  ///
  /// In en, this message translates to:
  /// **'Whole grain bread, oats'**
  String get glycemicInfo_mediumExample1;

  /// No description provided for @glycemicInfo_mediumExample2.
  ///
  /// In en, this message translates to:
  /// **'Sweet corn, sweet potatoes'**
  String get glycemicInfo_mediumExample2;

  /// No description provided for @glycemicInfo_mediumExample3.
  ///
  /// In en, this message translates to:
  /// **'Tropical fruits like pineapple or mango'**
  String get glycemicInfo_mediumExample3;

  /// No description provided for @glycemicInfo_highTitle.
  ///
  /// In en, this message translates to:
  /// **'High GI (70+)'**
  String get glycemicInfo_highTitle;

  /// No description provided for @glycemicInfo_highDesc.
  ///
  /// In en, this message translates to:
  /// **'Spikes blood sugar quickly; limit when possible.'**
  String get glycemicInfo_highDesc;

  /// No description provided for @glycemicInfo_highExample1.
  ///
  /// In en, this message translates to:
  /// **'White bread, bagels, pretzels'**
  String get glycemicInfo_highExample1;

  /// No description provided for @glycemicInfo_highExample2.
  ///
  /// In en, this message translates to:
  /// **'Sugary cereals, candy, pastries'**
  String get glycemicInfo_highExample2;

  /// No description provided for @glycemicInfo_highExample3.
  ///
  /// In en, this message translates to:
  /// **'White rice, fries, processed snacks'**
  String get glycemicInfo_highExample3;

  /// No description provided for @swipeCoach_followedPlan.
  ///
  /// In en, this message translates to:
  /// **'Followed plan'**
  String get swipeCoach_followedPlan;

  /// No description provided for @swipeCoach_skippedMeal.
  ///
  /// In en, this message translates to:
  /// **'Skipped meal'**
  String get swipeCoach_skippedMeal;

  /// No description provided for @quickActions_groceriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get quickActions_groceriesTitle;

  /// No description provided for @quickActions_groceriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate your list'**
  String get quickActions_groceriesSubtitle;

  /// No description provided for @quickActions_addUnplannedTitle.
  ///
  /// In en, this message translates to:
  /// **'Add unplanned meal'**
  String get quickActions_addUnplannedTitle;

  /// No description provided for @quickActions_addUnplannedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log a meal not in plan'**
  String get quickActions_addUnplannedSubtitle;

  /// No description provided for @alternativeMeal_addUnplannedTitle.
  ///
  /// In en, this message translates to:
  /// **'Add unplanned meal'**
  String get alternativeMeal_addUnplannedTitle;

  /// No description provided for @alternativeMeal_logAlternativeTitle.
  ///
  /// In en, this message translates to:
  /// **'Log alternative'**
  String get alternativeMeal_logAlternativeTitle;

  /// No description provided for @alternativeMeal_whatDidYouEat.
  ///
  /// In en, this message translates to:
  /// **'What did you eat?'**
  String get alternativeMeal_whatDidYouEat;

  /// No description provided for @alternativeMeal_whatDidYouEatInstead.
  ///
  /// In en, this message translates to:
  /// **'What did you eat instead?'**
  String get alternativeMeal_whatDidYouEatInstead;

  /// No description provided for @alternativeMeal_describeMeal.
  ///
  /// In en, this message translates to:
  /// **'Describe the meal...'**
  String get alternativeMeal_describeMeal;

  /// No description provided for @alternativeMeal_describeMealHad.
  ///
  /// In en, this message translates to:
  /// **'Describe the meal you had...'**
  String get alternativeMeal_describeMealHad;

  /// No description provided for @alternativeMeal_validationError.
  ///
  /// In en, this message translates to:
  /// **'Please provide a short description'**
  String get alternativeMeal_validationError;

  /// No description provided for @alternativeMeal_notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get alternativeMeal_notesOptional;

  /// No description provided for @alternativeMeal_bloodSugarImpact.
  ///
  /// In en, this message translates to:
  /// **'Blood sugar impact'**
  String get alternativeMeal_bloodSugarImpact;

  /// No description provided for @alternativeMeal_containsSugar.
  ///
  /// In en, this message translates to:
  /// **'Contains added sugar'**
  String get alternativeMeal_containsSugar;

  /// No description provided for @alternativeMeal_containsSugarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mark if the alternative meal includes refined sugar or sweet syrups.'**
  String get alternativeMeal_containsSugarSubtitle;

  /// No description provided for @alternativeMeal_highGI.
  ///
  /// In en, this message translates to:
  /// **'High glycemic index'**
  String get alternativeMeal_highGI;

  /// No description provided for @alternativeMeal_highGISubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select when the meal is likely to cause a sharp blood sugar spike.'**
  String get alternativeMeal_highGISubtitle;

  /// No description provided for @alternativeMeal_saveMeal.
  ///
  /// In en, this message translates to:
  /// **'Save meal'**
  String get alternativeMeal_saveMeal;

  /// No description provided for @alternativeMeal_saveAlternative.
  ///
  /// In en, this message translates to:
  /// **'Save alternative'**
  String get alternativeMeal_saveAlternative;

  /// No description provided for @alternativeMeal_saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get alternativeMeal_saving;

  /// No description provided for @consultationSchedule_title.
  ///
  /// In en, this message translates to:
  /// **'Schedule consultation'**
  String get consultationSchedule_title;

  /// No description provided for @consultationSchedule_nutritionistName.
  ///
  /// In en, this message translates to:
  /// **'Nutritionist name'**
  String get consultationSchedule_nutritionistName;

  /// No description provided for @consultationSchedule_selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get consultationSchedule_selectDate;

  /// No description provided for @consultationSchedule_selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get consultationSchedule_selectTime;

  /// No description provided for @consultationSchedule_videoCall.
  ///
  /// In en, this message translates to:
  /// **'Video call'**
  String get consultationSchedule_videoCall;

  /// No description provided for @consultationSchedule_inPerson.
  ///
  /// In en, this message translates to:
  /// **'In-person'**
  String get consultationSchedule_inPerson;

  /// No description provided for @consultationSchedule_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get consultationSchedule_phone;

  /// No description provided for @consultationSchedule_format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get consultationSchedule_format;

  /// No description provided for @consultationSchedule_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get consultationSchedule_location;

  /// No description provided for @consultationSchedule_meetingLink.
  ///
  /// In en, this message translates to:
  /// **'Meeting link'**
  String get consultationSchedule_meetingLink;

  /// No description provided for @consultationSchedule_prepNotes.
  ///
  /// In en, this message translates to:
  /// **'Preparation notes (comma separated)'**
  String get consultationSchedule_prepNotes;

  /// No description provided for @consultationSchedule_saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save appointment'**
  String get consultationSchedule_saveButton;

  /// No description provided for @consultationCard_mealPlanInEffect.
  ///
  /// In en, this message translates to:
  /// **'Meal plan in effect'**
  String get consultationCard_mealPlanInEffect;

  /// No description provided for @consultationCard_focusAreas.
  ///
  /// In en, this message translates to:
  /// **'Focus areas'**
  String get consultationCard_focusAreas;

  /// No description provided for @consultationCard_preparation.
  ///
  /// In en, this message translates to:
  /// **'Preparation'**
  String get consultationCard_preparation;

  /// No description provided for @consultationCard_happeningNow.
  ///
  /// In en, this message translates to:
  /// **'Happening now'**
  String get consultationCard_happeningNow;

  /// No description provided for @consultationCard_inDays.
  ///
  /// In en, this message translates to:
  /// **'In {count} days'**
  String consultationCard_inDays(int count);

  /// No description provided for @consultationCard_inDay.
  ///
  /// In en, this message translates to:
  /// **'In 1 day'**
  String get consultationCard_inDay;

  /// No description provided for @consultationCard_inHours.
  ///
  /// In en, this message translates to:
  /// **'In {count} hours'**
  String consultationCard_inHours(int count);

  /// No description provided for @consultationCard_inHour.
  ///
  /// In en, this message translates to:
  /// **'In 1 hour'**
  String get consultationCard_inHour;

  /// No description provided for @consultationCard_inMinutes.
  ///
  /// In en, this message translates to:
  /// **'In {count} minutes'**
  String consultationCard_inMinutes(int count);

  /// No description provided for @consultationCard_inMinute.
  ///
  /// In en, this message translates to:
  /// **'In 1 minute'**
  String get consultationCard_inMinute;

  /// No description provided for @consultationCard_daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String consultationCard_daysAgo(int count);

  /// No description provided for @consultationCard_dayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get consultationCard_dayAgo;

  /// No description provided for @consultationCard_hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String consultationCard_hoursAgo(int count);

  /// No description provided for @consultationCard_hourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get consultationCard_hourAgo;

  /// No description provided for @consultationCard_minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String consultationCard_minutesAgo(int count);

  /// No description provided for @consultationCard_minuteAgo.
  ///
  /// In en, this message translates to:
  /// **'1 minute ago'**
  String get consultationCard_minuteAgo;

  /// No description provided for @consultationOverview_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get consultationOverview_upcoming;

  /// No description provided for @consultationOverview_nextAppointment.
  ///
  /// In en, this message translates to:
  /// **'Next appointment'**
  String get consultationOverview_nextAppointment;

  /// No description provided for @consultationOverview_addedToSchedule.
  ///
  /// In en, this message translates to:
  /// **'Added to schedule'**
  String get consultationOverview_addedToSchedule;

  /// No description provided for @consultationOverview_addToSchedule.
  ///
  /// In en, this message translates to:
  /// **'Add to schedule'**
  String get consultationOverview_addToSchedule;

  /// No description provided for @consultationOverview_prepareReport.
  ///
  /// In en, this message translates to:
  /// **'Prepare report'**
  String get consultationOverview_prepareReport;

  /// No description provided for @consultationOverview_mostRecent.
  ///
  /// In en, this message translates to:
  /// **'Most recent visit'**
  String get consultationOverview_mostRecent;

  /// No description provided for @consultationOverview_lastAppointment.
  ///
  /// In en, this message translates to:
  /// **'Last appointment'**
  String get consultationOverview_lastAppointment;

  /// No description provided for @consultationOverview_linkMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Link current meal plan'**
  String get consultationOverview_linkMealPlan;

  /// No description provided for @consultationOverview_viewMealPlan.
  ///
  /// In en, this message translates to:
  /// **'View meal plan'**
  String get consultationOverview_viewMealPlan;

  /// No description provided for @consultationHistory_title.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get consultationHistory_title;

  /// No description provided for @consultationHistory_consultationPrefix.
  ///
  /// In en, this message translates to:
  /// **'Consultation'**
  String get consultationHistory_consultationPrefix;

  /// No description provided for @consultationFollowup_title.
  ///
  /// In en, this message translates to:
  /// **'How did it go?'**
  String get consultationFollowup_title;

  /// No description provided for @consultationFollowup_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your consultation on {date} may have updated your meal plan.'**
  String consultationFollowup_subtitle(String date);

  /// No description provided for @consultationFollowup_body.
  ///
  /// In en, this message translates to:
  /// **'If you received a new meal plan or changes, you can upload them now so we can adjust your schedule immediately.'**
  String get consultationFollowup_body;

  /// No description provided for @consultationFollowup_highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get consultationFollowup_highlights;

  /// No description provided for @consultationFollowup_uploadNewPlan.
  ///
  /// In en, this message translates to:
  /// **'Upload new plan'**
  String get consultationFollowup_uploadNewPlan;

  /// No description provided for @consultationFollowup_reviewNotes.
  ///
  /// In en, this message translates to:
  /// **'Review notes'**
  String get consultationFollowup_reviewNotes;

  /// No description provided for @consultationReminder_title.
  ///
  /// In en, this message translates to:
  /// **'Consultation coming up'**
  String get consultationReminder_title;

  /// No description provided for @consultationReminder_body.
  ///
  /// In en, this message translates to:
  /// **'Prepare your notes so {name} has the latest insights. Generating a report now keeps everything ready to review together.'**
  String consultationReminder_body(String name);

  /// No description provided for @consultationReminder_viewAgenda.
  ///
  /// In en, this message translates to:
  /// **'View agenda'**
  String get consultationReminder_viewAgenda;

  /// No description provided for @consultationReminder_happeningSoon.
  ///
  /// In en, this message translates to:
  /// **'Happening soon'**
  String get consultationReminder_happeningSoon;

  /// No description provided for @consultationReminder_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get consultationReminder_tomorrow;

  /// No description provided for @openReport.
  ///
  /// In en, this message translates to:
  /// **'Open report'**
  String get openReport;

  /// No description provided for @report_followed.
  ///
  /// In en, this message translates to:
  /// **'Followed'**
  String get report_followed;

  /// No description provided for @report_alternatives.
  ///
  /// In en, this message translates to:
  /// **'Alternatives'**
  String get report_alternatives;

  /// No description provided for @report_skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get report_skipped;

  /// No description provided for @report_totalLogs.
  ///
  /// In en, this message translates to:
  /// **'Total logs'**
  String get report_totalLogs;

  /// No description provided for @report_snapshotSummary.
  ///
  /// In en, this message translates to:
  /// **'Snapshot summary'**
  String get report_snapshotSummary;

  /// No description provided for @report_longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get report_longestStreak;

  /// No description provided for @report_asOfDate.
  ///
  /// In en, this message translates to:
  /// **'As of {date}'**
  String report_asOfDate(String date);

  /// No description provided for @report_mealsWithSugar.
  ///
  /// In en, this message translates to:
  /// **'Meals with sugar'**
  String get report_mealsWithSugar;

  /// No description provided for @report_highGIMeals.
  ///
  /// In en, this message translates to:
  /// **'High G index meals'**
  String get report_highGIMeals;

  /// No description provided for @progress_logToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Log your meals to unlock progress insights'**
  String get progress_logToUnlock;

  /// No description provided for @progress_logToStartStreak.
  ///
  /// In en, this message translates to:
  /// **'Log your meals to start a streak'**
  String get progress_logToStartStreak;

  /// No description provided for @streak_fire.
  ///
  /// In en, this message translates to:
  /// **'Incredible run! Keep the fire going! 🔥'**
  String get streak_fire;

  /// No description provided for @streak_stacking.
  ///
  /// In en, this message translates to:
  /// **'Amazing consistency — keep stacking days! 💪'**
  String get streak_stacking;

  /// No description provided for @streak_strongStart.
  ///
  /// In en, this message translates to:
  /// **'Strong start — let\'s stretch it further! 🚀'**
  String get streak_strongStart;

  /// No description provided for @streak_owningWeek.
  ///
  /// In en, this message translates to:
  /// **'Meal-by-meal, you\'re owning this week! 🍽️'**
  String get streak_owningWeek;

  /// No description provided for @streak_momentum.
  ///
  /// In en, this message translates to:
  /// **'One meal at a time — keep that momentum! 🙌'**
  String get streak_momentum;

  /// No description provided for @streak_freshDay.
  ///
  /// In en, this message translates to:
  /// **'Fresh day, fresh opportunity to shine! 🌟'**
  String get streak_freshDay;

  /// No description provided for @progress_dailyHistory.
  ///
  /// In en, this message translates to:
  /// **'Daily history'**
  String get progress_dailyHistory;

  /// No description provided for @progress_allLogs.
  ///
  /// In en, this message translates to:
  /// **'All of your logs'**
  String get progress_allLogs;

  /// No description provided for @progress_noMealsLogged.
  ///
  /// In en, this message translates to:
  /// **'No meals logged yet'**
  String get progress_noMealsLogged;

  /// No description provided for @progress_logFirstMeal.
  ///
  /// In en, this message translates to:
  /// **'Log your first meal to start building your progress timeline.'**
  String get progress_logFirstMeal;

  /// No description provided for @report_progressReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress report'**
  String get report_progressReportTitle;

  /// No description provided for @report_shareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share report'**
  String get report_shareTooltip;

  /// No description provided for @report_shareError.
  ///
  /// In en, this message translates to:
  /// **'Error sharing report: {error}'**
  String report_shareError(String error);

  /// No description provided for @reportText_title.
  ///
  /// In en, this message translates to:
  /// **'Progress Report'**
  String get reportText_title;

  /// No description provided for @reportText_client.
  ///
  /// In en, this message translates to:
  /// **'Client: {name}'**
  String reportText_client(String name);

  /// No description provided for @reportText_email.
  ///
  /// In en, this message translates to:
  /// **'Email: {email}'**
  String reportText_email(String email);

  /// No description provided for @reportText_period.
  ///
  /// In en, this message translates to:
  /// **'Period: {start} - {end}'**
  String reportText_period(String start, String end);

  /// No description provided for @reportText_summary.
  ///
  /// In en, this message translates to:
  /// **'Summary:'**
  String get reportText_summary;

  /// No description provided for @reportText_totalMeals.
  ///
  /// In en, this message translates to:
  /// **'Total Meals: {count}'**
  String reportText_totalMeals(int count);

  /// No description provided for @reportText_mealsFollowed.
  ///
  /// In en, this message translates to:
  /// **'Meals Followed: {count}'**
  String reportText_mealsFollowed(int count);

  /// No description provided for @reportText_mealsAlternatives.
  ///
  /// In en, this message translates to:
  /// **'Alternative Meals: {count}'**
  String reportText_mealsAlternatives(int count);

  /// No description provided for @reportText_mealsSkipped.
  ///
  /// In en, this message translates to:
  /// **'Meals Skipped: {count}'**
  String reportText_mealsSkipped(int count);

  /// No description provided for @reportText_mealsDue.
  ///
  /// In en, this message translates to:
  /// **'Meals due so far: {count}'**
  String reportText_mealsDue(int count);

  /// No description provided for @reportText_unloggedDue.
  ///
  /// In en, this message translates to:
  /// **'Unlogged meals due: {count}'**
  String reportText_unloggedDue(int count);

  /// No description provided for @reportText_longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest streak: {streak}'**
  String reportText_longestStreak(String streak);

  /// No description provided for @reportText_mealsWithSugar.
  ///
  /// In en, this message translates to:
  /// **'Meals with sugar: {count}'**
  String reportText_mealsWithSugar(int count);

  /// No description provided for @reportText_mealsHighGI.
  ///
  /// In en, this message translates to:
  /// **'Meals with high glycemic index: {count}'**
  String reportText_mealsHighGI(int count);

  /// No description provided for @reportText_dailyBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Daily Breakdown:'**
  String get reportText_dailyBreakdown;

  /// No description provided for @reportText_notes.
  ///
  /// In en, this message translates to:
  /// **'    Notes: {notes}'**
  String reportText_notes(String notes);

  /// No description provided for @reportGen_title.
  ///
  /// In en, this message translates to:
  /// **'Generate report'**
  String get reportGen_title;

  /// No description provided for @reportGen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Summaries ready to share'**
  String get reportGen_subtitle;

  /// No description provided for @reportGen_choosePeriod.
  ///
  /// In en, this message translates to:
  /// **'Choose a period'**
  String get reportGen_choosePeriod;

  /// No description provided for @reportGen_periodDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'ll summarise all activity within the selected range.'**
  String get reportGen_periodDesc;

  /// No description provided for @reportGen_last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get reportGen_last7Days;

  /// No description provided for @reportGen_last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get reportGen_last30Days;

  /// No description provided for @reportGen_customRange.
  ///
  /// In en, this message translates to:
  /// **'Custom range'**
  String get reportGen_customRange;

  /// No description provided for @reportGen_from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get reportGen_from;

  /// No description provided for @reportGen_to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get reportGen_to;

  /// No description provided for @reportGen_includeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your report will include'**
  String get reportGen_includeTitle;

  /// No description provided for @reportGen_include1.
  ///
  /// In en, this message translates to:
  /// **'Full meal log history for the period'**
  String get reportGen_include1;

  /// No description provided for @reportGen_include2.
  ///
  /// In en, this message translates to:
  /// **'Adherence and consistency insights'**
  String get reportGen_include2;

  /// No description provided for @reportGen_include3.
  ///
  /// In en, this message translates to:
  /// **'Client notes and alternative selections'**
  String get reportGen_include3;

  /// No description provided for @reportGen_include4.
  ///
  /// In en, this message translates to:
  /// **'Weekly summaries ready to share'**
  String get reportGen_include4;

  /// No description provided for @reportGen_button.
  ///
  /// In en, this message translates to:
  /// **'Generate report'**
  String get reportGen_button;

  /// No description provided for @uploadPlan_title.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Meal Plan'**
  String get uploadPlan_title;

  /// No description provided for @uploadPlan_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your meal plan file to get started'**
  String get uploadPlan_subtitle;

  /// No description provided for @uploadPlan_fileSelected.
  ///
  /// In en, this message translates to:
  /// **'File Selected'**
  String get uploadPlan_fileSelected;

  /// No description provided for @uploadPlan_tapToSelect.
  ///
  /// In en, this message translates to:
  /// **'Tap to select file'**
  String get uploadPlan_tapToSelect;

  /// No description provided for @uploadPlan_fileFormats.
  ///
  /// In en, this message translates to:
  /// **'PDF, DOC, or any file format'**
  String get uploadPlan_fileFormats;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @mealDrawer_ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get mealDrawer_ingredients;

  /// No description provided for @mealDrawer_noIngredients.
  ///
  /// In en, this message translates to:
  /// **'No ingredient list provided for this meal.'**
  String get mealDrawer_noIngredients;

  /// No description provided for @mealDrawer_preparation.
  ///
  /// In en, this message translates to:
  /// **'Preparation'**
  String get mealDrawer_preparation;

  /// No description provided for @mealDrawer_noPrep.
  ///
  /// In en, this message translates to:
  /// **'No preparation instructions provided for this meal.'**
  String get mealDrawer_noPrep;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'IRresistible'**
  String get appName;

  /// No description provided for @settings_debug.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get settings_debug;

  /// No description provided for @settings_skipOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Skip Onboarding'**
  String get settings_skipOnboarding;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'IRresistible'**
  String get splashTitle;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your personalized nutrition journey'**
  String get splashSubtitle;

  /// No description provided for @mock_meal_1_breakfast_name.
  ///
  /// In en, this message translates to:
  /// **'Oatmeal with Berries'**
  String get mock_meal_1_breakfast_name;

  /// No description provided for @mock_meal_1_breakfast_desc.
  ///
  /// In en, this message translates to:
  /// **'1 cup cooked oatmeal, 1/2 cup mixed berries, 1 tbsp almond butter, honey drizzle'**
  String get mock_meal_1_breakfast_desc;

  /// No description provided for @mock_meal_1_snack1_name.
  ///
  /// In en, this message translates to:
  /// **'Apple with Almond Butter'**
  String get mock_meal_1_snack1_name;

  /// No description provided for @mock_meal_1_snack1_desc.
  ///
  /// In en, this message translates to:
  /// **'1 medium apple, 1 tbsp almond butter'**
  String get mock_meal_1_snack1_desc;

  /// No description provided for @mock_meal_1_lunch_name.
  ///
  /// In en, this message translates to:
  /// **'Grilled Chicken Salad'**
  String get mock_meal_1_lunch_name;

  /// No description provided for @mock_meal_1_lunch_desc.
  ///
  /// In en, this message translates to:
  /// **'4oz grilled chicken breast, mixed greens, cherry tomatoes, cucumber, olive oil dressing'**
  String get mock_meal_1_lunch_desc;

  /// No description provided for @mock_meal_1_snack2_name.
  ///
  /// In en, this message translates to:
  /// **'Greek Yogurt with Berries'**
  String get mock_meal_1_snack2_name;

  /// No description provided for @mock_meal_1_snack2_desc.
  ///
  /// In en, this message translates to:
  /// **'1 cup plain Greek yogurt, 1/4 cup mixed berries'**
  String get mock_meal_1_snack2_desc;

  /// No description provided for @mock_meal_1_dinner_name.
  ///
  /// In en, this message translates to:
  /// **'Baked Salmon with Vegetables'**
  String get mock_meal_1_dinner_name;

  /// No description provided for @mock_meal_1_dinner_desc.
  ///
  /// In en, this message translates to:
  /// **'5oz salmon fillet, roasted broccoli and sweet potato'**
  String get mock_meal_1_dinner_desc;

  /// No description provided for @mock_meal_1_breakfast_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup cooked oatmeal'**
  String get mock_meal_1_breakfast_ingredient_0;

  /// No description provided for @mock_meal_1_breakfast_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup mixed berries'**
  String get mock_meal_1_breakfast_ingredient_1;

  /// No description provided for @mock_meal_1_breakfast_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 tbsp almond butter'**
  String get mock_meal_1_breakfast_ingredient_2;

  /// No description provided for @mock_meal_1_breakfast_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 tsp honey'**
  String get mock_meal_1_breakfast_ingredient_3;

  /// No description provided for @mock_meal_1_breakfast_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Cook the oatmeal with water or milk until creamy.'**
  String get mock_meal_1_breakfast_instruction_0;

  /// No description provided for @mock_meal_1_breakfast_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Top with mixed berries, almond butter, and a drizzle of honey.'**
  String get mock_meal_1_breakfast_instruction_1;

  /// No description provided for @mock_meal_1_snack1_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 medium apple'**
  String get mock_meal_1_snack1_ingredient_0;

  /// No description provided for @mock_meal_1_snack1_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 tbsp almond butter'**
  String get mock_meal_1_snack1_ingredient_1;

  /// No description provided for @mock_meal_1_snack1_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Slice the apple into wedges or rounds.'**
  String get mock_meal_1_snack1_instruction_0;

  /// No description provided for @mock_meal_1_snack1_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve with almond butter for dipping or spreading.'**
  String get mock_meal_1_snack1_instruction_1;

  /// No description provided for @mock_meal_1_lunch_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'4 oz grilled chicken breast'**
  String get mock_meal_1_lunch_ingredient_0;

  /// No description provided for @mock_meal_1_lunch_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'2 cups mixed greens'**
  String get mock_meal_1_lunch_ingredient_1;

  /// No description provided for @mock_meal_1_lunch_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup cherry tomatoes'**
  String get mock_meal_1_lunch_ingredient_2;

  /// No description provided for @mock_meal_1_lunch_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1/2 cucumber'**
  String get mock_meal_1_lunch_ingredient_3;

  /// No description provided for @mock_meal_1_lunch_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp olive oil dressing'**
  String get mock_meal_1_lunch_ingredient_4;

  /// No description provided for @mock_meal_1_lunch_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Slice the grilled chicken and vegetables.'**
  String get mock_meal_1_lunch_instruction_0;

  /// No description provided for @mock_meal_1_lunch_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Combine everything in a bowl and drizzle with olive oil dressing.'**
  String get mock_meal_1_lunch_instruction_1;

  /// No description provided for @mock_meal_1_snack2_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup plain Greek yogurt'**
  String get mock_meal_1_snack2_ingredient_0;

  /// No description provided for @mock_meal_1_snack2_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup mixed berries'**
  String get mock_meal_1_snack2_ingredient_1;

  /// No description provided for @mock_meal_1_snack2_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Spoon the yogurt into a bowl.'**
  String get mock_meal_1_snack2_instruction_0;

  /// No description provided for @mock_meal_1_snack2_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Top with mixed berries just before serving.'**
  String get mock_meal_1_snack2_instruction_1;

  /// No description provided for @mock_meal_1_dinner_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'5 oz salmon fillet'**
  String get mock_meal_1_dinner_ingredient_0;

  /// No description provided for @mock_meal_1_dinner_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 cup roasted broccoli'**
  String get mock_meal_1_dinner_ingredient_1;

  /// No description provided for @mock_meal_1_dinner_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 medium sweet potato'**
  String get mock_meal_1_dinner_ingredient_2;

  /// No description provided for @mock_meal_1_dinner_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 lemon wedge'**
  String get mock_meal_1_dinner_ingredient_3;

  /// No description provided for @mock_meal_1_dinner_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Bake the seasoned salmon and vegetables until tender.'**
  String get mock_meal_1_dinner_instruction_0;

  /// No description provided for @mock_meal_1_dinner_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve with a squeeze of lemon over the top.'**
  String get mock_meal_1_dinner_instruction_1;

  /// No description provided for @mock_meal_2_breakfast_name.
  ///
  /// In en, this message translates to:
  /// **'Scrambled Eggs with Avocado Toast'**
  String get mock_meal_2_breakfast_name;

  /// No description provided for @mock_meal_2_breakfast_desc.
  ///
  /// In en, this message translates to:
  /// **'2 eggs scrambled, 1 slice whole grain toast, 1/2 avocado, cherry tomatoes'**
  String get mock_meal_2_breakfast_desc;

  /// No description provided for @mock_meal_2_snack1_name.
  ///
  /// In en, this message translates to:
  /// **'Protein Smoothie'**
  String get mock_meal_2_snack1_name;

  /// No description provided for @mock_meal_2_snack1_desc.
  ///
  /// In en, this message translates to:
  /// **'Banana, protein powder, almond milk, spinach'**
  String get mock_meal_2_snack1_desc;

  /// No description provided for @mock_meal_2_lunch_name.
  ///
  /// In en, this message translates to:
  /// **'Turkey Wrap with Hummus'**
  String get mock_meal_2_lunch_name;

  /// No description provided for @mock_meal_2_lunch_desc.
  ///
  /// In en, this message translates to:
  /// **'Whole wheat tortilla, 4oz turkey breast, hummus, lettuce, peppers'**
  String get mock_meal_2_lunch_desc;

  /// No description provided for @mock_meal_2_snack2_name.
  ///
  /// In en, this message translates to:
  /// **'Carrot Sticks with Hummus'**
  String get mock_meal_2_snack2_name;

  /// No description provided for @mock_meal_2_snack2_desc.
  ///
  /// In en, this message translates to:
  /// **'1 cup carrot sticks, 1/4 cup hummus'**
  String get mock_meal_2_snack2_desc;

  /// No description provided for @mock_meal_2_dinner_name.
  ///
  /// In en, this message translates to:
  /// **'Chicken Stir-Fry'**
  String get mock_meal_2_dinner_name;

  /// No description provided for @mock_meal_2_dinner_desc.
  ///
  /// In en, this message translates to:
  /// **'5oz chicken breast, mixed vegetables, brown rice, teriyaki sauce'**
  String get mock_meal_2_dinner_desc;

  /// No description provided for @mock_meal_2_breakfast_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'2 large eggs'**
  String get mock_meal_2_breakfast_ingredient_0;

  /// No description provided for @mock_meal_2_breakfast_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 slice whole grain bread'**
  String get mock_meal_2_breakfast_ingredient_1;

  /// No description provided for @mock_meal_2_breakfast_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/2 avocado'**
  String get mock_meal_2_breakfast_ingredient_2;

  /// No description provided for @mock_meal_2_breakfast_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'4 cherry tomatoes'**
  String get mock_meal_2_breakfast_ingredient_3;

  /// No description provided for @mock_meal_2_breakfast_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Scramble the eggs in a non-stick pan until softly set.'**
  String get mock_meal_2_breakfast_instruction_0;

  /// No description provided for @mock_meal_2_breakfast_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Toast the bread, top with mashed avocado, and serve with tomatoes.'**
  String get mock_meal_2_breakfast_instruction_1;

  /// No description provided for @mock_meal_2_snack1_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 banana'**
  String get mock_meal_2_snack1_ingredient_0;

  /// No description provided for @mock_meal_2_snack1_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 scoop protein powder'**
  String get mock_meal_2_snack1_ingredient_1;

  /// No description provided for @mock_meal_2_snack1_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 cup almond milk'**
  String get mock_meal_2_snack1_ingredient_2;

  /// No description provided for @mock_meal_2_snack1_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 cup spinach'**
  String get mock_meal_2_snack1_ingredient_3;

  /// No description provided for @mock_meal_2_snack1_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Add all ingredients to a blender.'**
  String get mock_meal_2_snack1_instruction_0;

  /// No description provided for @mock_meal_2_snack1_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Blend until smooth and creamy, then serve immediately.'**
  String get mock_meal_2_snack1_instruction_1;

  /// No description provided for @mock_meal_2_lunch_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 whole wheat tortilla'**
  String get mock_meal_2_lunch_ingredient_0;

  /// No description provided for @mock_meal_2_lunch_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'4 oz sliced turkey breast'**
  String get mock_meal_2_lunch_ingredient_1;

  /// No description provided for @mock_meal_2_lunch_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp hummus'**
  String get mock_meal_2_lunch_ingredient_2;

  /// No description provided for @mock_meal_2_lunch_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 cup lettuce'**
  String get mock_meal_2_lunch_ingredient_3;

  /// No description provided for @mock_meal_2_lunch_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup sliced bell peppers'**
  String get mock_meal_2_lunch_ingredient_4;

  /// No description provided for @mock_meal_2_lunch_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Spread hummus over the tortilla.'**
  String get mock_meal_2_lunch_instruction_0;

  /// No description provided for @mock_meal_2_lunch_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Layer turkey, lettuce, and peppers, then roll tightly and slice.'**
  String get mock_meal_2_lunch_instruction_1;

  /// No description provided for @mock_meal_2_snack2_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup carrot sticks'**
  String get mock_meal_2_snack2_ingredient_0;

  /// No description provided for @mock_meal_2_snack2_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup hummus'**
  String get mock_meal_2_snack2_ingredient_1;

  /// No description provided for @mock_meal_2_snack2_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Peel and slice the carrots into sticks if needed.'**
  String get mock_meal_2_snack2_instruction_0;

  /// No description provided for @mock_meal_2_snack2_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve with hummus for dipping.'**
  String get mock_meal_2_snack2_instruction_1;

  /// No description provided for @mock_meal_2_dinner_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'5 oz chicken breast'**
  String get mock_meal_2_dinner_ingredient_0;

  /// No description provided for @mock_meal_2_dinner_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'2 cups mixed vegetables'**
  String get mock_meal_2_dinner_ingredient_1;

  /// No description provided for @mock_meal_2_dinner_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 cup brown rice'**
  String get mock_meal_2_dinner_ingredient_2;

  /// No description provided for @mock_meal_2_dinner_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp teriyaki sauce'**
  String get mock_meal_2_dinner_ingredient_3;

  /// No description provided for @mock_meal_2_dinner_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Stir-fry the chicken until nearly cooked through.'**
  String get mock_meal_2_dinner_instruction_0;

  /// No description provided for @mock_meal_2_dinner_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Add vegetables and sauce, cook until crisp-tender, and serve over rice.'**
  String get mock_meal_2_dinner_instruction_1;

  /// No description provided for @mock_meal_3_breakfast_name.
  ///
  /// In en, this message translates to:
  /// **'Greek Yogurt Parfait'**
  String get mock_meal_3_breakfast_name;

  /// No description provided for @mock_meal_3_breakfast_desc.
  ///
  /// In en, this message translates to:
  /// **'Greek yogurt layered with granola, berries, and honey'**
  String get mock_meal_3_breakfast_desc;

  /// No description provided for @mock_meal_3_snack1_name.
  ///
  /// In en, this message translates to:
  /// **'Mixed Nuts'**
  String get mock_meal_3_snack1_name;

  /// No description provided for @mock_meal_3_snack1_desc.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup mixed almonds, cashews, and walnuts'**
  String get mock_meal_3_snack1_desc;

  /// No description provided for @mock_meal_3_lunch_name.
  ///
  /// In en, this message translates to:
  /// **'Quinoa Buddha Bowl'**
  String get mock_meal_3_lunch_name;

  /// No description provided for @mock_meal_3_lunch_desc.
  ///
  /// In en, this message translates to:
  /// **'Quinoa, roasted chickpeas, avocado, vegetables, tahini dressing'**
  String get mock_meal_3_lunch_desc;

  /// No description provided for @mock_meal_3_snack2_name.
  ///
  /// In en, this message translates to:
  /// **'Cottage Cheese with Pineapple'**
  String get mock_meal_3_snack2_name;

  /// No description provided for @mock_meal_3_snack2_desc.
  ///
  /// In en, this message translates to:
  /// **'1 cup low-fat cottage cheese, 1/2 cup pineapple chunks'**
  String get mock_meal_3_snack2_desc;

  /// No description provided for @mock_meal_3_dinner_name.
  ///
  /// In en, this message translates to:
  /// **'Lean Beef Tacos'**
  String get mock_meal_3_dinner_name;

  /// No description provided for @mock_meal_3_dinner_desc.
  ///
  /// In en, this message translates to:
  /// **'Lean ground beef, corn tortillas, lettuce, tomato, salsa'**
  String get mock_meal_3_dinner_desc;

  /// No description provided for @mock_meal_3_breakfast_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup Greek yogurt'**
  String get mock_meal_3_breakfast_ingredient_0;

  /// No description provided for @mock_meal_3_breakfast_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup granola'**
  String get mock_meal_3_breakfast_ingredient_1;

  /// No description provided for @mock_meal_3_breakfast_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup mixed berries'**
  String get mock_meal_3_breakfast_ingredient_2;

  /// No description provided for @mock_meal_3_breakfast_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 tsp honey'**
  String get mock_meal_3_breakfast_ingredient_3;

  /// No description provided for @mock_meal_3_breakfast_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Layer yogurt, granola, and berries in a glass or bowl.'**
  String get mock_meal_3_breakfast_instruction_0;

  /// No description provided for @mock_meal_3_breakfast_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Drizzle honey over the top before serving.'**
  String get mock_meal_3_breakfast_instruction_1;

  /// No description provided for @mock_meal_3_snack1_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup mixed nuts'**
  String get mock_meal_3_snack1_ingredient_0;

  /// No description provided for @mock_meal_3_snack1_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Portion the mixed nuts into a small bowl or container.'**
  String get mock_meal_3_snack1_instruction_0;

  /// No description provided for @mock_meal_3_snack1_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Enjoy immediately or pack to-go for later.'**
  String get mock_meal_3_snack1_instruction_1;

  /// No description provided for @mock_meal_3_lunch_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup cooked quinoa'**
  String get mock_meal_3_lunch_ingredient_0;

  /// No description provided for @mock_meal_3_lunch_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup roasted chickpeas'**
  String get mock_meal_3_lunch_ingredient_1;

  /// No description provided for @mock_meal_3_lunch_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/2 avocado'**
  String get mock_meal_3_lunch_ingredient_2;

  /// No description provided for @mock_meal_3_lunch_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 cup mixed vegetables'**
  String get mock_meal_3_lunch_ingredient_3;

  /// No description provided for @mock_meal_3_lunch_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp tahini dressing'**
  String get mock_meal_3_lunch_ingredient_4;

  /// No description provided for @mock_meal_3_lunch_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Warm the quinoa and arrange it in a bowl.'**
  String get mock_meal_3_lunch_instruction_0;

  /// No description provided for @mock_meal_3_lunch_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Top with chickpeas, vegetables, avocado, and drizzle with tahini dressing.'**
  String get mock_meal_3_lunch_instruction_1;

  /// No description provided for @mock_meal_3_snack2_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup low-fat cottage cheese'**
  String get mock_meal_3_snack2_ingredient_0;

  /// No description provided for @mock_meal_3_snack2_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup pineapple chunks'**
  String get mock_meal_3_snack2_ingredient_1;

  /// No description provided for @mock_meal_3_snack2_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Scoop cottage cheese into a serving bowl.'**
  String get mock_meal_3_snack2_instruction_0;

  /// No description provided for @mock_meal_3_snack2_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Top with pineapple chunks and enjoy.'**
  String get mock_meal_3_snack2_instruction_1;

  /// No description provided for @mock_meal_3_dinner_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'5 oz lean ground beef'**
  String get mock_meal_3_dinner_ingredient_0;

  /// No description provided for @mock_meal_3_dinner_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'2 corn tortillas'**
  String get mock_meal_3_dinner_ingredient_1;

  /// No description provided for @mock_meal_3_dinner_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 cup shredded lettuce'**
  String get mock_meal_3_dinner_ingredient_2;

  /// No description provided for @mock_meal_3_dinner_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 diced tomato'**
  String get mock_meal_3_dinner_ingredient_3;

  /// No description provided for @mock_meal_3_dinner_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp salsa'**
  String get mock_meal_3_dinner_ingredient_4;

  /// No description provided for @mock_meal_3_dinner_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Cook the ground beef with seasonings until browned.'**
  String get mock_meal_3_dinner_instruction_0;

  /// No description provided for @mock_meal_3_dinner_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Warm the tortillas, then assemble with lettuce, tomato, and salsa.'**
  String get mock_meal_3_dinner_instruction_1;

  /// No description provided for @mock_meal_4_breakfast_name.
  ///
  /// In en, this message translates to:
  /// **'Whole Grain Pancakes'**
  String get mock_meal_4_breakfast_name;

  /// No description provided for @mock_meal_4_breakfast_desc.
  ///
  /// In en, this message translates to:
  /// **'2 whole grain pancakes, fresh berries, maple syrup'**
  String get mock_meal_4_breakfast_desc;

  /// No description provided for @mock_meal_4_snack1_name.
  ///
  /// In en, this message translates to:
  /// **'Pear with String Cheese'**
  String get mock_meal_4_snack1_name;

  /// No description provided for @mock_meal_4_snack1_desc.
  ///
  /// In en, this message translates to:
  /// **'1 medium pear, 1 string cheese'**
  String get mock_meal_4_snack1_desc;

  /// No description provided for @mock_meal_4_lunch_name.
  ///
  /// In en, this message translates to:
  /// **'Tuna Salad'**
  String get mock_meal_4_lunch_name;

  /// No description provided for @mock_meal_4_lunch_desc.
  ///
  /// In en, this message translates to:
  /// **'Tuna, mixed greens, hard-boiled egg, olives, olive oil'**
  String get mock_meal_4_lunch_desc;

  /// No description provided for @mock_meal_4_snack2_name.
  ///
  /// In en, this message translates to:
  /// **'Protein Bar'**
  String get mock_meal_4_snack2_name;

  /// No description provided for @mock_meal_4_snack2_desc.
  ///
  /// In en, this message translates to:
  /// **'1 protein bar (aim for 10g+ protein)'**
  String get mock_meal_4_snack2_desc;

  /// No description provided for @mock_meal_4_dinner_name.
  ///
  /// In en, this message translates to:
  /// **'Baked Chicken with Quinoa'**
  String get mock_meal_4_dinner_name;

  /// No description provided for @mock_meal_4_dinner_desc.
  ///
  /// In en, this message translates to:
  /// **'Herb-crusted chicken breast, quinoa, roasted asparagus'**
  String get mock_meal_4_dinner_desc;

  /// No description provided for @mock_meal_4_breakfast_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'2 whole grain pancakes'**
  String get mock_meal_4_breakfast_ingredient_0;

  /// No description provided for @mock_meal_4_breakfast_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup fresh berries'**
  String get mock_meal_4_breakfast_ingredient_1;

  /// No description provided for @mock_meal_4_breakfast_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 tbsp maple syrup'**
  String get mock_meal_4_breakfast_ingredient_2;

  /// No description provided for @mock_meal_4_breakfast_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Warm the pancakes in a skillet or toaster if needed.'**
  String get mock_meal_4_breakfast_instruction_0;

  /// No description provided for @mock_meal_4_breakfast_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve with berries on top and drizzle with maple syrup.'**
  String get mock_meal_4_breakfast_instruction_1;

  /// No description provided for @mock_meal_4_snack1_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 medium pear'**
  String get mock_meal_4_snack1_ingredient_0;

  /// No description provided for @mock_meal_4_snack1_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 string cheese'**
  String get mock_meal_4_snack1_ingredient_1;

  /// No description provided for @mock_meal_4_snack1_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Wash the pear and slice if desired.'**
  String get mock_meal_4_snack1_instruction_0;

  /// No description provided for @mock_meal_4_snack1_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Pair with string cheese for a quick snack.'**
  String get mock_meal_4_snack1_instruction_1;

  /// No description provided for @mock_meal_4_lunch_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 can tuna in water'**
  String get mock_meal_4_lunch_ingredient_0;

  /// No description provided for @mock_meal_4_lunch_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'2 cups mixed greens'**
  String get mock_meal_4_lunch_ingredient_1;

  /// No description provided for @mock_meal_4_lunch_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 hard-boiled egg'**
  String get mock_meal_4_lunch_ingredient_2;

  /// No description provided for @mock_meal_4_lunch_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'5 olives'**
  String get mock_meal_4_lunch_ingredient_3;

  /// No description provided for @mock_meal_4_lunch_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp olive oil'**
  String get mock_meal_4_lunch_ingredient_4;

  /// No description provided for @mock_meal_4_lunch_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Drain the tuna and slice the egg and olives.'**
  String get mock_meal_4_lunch_instruction_0;

  /// No description provided for @mock_meal_4_lunch_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Combine ingredients with greens and drizzle with olive oil.'**
  String get mock_meal_4_lunch_instruction_1;

  /// No description provided for @mock_meal_4_snack2_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 protein bar'**
  String get mock_meal_4_snack2_ingredient_0;

  /// No description provided for @mock_meal_4_snack2_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Unwrap the protein bar and enjoy as a quick snack.'**
  String get mock_meal_4_snack2_instruction_0;

  /// No description provided for @mock_meal_4_dinner_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'5 oz chicken breast'**
  String get mock_meal_4_dinner_ingredient_0;

  /// No description provided for @mock_meal_4_dinner_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 cup cooked quinoa'**
  String get mock_meal_4_dinner_ingredient_1;

  /// No description provided for @mock_meal_4_dinner_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 cup roasted asparagus'**
  String get mock_meal_4_dinner_ingredient_2;

  /// No description provided for @mock_meal_4_dinner_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'to taste herbs and spices'**
  String get mock_meal_4_dinner_ingredient_3;

  /// No description provided for @mock_meal_4_dinner_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Bake the seasoned chicken until cooked through.'**
  String get mock_meal_4_dinner_instruction_0;

  /// No description provided for @mock_meal_4_dinner_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve alongside quinoa and roasted asparagus.'**
  String get mock_meal_4_dinner_instruction_1;

  /// No description provided for @mock_meal_5_breakfast_name.
  ///
  /// In en, this message translates to:
  /// **'Veggie Omelet'**
  String get mock_meal_5_breakfast_name;

  /// No description provided for @mock_meal_5_breakfast_desc.
  ///
  /// In en, this message translates to:
  /// **'3-egg omelet with spinach, mushrooms, and feta cheese'**
  String get mock_meal_5_breakfast_desc;

  /// No description provided for @mock_meal_5_snack1_name.
  ///
  /// In en, this message translates to:
  /// **'Banana with Peanut Butter'**
  String get mock_meal_5_snack1_name;

  /// No description provided for @mock_meal_5_snack1_desc.
  ///
  /// In en, this message translates to:
  /// **'1 medium banana, 1 tbsp peanut butter'**
  String get mock_meal_5_snack1_desc;

  /// No description provided for @mock_meal_5_lunch_name.
  ///
  /// In en, this message translates to:
  /// **'Mediterranean Chicken Bowl'**
  String get mock_meal_5_lunch_name;

  /// No description provided for @mock_meal_5_lunch_desc.
  ///
  /// In en, this message translates to:
  /// **'Grilled chicken, brown rice, hummus, cucumber, tomatoes, olives'**
  String get mock_meal_5_lunch_desc;

  /// No description provided for @mock_meal_5_snack2_name.
  ///
  /// In en, this message translates to:
  /// **'Rice Cakes with Avocado'**
  String get mock_meal_5_snack2_name;

  /// No description provided for @mock_meal_5_snack2_desc.
  ///
  /// In en, this message translates to:
  /// **'2 rice cakes topped with mashed avocado'**
  String get mock_meal_5_snack2_desc;

  /// No description provided for @mock_meal_5_dinner_name.
  ///
  /// In en, this message translates to:
  /// **'Shrimp Pasta Primavera'**
  String get mock_meal_5_dinner_name;

  /// No description provided for @mock_meal_5_dinner_desc.
  ///
  /// In en, this message translates to:
  /// **'Whole wheat pasta, shrimp, mixed vegetables, garlic olive oil'**
  String get mock_meal_5_dinner_desc;

  /// No description provided for @mock_meal_5_breakfast_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'3 large eggs'**
  String get mock_meal_5_breakfast_ingredient_0;

  /// No description provided for @mock_meal_5_breakfast_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 cup spinach'**
  String get mock_meal_5_breakfast_ingredient_1;

  /// No description provided for @mock_meal_5_breakfast_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup mushrooms'**
  String get mock_meal_5_breakfast_ingredient_2;

  /// No description provided for @mock_meal_5_breakfast_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp feta cheese'**
  String get mock_meal_5_breakfast_ingredient_3;

  /// No description provided for @mock_meal_5_breakfast_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Sauté mushrooms and spinach until tender.'**
  String get mock_meal_5_breakfast_instruction_0;

  /// No description provided for @mock_meal_5_breakfast_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Add beaten eggs, cook until set, and sprinkle with feta before folding.'**
  String get mock_meal_5_breakfast_instruction_1;

  /// No description provided for @mock_meal_5_snack1_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 medium banana'**
  String get mock_meal_5_snack1_ingredient_0;

  /// No description provided for @mock_meal_5_snack1_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 tbsp peanut butter'**
  String get mock_meal_5_snack1_ingredient_1;

  /// No description provided for @mock_meal_5_snack1_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Peel the banana and slice if desired.'**
  String get mock_meal_5_snack1_instruction_0;

  /// No description provided for @mock_meal_5_snack1_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve with peanut butter for dipping or spreading.'**
  String get mock_meal_5_snack1_instruction_1;

  /// No description provided for @mock_meal_5_lunch_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'4 oz grilled chicken'**
  String get mock_meal_5_lunch_ingredient_0;

  /// No description provided for @mock_meal_5_lunch_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 cup brown rice'**
  String get mock_meal_5_lunch_ingredient_1;

  /// No description provided for @mock_meal_5_lunch_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp hummus'**
  String get mock_meal_5_lunch_ingredient_2;

  /// No description provided for @mock_meal_5_lunch_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1/2 cucumber'**
  String get mock_meal_5_lunch_ingredient_3;

  /// No description provided for @mock_meal_5_lunch_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup tomatoes'**
  String get mock_meal_5_lunch_ingredient_4;

  /// No description provided for @mock_meal_5_lunch_ingredient_5.
  ///
  /// In en, this message translates to:
  /// **'5 olives'**
  String get mock_meal_5_lunch_ingredient_5;

  /// No description provided for @mock_meal_5_lunch_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Layer rice in a bowl and top with sliced chicken.'**
  String get mock_meal_5_lunch_instruction_0;

  /// No description provided for @mock_meal_5_lunch_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Add hummus, cucumber, tomatoes, and olives before serving.'**
  String get mock_meal_5_lunch_instruction_1;

  /// No description provided for @mock_meal_5_snack2_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'2 rice cakes'**
  String get mock_meal_5_snack2_ingredient_0;

  /// No description provided for @mock_meal_5_snack2_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 avocado'**
  String get mock_meal_5_snack2_ingredient_1;

  /// No description provided for @mock_meal_5_snack2_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Mash the avocado with a fork and season if desired.'**
  String get mock_meal_5_snack2_instruction_0;

  /// No description provided for @mock_meal_5_snack2_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Spread over rice cakes and serve immediately.'**
  String get mock_meal_5_snack2_instruction_1;

  /// No description provided for @mock_meal_5_dinner_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'2 oz whole wheat pasta'**
  String get mock_meal_5_dinner_ingredient_0;

  /// No description provided for @mock_meal_5_dinner_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'5 oz shrimp'**
  String get mock_meal_5_dinner_ingredient_1;

  /// No description provided for @mock_meal_5_dinner_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'2 cups mixed vegetables'**
  String get mock_meal_5_dinner_ingredient_2;

  /// No description provided for @mock_meal_5_dinner_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp garlic olive oil'**
  String get mock_meal_5_dinner_ingredient_3;

  /// No description provided for @mock_meal_5_dinner_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Cook the pasta until al dente and reserve a little cooking water.'**
  String get mock_meal_5_dinner_instruction_0;

  /// No description provided for @mock_meal_5_dinner_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Sauté shrimp and vegetables in garlic oil, then toss with pasta.'**
  String get mock_meal_5_dinner_instruction_1;

  /// No description provided for @mock_meal_6_breakfast_name.
  ///
  /// In en, this message translates to:
  /// **'Breakfast Burrito'**
  String get mock_meal_6_breakfast_name;

  /// No description provided for @mock_meal_6_breakfast_desc.
  ///
  /// In en, this message translates to:
  /// **'Scrambled eggs, black beans, cheese, salsa in whole wheat tortilla'**
  String get mock_meal_6_breakfast_desc;

  /// No description provided for @mock_meal_6_snack1_name.
  ///
  /// In en, this message translates to:
  /// **'Trail Mix'**
  String get mock_meal_6_snack1_name;

  /// No description provided for @mock_meal_6_snack1_desc.
  ///
  /// In en, this message translates to:
  /// **'Mixed nuts, dried cranberries, dark chocolate chips'**
  String get mock_meal_6_snack1_desc;

  /// No description provided for @mock_meal_6_lunch_name.
  ///
  /// In en, this message translates to:
  /// **'Grilled Veggie Sandwich'**
  String get mock_meal_6_lunch_name;

  /// No description provided for @mock_meal_6_lunch_desc.
  ///
  /// In en, this message translates to:
  /// **'Grilled zucchini, peppers, mozzarella on whole grain bread'**
  String get mock_meal_6_lunch_desc;

  /// No description provided for @mock_meal_6_snack2_name.
  ///
  /// In en, this message translates to:
  /// **'Edamame'**
  String get mock_meal_6_snack2_name;

  /// No description provided for @mock_meal_6_snack2_desc.
  ///
  /// In en, this message translates to:
  /// **'1 cup steamed edamame with sea salt'**
  String get mock_meal_6_snack2_desc;

  /// No description provided for @mock_meal_6_dinner_name.
  ///
  /// In en, this message translates to:
  /// **'Grilled Steak with Vegetables'**
  String get mock_meal_6_dinner_name;

  /// No description provided for @mock_meal_6_dinner_desc.
  ///
  /// In en, this message translates to:
  /// **'Lean sirloin steak, roasted Brussels sprouts and carrots'**
  String get mock_meal_6_dinner_desc;

  /// No description provided for @mock_meal_6_breakfast_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'2 scrambled eggs'**
  String get mock_meal_6_breakfast_ingredient_0;

  /// No description provided for @mock_meal_6_breakfast_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup black beans'**
  String get mock_meal_6_breakfast_ingredient_1;

  /// No description provided for @mock_meal_6_breakfast_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp shredded cheese'**
  String get mock_meal_6_breakfast_ingredient_2;

  /// No description provided for @mock_meal_6_breakfast_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp salsa'**
  String get mock_meal_6_breakfast_ingredient_3;

  /// No description provided for @mock_meal_6_breakfast_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'1 whole wheat tortilla'**
  String get mock_meal_6_breakfast_ingredient_4;

  /// No description provided for @mock_meal_6_breakfast_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Warm the tortilla and scramble the eggs with beans.'**
  String get mock_meal_6_breakfast_instruction_0;

  /// No description provided for @mock_meal_6_breakfast_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Fill the tortilla, top with cheese and salsa, then roll tightly.'**
  String get mock_meal_6_breakfast_instruction_1;

  /// No description provided for @mock_meal_6_snack1_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup mixed nuts'**
  String get mock_meal_6_snack1_ingredient_0;

  /// No description provided for @mock_meal_6_snack1_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp dried cranberries'**
  String get mock_meal_6_snack1_ingredient_1;

  /// No description provided for @mock_meal_6_snack1_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 tbsp dark chocolate chips'**
  String get mock_meal_6_snack1_ingredient_2;

  /// No description provided for @mock_meal_6_snack1_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Combine nuts, cranberries, and chocolate chips in a small bowl.'**
  String get mock_meal_6_snack1_instruction_0;

  /// No description provided for @mock_meal_6_snack1_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Portion into a to-go container if needed.'**
  String get mock_meal_6_snack1_instruction_1;

  /// No description provided for @mock_meal_6_lunch_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'2 slices whole grain bread'**
  String get mock_meal_6_lunch_ingredient_0;

  /// No description provided for @mock_meal_6_lunch_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 grilled zucchini'**
  String get mock_meal_6_lunch_ingredient_1;

  /// No description provided for @mock_meal_6_lunch_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup grilled peppers'**
  String get mock_meal_6_lunch_ingredient_2;

  /// No description provided for @mock_meal_6_lunch_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'2 slices fresh mozzarella'**
  String get mock_meal_6_lunch_ingredient_3;

  /// No description provided for @mock_meal_6_lunch_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'1 tbsp balsamic glaze'**
  String get mock_meal_6_lunch_ingredient_4;

  /// No description provided for @mock_meal_6_lunch_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Layer grilled vegetables and mozzarella on the bread.'**
  String get mock_meal_6_lunch_instruction_0;

  /// No description provided for @mock_meal_6_lunch_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Drizzle with balsamic glaze and toast until cheese melts if desired.'**
  String get mock_meal_6_lunch_instruction_1;

  /// No description provided for @mock_meal_6_snack2_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup edamame'**
  String get mock_meal_6_snack2_ingredient_0;

  /// No description provided for @mock_meal_6_snack2_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'to taste sea salt'**
  String get mock_meal_6_snack2_ingredient_1;

  /// No description provided for @mock_meal_6_snack2_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Steam or microwave the edamame until heated through.'**
  String get mock_meal_6_snack2_instruction_0;

  /// No description provided for @mock_meal_6_snack2_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Sprinkle with sea salt before serving.'**
  String get mock_meal_6_snack2_instruction_1;

  /// No description provided for @mock_meal_6_dinner_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'5 oz lean sirloin steak'**
  String get mock_meal_6_dinner_ingredient_0;

  /// No description provided for @mock_meal_6_dinner_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 cup roasted Brussels sprouts'**
  String get mock_meal_6_dinner_ingredient_1;

  /// No description provided for @mock_meal_6_dinner_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 cup roasted carrots'**
  String get mock_meal_6_dinner_ingredient_2;

  /// No description provided for @mock_meal_6_dinner_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Grill or sear the steak to your preferred doneness.'**
  String get mock_meal_6_dinner_instruction_0;

  /// No description provided for @mock_meal_6_dinner_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve with roasted Brussels sprouts and carrots on the side.'**
  String get mock_meal_6_dinner_instruction_1;

  /// No description provided for @mock_meal_7_breakfast_name.
  ///
  /// In en, this message translates to:
  /// **'French Toast with Fruit'**
  String get mock_meal_7_breakfast_name;

  /// No description provided for @mock_meal_7_breakfast_desc.
  ///
  /// In en, this message translates to:
  /// **'Whole grain French toast, fresh berries, yogurt drizzle'**
  String get mock_meal_7_breakfast_desc;

  /// No description provided for @mock_meal_7_snack1_name.
  ///
  /// In en, this message translates to:
  /// **'Celery with Peanut Butter'**
  String get mock_meal_7_snack1_name;

  /// No description provided for @mock_meal_7_snack1_desc.
  ///
  /// In en, this message translates to:
  /// **'4 celery sticks with 2 tbsp peanut butter'**
  String get mock_meal_7_snack1_desc;

  /// No description provided for @mock_meal_7_lunch_name.
  ///
  /// In en, this message translates to:
  /// **'Chicken Caesar Salad'**
  String get mock_meal_7_lunch_name;

  /// No description provided for @mock_meal_7_lunch_desc.
  ///
  /// In en, this message translates to:
  /// **'Grilled chicken, romaine lettuce, parmesan, light Caesar dressing'**
  String get mock_meal_7_lunch_desc;

  /// No description provided for @mock_meal_7_snack2_name.
  ///
  /// In en, this message translates to:
  /// **'Smoothie Bowl'**
  String get mock_meal_7_snack2_name;

  /// No description provided for @mock_meal_7_snack2_desc.
  ///
  /// In en, this message translates to:
  /// **'Blended berries, banana, topped with granola and chia seeds'**
  String get mock_meal_7_snack2_desc;

  /// No description provided for @mock_meal_7_dinner_name.
  ///
  /// In en, this message translates to:
  /// **'Baked Cod with Sweet Potato'**
  String get mock_meal_7_dinner_name;

  /// No description provided for @mock_meal_7_dinner_desc.
  ///
  /// In en, this message translates to:
  /// **'Herb-baked cod, mashed sweet potato, steamed green beans'**
  String get mock_meal_7_dinner_desc;

  /// No description provided for @mock_meal_7_breakfast_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'2 slices whole grain bread'**
  String get mock_meal_7_breakfast_ingredient_0;

  /// No description provided for @mock_meal_7_breakfast_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 egg'**
  String get mock_meal_7_breakfast_ingredient_1;

  /// No description provided for @mock_meal_7_breakfast_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup mixed berries'**
  String get mock_meal_7_breakfast_ingredient_2;

  /// No description provided for @mock_meal_7_breakfast_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp Greek yogurt'**
  String get mock_meal_7_breakfast_ingredient_3;

  /// No description provided for @mock_meal_7_breakfast_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'1 tsp cinnamon'**
  String get mock_meal_7_breakfast_ingredient_4;

  /// No description provided for @mock_meal_7_breakfast_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Whisk the egg with cinnamon and soak the bread slices.'**
  String get mock_meal_7_breakfast_instruction_0;

  /// No description provided for @mock_meal_7_breakfast_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Cook on a griddle until golden, then top with berries and yogurt.'**
  String get mock_meal_7_breakfast_instruction_1;

  /// No description provided for @mock_meal_7_snack1_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'4 celery sticks'**
  String get mock_meal_7_snack1_ingredient_0;

  /// No description provided for @mock_meal_7_snack1_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp peanut butter'**
  String get mock_meal_7_snack1_ingredient_1;

  /// No description provided for @mock_meal_7_snack1_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Wash and trim the celery sticks.'**
  String get mock_meal_7_snack1_instruction_0;

  /// No description provided for @mock_meal_7_snack1_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Fill the celery grooves with peanut butter.'**
  String get mock_meal_7_snack1_instruction_1;

  /// No description provided for @mock_meal_7_lunch_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'4 oz grilled chicken breast'**
  String get mock_meal_7_lunch_ingredient_0;

  /// No description provided for @mock_meal_7_lunch_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'2 cups romaine lettuce'**
  String get mock_meal_7_lunch_ingredient_1;

  /// No description provided for @mock_meal_7_lunch_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp parmesan cheese'**
  String get mock_meal_7_lunch_ingredient_2;

  /// No description provided for @mock_meal_7_lunch_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'2 tbsp light Caesar dressing'**
  String get mock_meal_7_lunch_ingredient_3;

  /// No description provided for @mock_meal_7_lunch_ingredient_4.
  ///
  /// In en, this message translates to:
  /// **'1/2 cup whole grain croutons'**
  String get mock_meal_7_lunch_ingredient_4;

  /// No description provided for @mock_meal_7_lunch_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Chop the lettuce and slice the grilled chicken.'**
  String get mock_meal_7_lunch_instruction_0;

  /// No description provided for @mock_meal_7_lunch_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Toss with dressing, parmesan, and croutons before serving.'**
  String get mock_meal_7_lunch_instruction_1;

  /// No description provided for @mock_meal_7_snack2_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'1 cup mixed berries'**
  String get mock_meal_7_snack2_ingredient_0;

  /// No description provided for @mock_meal_7_snack2_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1/2 banana'**
  String get mock_meal_7_snack2_ingredient_1;

  /// No description provided for @mock_meal_7_snack2_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1/4 cup granola'**
  String get mock_meal_7_snack2_ingredient_2;

  /// No description provided for @mock_meal_7_snack2_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'1 tbsp chia seeds'**
  String get mock_meal_7_snack2_ingredient_3;

  /// No description provided for @mock_meal_7_snack2_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Blend the berries and banana until smooth.'**
  String get mock_meal_7_snack2_instruction_0;

  /// No description provided for @mock_meal_7_snack2_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Pour into a bowl and top with granola and chia seeds.'**
  String get mock_meal_7_snack2_instruction_1;

  /// No description provided for @mock_meal_7_dinner_ingredient_0.
  ///
  /// In en, this message translates to:
  /// **'5 oz cod fillet'**
  String get mock_meal_7_dinner_ingredient_0;

  /// No description provided for @mock_meal_7_dinner_ingredient_1.
  ///
  /// In en, this message translates to:
  /// **'1 medium sweet potato'**
  String get mock_meal_7_dinner_ingredient_1;

  /// No description provided for @mock_meal_7_dinner_ingredient_2.
  ///
  /// In en, this message translates to:
  /// **'1 cup green beans'**
  String get mock_meal_7_dinner_ingredient_2;

  /// No description provided for @mock_meal_7_dinner_ingredient_3.
  ///
  /// In en, this message translates to:
  /// **'to taste herbs and lemon'**
  String get mock_meal_7_dinner_ingredient_3;

  /// No description provided for @mock_meal_7_dinner_instruction_0.
  ///
  /// In en, this message translates to:
  /// **'Season the cod with herbs and lemon, then bake until flaky.'**
  String get mock_meal_7_dinner_instruction_0;

  /// No description provided for @mock_meal_7_dinner_instruction_1.
  ///
  /// In en, this message translates to:
  /// **'Serve with mashed sweet potato and steamed green beans.'**
  String get mock_meal_7_dinner_instruction_1;

  /// No description provided for @dashboard_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dashboard_today;

  /// No description provided for @dashboard_greeting_unlogged_3.
  ///
  /// In en, this message translates to:
  /// **'Let’s log a few meals while the details are fresh.'**
  String get dashboard_greeting_unlogged_3;

  /// No description provided for @dashboard_greeting_unlogged_2.
  ///
  /// In en, this message translates to:
  /// **'Two meals are waiting for a log — quick updates help a ton.'**
  String get dashboard_greeting_unlogged_2;

  /// No description provided for @dashboard_greeting_unlogged_1.
  ///
  /// In en, this message translates to:
  /// **'One meal needs a quick log to stay on track.'**
  String get dashboard_greeting_unlogged_1;

  /// No description provided for @dashboard_greeting_all_set.
  ///
  /// In en, this message translates to:
  /// **'You’re all set until the next meal.'**
  String get dashboard_greeting_all_set;

  /// No description provided for @dashboard_greeting_good_job.
  ///
  /// In en, this message translates to:
  /// **'Nice work staying current — keep the momentum going.'**
  String get dashboard_greeting_good_job;

  /// No description provided for @dashboard_status_overdue.
  ///
  /// In en, this message translates to:
  /// **'{count} {label} overdue'**
  String dashboard_status_overdue(int count, String label);

  /// No description provided for @dashboard_status_logged.
  ///
  /// In en, this message translates to:
  /// **'{count} {label} logged'**
  String dashboard_status_logged(int count, String label);

  /// No description provided for @mealLabel.
  ///
  /// In en, this message translates to:
  /// **'meal'**
  String get mealLabel;

  /// No description provided for @mealsLabel.
  ///
  /// In en, this message translates to:
  /// **'meals'**
  String get mealsLabel;

  /// No description provided for @mock_mealPlanName.
  ///
  /// In en, this message translates to:
  /// **'Week 1 Meal Plan'**
  String get mock_mealPlanName;

  /// No description provided for @mock_endurancePlanName.
  ///
  /// In en, this message translates to:
  /// **'Endurance Support Plan'**
  String get mock_endurancePlanName;

  /// No description provided for @mock_consultation_1_focusArea_0.
  ///
  /// In en, this message translates to:
  /// **'Stabilise fasting glucose'**
  String get mock_consultation_1_focusArea_0;

  /// No description provided for @mock_consultation_1_focusArea_1.
  ///
  /// In en, this message translates to:
  /// **'Reintroduce strength training fuel'**
  String get mock_consultation_1_focusArea_1;

  /// No description provided for @mock_consultation_1_preparationNote_0.
  ///
  /// In en, this message translates to:
  /// **'Upload latest glucometer exports'**
  String get mock_consultation_1_preparationNote_0;

  /// No description provided for @mock_consultation_1_preparationNote_1.
  ///
  /// In en, this message translates to:
  /// **'Track hydration for 3 days prior'**
  String get mock_consultation_1_preparationNote_1;

  /// No description provided for @mock_consultation_2_focusArea_0.
  ///
  /// In en, this message translates to:
  /// **'Dial in pre-run fuelling'**
  String get mock_consultation_2_focusArea_0;

  /// No description provided for @mock_consultation_2_focusArea_1.
  ///
  /// In en, this message translates to:
  /// **'Adjust fibre targets'**
  String get mock_consultation_2_focusArea_1;

  /// No description provided for @mock_consultation_2_preparationNote_0.
  ///
  /// In en, this message translates to:
  /// **'Bring food journal for previous 14 days'**
  String get mock_consultation_2_preparationNote_0;

  /// No description provided for @mock_consultation_2_preparationNote_1.
  ///
  /// In en, this message translates to:
  /// **'Note any hypoglycaemia symptoms'**
  String get mock_consultation_2_preparationNote_1;

  /// No description provided for @dashboard_catchUp.
  ///
  /// In en, this message translates to:
  /// **'Catch up'**
  String get dashboard_catchUp;

  /// No description provided for @dashboard_logNow.
  ///
  /// In en, this message translates to:
  /// **'Log now'**
  String get dashboard_logNow;

  /// No description provided for @dashboard_needsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get dashboard_needsAttention;

  /// No description provided for @dashboard_pendingMealsSwipeHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe overdue and due meals to keep your log current.'**
  String get dashboard_pendingMealsSwipeHint;

  /// No description provided for @dashboard_pendingMealsSeveritySeveral.
  ///
  /// In en, this message translates to:
  /// **'Several meals are waiting — capturing them now keeps your data accurate.'**
  String get dashboard_pendingMealsSeveritySeveral;

  /// No description provided for @dashboard_pendingMealsSeverityTwo.
  ///
  /// In en, this message translates to:
  /// **'Two meals need attention — a couple quick logs will close the gap.'**
  String get dashboard_pendingMealsSeverityTwo;

  /// No description provided for @dashboard_pendingMealsSeverityOne.
  ///
  /// In en, this message translates to:
  /// **'One meal is ready to log — take a moment to record it.'**
  String get dashboard_pendingMealsSeverityOne;

  /// No description provided for @dashboard_comingUp.
  ///
  /// In en, this message translates to:
  /// **'Coming up'**
  String get dashboard_comingUp;

  /// No description provided for @dashboard_nextMeal.
  ///
  /// In en, this message translates to:
  /// **'Next meal'**
  String get dashboard_nextMeal;

  /// No description provided for @dashboard_logged.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get dashboard_logged;

  /// No description provided for @dashboard_scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled {time} • {relativeTime}'**
  String dashboard_scheduled(String time, String relativeTime);

  /// No description provided for @dashboard_scheduled_full.
  ///
  /// In en, this message translates to:
  /// **'{time} • {mealType} • {relativeTime}'**
  String dashboard_scheduled_full(
      String time, String mealType, String relativeTime);

  /// No description provided for @dashboard_logged_full.
  ///
  /// In en, this message translates to:
  /// **'{time} • {mealType}'**
  String dashboard_logged_full(String time, String mealType);

  /// No description provided for @dashboard_logSomethingElse.
  ///
  /// In en, this message translates to:
  /// **'Log something else'**
  String get dashboard_logSomethingElse;

  /// No description provided for @dashboard_greatJob.
  ///
  /// In en, this message translates to:
  /// **'Great job!'**
  String get dashboard_greatJob;

  /// No description provided for @dashboard_noted.
  ///
  /// In en, this message translates to:
  /// **'Noted'**
  String get dashboard_noted;

  /// No description provided for @dashboard_logSuccess.
  ///
  /// In en, this message translates to:
  /// **'Log was successfully saved'**
  String get dashboard_logSuccess;

  /// No description provided for @dashboard_followedRecipe.
  ///
  /// In en, this message translates to:
  /// **'Followed recipe'**
  String get dashboard_followedRecipe;

  /// No description provided for @dashboard_followedMeal.
  ///
  /// In en, this message translates to:
  /// **'Followed meal'**
  String get dashboard_followedMeal;

  /// No description provided for @dashboard_skippedMeal.
  ///
  /// In en, this message translates to:
  /// **'Skipped meal'**
  String get dashboard_skippedMeal;

  /// No description provided for @dashboard_thanksTrack.
  ///
  /// In en, this message translates to:
  /// **'Thanks for staying on track!'**
  String get dashboard_thanksTrack;

  /// No description provided for @dashboard_notedAdjust.
  ///
  /// In en, this message translates to:
  /// **'Noted, we\'ll adjust your plan.'**
  String get dashboard_notedAdjust;

  /// No description provided for @dashboard_followingRecipe.
  ///
  /// In en, this message translates to:
  /// **'Following recipe'**
  String get dashboard_followingRecipe;

  /// No description provided for @dashboard_skippingMeal.
  ///
  /// In en, this message translates to:
  /// **'Skipping meal'**
  String get dashboard_skippingMeal;

  /// No description provided for @dashboard_loggingMeal.
  ///
  /// In en, this message translates to:
  /// **'Logging your meal...'**
  String get dashboard_loggingMeal;

  /// No description provided for @dashboard_markingSkipped.
  ///
  /// In en, this message translates to:
  /// **'Marking as skipped...'**
  String get dashboard_markingSkipped;

  /// No description provided for @dashboard_loggedExactly.
  ///
  /// In en, this message translates to:
  /// **'Logged exactly as planned'**
  String get dashboard_loggedExactly;

  /// No description provided for @dashboard_markedSkipped.
  ///
  /// In en, this message translates to:
  /// **'Marked as skipped for today'**
  String get dashboard_markedSkipped;

  /// No description provided for @time_underMinuteFuture.
  ///
  /// In en, this message translates to:
  /// **'in under a minute'**
  String get time_underMinuteFuture;

  /// No description provided for @time_underMinutePast.
  ///
  /// In en, this message translates to:
  /// **'less than a minute ago'**
  String get time_underMinutePast;

  /// No description provided for @time_minutesFuture.
  ///
  /// In en, this message translates to:
  /// **'in {minutes} min'**
  String time_minutesFuture(int minutes);

  /// No description provided for @time_minutesPast.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String time_minutesPast(int minutes);

  /// No description provided for @time_hoursFuture.
  ///
  /// In en, this message translates to:
  /// **'in {hours} h'**
  String time_hoursFuture(int hours);

  /// No description provided for @time_hoursPast.
  ///
  /// In en, this message translates to:
  /// **'{hours} h ago'**
  String time_hoursPast(int hours);

  /// No description provided for @time_hoursMinutesFuture.
  ///
  /// In en, this message translates to:
  /// **'in {hours}h {minutes}m'**
  String time_hoursMinutesFuture(int hours, int minutes);

  /// No description provided for @time_hoursMinutesPast.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m ago'**
  String time_hoursMinutesPast(int hours, int minutes);

  /// No description provided for @dashboard_allMealsLogged.
  ///
  /// In en, this message translates to:
  /// **'All meals logged!'**
  String get dashboard_allMealsLogged;

  /// No description provided for @dashboard_allMealsLoggedBody.
  ///
  /// In en, this message translates to:
  /// **'Great job staying on track today. You can review your entries or jump into the schedule for upcoming days.'**
  String get dashboard_allMealsLoggedBody;

  /// No description provided for @dashboard_mealsLogged.
  ///
  /// In en, this message translates to:
  /// **'Meals logged'**
  String get dashboard_mealsLogged;

  /// No description provided for @dashboard_mealsLoggedCount.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total} logged'**
  String dashboard_mealsLoggedCount(int current, int total);

  /// No description provided for @dashboard_nothingLogged.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged yet. Your updates will appear here.'**
  String get dashboard_nothingLogged;

  /// No description provided for @dashboard_containsSugar.
  ///
  /// In en, this message translates to:
  /// **'Contains sugar'**
  String get dashboard_containsSugar;

  /// No description provided for @dashboard_highGI.
  ///
  /// In en, this message translates to:
  /// **'High GI'**
  String get dashboard_highGI;

  /// No description provided for @status_followed.
  ///
  /// In en, this message translates to:
  /// **'Followed Plan'**
  String get status_followed;

  /// No description provided for @status_alternative.
  ///
  /// In en, this message translates to:
  /// **'Alternative Meal'**
  String get status_alternative;

  /// No description provided for @status_skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped Meal'**
  String get status_skipped;
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
