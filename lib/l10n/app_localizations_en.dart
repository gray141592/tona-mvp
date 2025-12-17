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

  @override
  String get menuProgress => 'Progress';

  @override
  String get dashboardMenu_closeMenu => 'Close menu';

  @override
  String get glycemicInfo_lowTitle => 'Low GI (0-55)';

  @override
  String get glycemicInfo_lowDesc =>
      'Steady energy, best for maintaining balanced blood sugar.';

  @override
  String get glycemicInfo_lowExample1 => 'Leafy greens, non-starchy vegetables';

  @override
  String get glycemicInfo_lowExample2 => 'Beans, lentils, chickpeas';

  @override
  String get glycemicInfo_lowExample3 => 'Whole grains like barley or quinoa';

  @override
  String get glycemicInfo_mediumTitle => 'Medium GI (56-69)';

  @override
  String get glycemicInfo_mediumDesc =>
      'Moderate impact, balance with protein or healthy fats.';

  @override
  String get glycemicInfo_mediumExample1 => 'Whole grain bread, oats';

  @override
  String get glycemicInfo_mediumExample2 => 'Sweet corn, sweet potatoes';

  @override
  String get glycemicInfo_mediumExample3 =>
      'Tropical fruits like pineapple or mango';

  @override
  String get glycemicInfo_highTitle => 'High GI (70+)';

  @override
  String get glycemicInfo_highDesc =>
      'Spikes blood sugar quickly; limit when possible.';

  @override
  String get glycemicInfo_highExample1 => 'White bread, bagels, pretzels';

  @override
  String get glycemicInfo_highExample2 => 'Sugary cereals, candy, pastries';

  @override
  String get glycemicInfo_highExample3 => 'White rice, fries, processed snacks';

  @override
  String get swipeCoach_followedPlan => 'Followed plan';

  @override
  String get swipeCoach_skippedMeal => 'Skipped meal';

  @override
  String get quickActions_groceriesTitle => 'Groceries';

  @override
  String get quickActions_groceriesSubtitle => 'Generate your list';

  @override
  String get quickActions_addUnplannedTitle => 'Add unplanned meal';

  @override
  String get quickActions_addUnplannedSubtitle => 'Log a meal not in plan';

  @override
  String get alternativeMeal_addUnplannedTitle => 'Add unplanned meal';

  @override
  String get alternativeMeal_logAlternativeTitle => 'Log alternative';

  @override
  String get alternativeMeal_whatDidYouEat => 'What did you eat?';

  @override
  String get alternativeMeal_whatDidYouEatInstead =>
      'What did you eat instead?';

  @override
  String get alternativeMeal_describeMeal => 'Describe the meal...';

  @override
  String get alternativeMeal_describeMealHad => 'Describe the meal you had...';

  @override
  String get alternativeMeal_validationError =>
      'Please provide a short description';

  @override
  String get alternativeMeal_notesOptional => 'Notes (optional)';

  @override
  String get alternativeMeal_bloodSugarImpact => 'Blood sugar impact';

  @override
  String get alternativeMeal_containsSugar => 'Contains added sugar';

  @override
  String get alternativeMeal_containsSugarSubtitle =>
      'Mark if the alternative meal includes refined sugar or sweet syrups.';

  @override
  String get alternativeMeal_highGI => 'High glycemic index';

  @override
  String get alternativeMeal_highGISubtitle =>
      'Select when the meal is likely to cause a sharp blood sugar spike.';

  @override
  String get alternativeMeal_saveMeal => 'Save meal';

  @override
  String get alternativeMeal_saveAlternative => 'Save alternative';

  @override
  String get alternativeMeal_saving => 'Saving...';

  @override
  String get consultationSchedule_title => 'Schedule consultation';

  @override
  String get consultationSchedule_nutritionistName => 'Nutritionist name';

  @override
  String get consultationSchedule_selectDate => 'Select date';

  @override
  String get consultationSchedule_selectTime => 'Select time';

  @override
  String get consultationSchedule_videoCall => 'Video call';

  @override
  String get consultationSchedule_inPerson => 'In-person';

  @override
  String get consultationSchedule_phone => 'Phone';

  @override
  String get consultationSchedule_format => 'Format';

  @override
  String get consultationSchedule_location => 'Location';

  @override
  String get consultationSchedule_meetingLink => 'Meeting link';

  @override
  String get consultationSchedule_prepNotes =>
      'Preparation notes (comma separated)';

  @override
  String get consultationSchedule_saveButton => 'Save appointment';

  @override
  String get consultationCard_mealPlanInEffect => 'Meal plan in effect';

  @override
  String get consultationCard_focusAreas => 'Focus areas';

  @override
  String get consultationCard_preparation => 'Preparation';

  @override
  String get consultationCard_happeningNow => 'Happening now';

  @override
  String consultationCard_inDays(int count) {
    return 'In $count days';
  }

  @override
  String get consultationCard_inDay => 'In 1 day';

  @override
  String consultationCard_inHours(int count) {
    return 'In $count hours';
  }

  @override
  String get consultationCard_inHour => 'In 1 hour';

  @override
  String consultationCard_inMinutes(int count) {
    return 'In $count minutes';
  }

  @override
  String get consultationCard_inMinute => 'In 1 minute';

  @override
  String consultationCard_daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get consultationCard_dayAgo => '1 day ago';

  @override
  String consultationCard_hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String get consultationCard_hourAgo => '1 hour ago';

  @override
  String consultationCard_minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String get consultationCard_minuteAgo => '1 minute ago';

  @override
  String get consultationOverview_upcoming => 'Upcoming';

  @override
  String get consultationOverview_nextAppointment => 'Next appointment';

  @override
  String get consultationOverview_addedToSchedule => 'Added to schedule';

  @override
  String get consultationOverview_addToSchedule => 'Add to schedule';

  @override
  String get consultationOverview_prepareReport => 'Prepare report';

  @override
  String get consultationOverview_mostRecent => 'Most recent visit';

  @override
  String get consultationOverview_lastAppointment => 'Last appointment';

  @override
  String get consultationOverview_linkMealPlan => 'Link current meal plan';

  @override
  String get consultationOverview_viewMealPlan => 'View meal plan';

  @override
  String get consultationHistory_title => 'History';

  @override
  String get consultationHistory_consultationPrefix => 'Consultation';

  @override
  String get consultationFollowup_title => 'How did it go?';

  @override
  String consultationFollowup_subtitle(String date) {
    return 'Your consultation on $date may have updated your meal plan.';
  }

  @override
  String get consultationFollowup_body =>
      'If you received a new meal plan or changes, you can upload them now so we can adjust your schedule immediately.';

  @override
  String get consultationFollowup_highlights => 'Highlights';

  @override
  String get consultationFollowup_uploadNewPlan => 'Upload new plan';

  @override
  String get consultationFollowup_reviewNotes => 'Review notes';

  @override
  String get consultationReminder_title => 'Consultation coming up';

  @override
  String consultationReminder_body(String name) {
    return 'Prepare your notes so $name has the latest insights. Generating a report now keeps everything ready to review together.';
  }

  @override
  String get consultationReminder_viewAgenda => 'View agenda';

  @override
  String get consultationReminder_happeningSoon => 'Happening soon';

  @override
  String get consultationReminder_tomorrow => 'Tomorrow';

  @override
  String get openReport => 'Open report';

  @override
  String get report_followed => 'Followed';

  @override
  String get report_alternatives => 'Alternatives';

  @override
  String get report_skipped => 'Skipped';

  @override
  String get report_totalLogs => 'Total logs';

  @override
  String get report_snapshotSummary => 'Snapshot summary';

  @override
  String get report_longestStreak => 'Longest streak';

  @override
  String report_asOfDate(String date) {
    return 'As of $date';
  }

  @override
  String get report_mealsWithSugar => 'Meals with sugar';

  @override
  String get report_highGIMeals => 'High G index meals';

  @override
  String get progress_logToUnlock =>
      'Log your meals to unlock progress insights';

  @override
  String get progress_logToStartStreak => 'Log your meals to start a streak';

  @override
  String get streak_fire => 'Incredible run! Keep the fire going! 🔥';

  @override
  String get streak_stacking => 'Amazing consistency — keep stacking days! 💪';

  @override
  String get streak_strongStart =>
      'Strong start — let\'s stretch it further! 🚀';

  @override
  String get streak_owningWeek => 'Meal-by-meal, you\'re owning this week! 🍽️';

  @override
  String get streak_momentum => 'One meal at a time — keep that momentum! 🙌';

  @override
  String get streak_freshDay => 'Fresh day, fresh opportunity to shine! 🌟';

  @override
  String get progress_dailyHistory => 'Daily history';

  @override
  String get progress_allLogs => 'All of your logs';

  @override
  String get progress_noMealsLogged => 'No meals logged yet';

  @override
  String get progress_logFirstMeal =>
      'Log your first meal to start building your progress timeline.';

  @override
  String get report_progressReportTitle => 'Progress report';

  @override
  String get report_shareTooltip => 'Share report';

  @override
  String report_shareError(String error) {
    return 'Error sharing report: $error';
  }

  @override
  String get reportText_title => 'Progress Report';

  @override
  String reportText_client(String name) {
    return 'Client: $name';
  }

  @override
  String reportText_email(String email) {
    return 'Email: $email';
  }

  @override
  String reportText_period(String start, String end) {
    return 'Period: $start - $end';
  }

  @override
  String get reportText_summary => 'Summary:';

  @override
  String reportText_totalMeals(int count) {
    return 'Total Meals: $count';
  }

  @override
  String reportText_mealsFollowed(int count) {
    return 'Meals Followed: $count';
  }

  @override
  String reportText_mealsAlternatives(int count) {
    return 'Alternative Meals: $count';
  }

  @override
  String reportText_mealsSkipped(int count) {
    return 'Meals Skipped: $count';
  }

  @override
  String reportText_mealsDue(int count) {
    return 'Meals due so far: $count';
  }

  @override
  String reportText_unloggedDue(int count) {
    return 'Unlogged meals due: $count';
  }

  @override
  String reportText_longestStreak(String streak) {
    return 'Longest streak: $streak';
  }

  @override
  String reportText_mealsWithSugar(int count) {
    return 'Meals with sugar: $count';
  }

  @override
  String reportText_mealsHighGI(int count) {
    return 'Meals with high glycemic index: $count';
  }

  @override
  String get reportText_dailyBreakdown => 'Daily Breakdown:';

  @override
  String reportText_notes(String notes) {
    return '    Notes: $notes';
  }

  @override
  String get reportGen_title => 'Generate report';

  @override
  String get reportGen_subtitle => 'Summaries ready to share';

  @override
  String get reportGen_choosePeriod => 'Choose a period';

  @override
  String get reportGen_periodDesc =>
      'We\'ll summarise all activity within the selected range.';

  @override
  String get reportGen_last7Days => 'Last 7 days';

  @override
  String get reportGen_last30Days => 'Last 30 days';

  @override
  String get reportGen_customRange => 'Custom range';

  @override
  String get reportGen_from => 'From';

  @override
  String get reportGen_to => 'To';

  @override
  String get reportGen_includeTitle => 'Your report will include';

  @override
  String get reportGen_include1 => 'Full meal log history for the period';

  @override
  String get reportGen_include2 => 'Adherence and consistency insights';

  @override
  String get reportGen_include3 => 'Client notes and alternative selections';

  @override
  String get reportGen_include4 => 'Weekly summaries ready to share';

  @override
  String get reportGen_button => 'Generate report';

  @override
  String get uploadPlan_title => 'Upload Your Meal Plan';

  @override
  String get uploadPlan_subtitle => 'Select your meal plan file to get started';

  @override
  String get uploadPlan_fileSelected => 'File Selected';

  @override
  String get uploadPlan_tapToSelect => 'Tap to select file';

  @override
  String get uploadPlan_fileFormats => 'PDF, DOC, or any file format';

  @override
  String get continueButton => 'Continue';

  @override
  String get mealDrawer_ingredients => 'Ingredients';

  @override
  String get mealDrawer_noIngredients =>
      'No ingredient list provided for this meal.';

  @override
  String get mealDrawer_preparation => 'Preparation';

  @override
  String get mealDrawer_noPrep =>
      'No preparation instructions provided for this meal.';

  @override
  String get appName => 'IRresistible';

  @override
  String get settings_debug => 'Debug';

  @override
  String get settings_skipOnboarding => 'Skip Onboarding';

  @override
  String get splashTitle => 'IRresistible';

  @override
  String get splashSubtitle => 'Your personalized nutrition journey';

  @override
  String get mock_meal_1_breakfast_name => 'Oatmeal with Berries';

  @override
  String get mock_meal_1_breakfast_desc =>
      '1 cup cooked oatmeal, 1/2 cup mixed berries, 1 tbsp almond butter, honey drizzle';

  @override
  String get mock_meal_1_snack1_name => 'Apple with Almond Butter';

  @override
  String get mock_meal_1_snack1_desc => '1 medium apple, 1 tbsp almond butter';

  @override
  String get mock_meal_1_lunch_name => 'Grilled Chicken Salad';

  @override
  String get mock_meal_1_lunch_desc =>
      '4oz grilled chicken breast, mixed greens, cherry tomatoes, cucumber, olive oil dressing';

  @override
  String get mock_meal_1_snack2_name => 'Greek Yogurt with Berries';

  @override
  String get mock_meal_1_snack2_desc =>
      '1 cup plain Greek yogurt, 1/4 cup mixed berries';

  @override
  String get mock_meal_1_dinner_name => 'Baked Salmon with Vegetables';

  @override
  String get mock_meal_1_dinner_desc =>
      '5oz salmon fillet, roasted broccoli and sweet potato';

  @override
  String get mock_meal_1_breakfast_ingredient_0 => '1 cup cooked oatmeal';

  @override
  String get mock_meal_1_breakfast_ingredient_1 => '1/2 cup mixed berries';

  @override
  String get mock_meal_1_breakfast_ingredient_2 => '1 tbsp almond butter';

  @override
  String get mock_meal_1_breakfast_ingredient_3 => '1 tsp honey';

  @override
  String get mock_meal_1_breakfast_instruction_0 =>
      'Cook the oatmeal with water or milk until creamy.';

  @override
  String get mock_meal_1_breakfast_instruction_1 =>
      'Top with mixed berries, almond butter, and a drizzle of honey.';

  @override
  String get mock_meal_1_snack1_ingredient_0 => '1 medium apple';

  @override
  String get mock_meal_1_snack1_ingredient_1 => '1 tbsp almond butter';

  @override
  String get mock_meal_1_snack1_instruction_0 =>
      'Slice the apple into wedges or rounds.';

  @override
  String get mock_meal_1_snack1_instruction_1 =>
      'Serve with almond butter for dipping or spreading.';

  @override
  String get mock_meal_1_lunch_ingredient_0 => '4 oz grilled chicken breast';

  @override
  String get mock_meal_1_lunch_ingredient_1 => '2 cups mixed greens';

  @override
  String get mock_meal_1_lunch_ingredient_2 => '1/2 cup cherry tomatoes';

  @override
  String get mock_meal_1_lunch_ingredient_3 => '1/2 cucumber';

  @override
  String get mock_meal_1_lunch_ingredient_4 => '2 tbsp olive oil dressing';

  @override
  String get mock_meal_1_lunch_instruction_0 =>
      'Slice the grilled chicken and vegetables.';

  @override
  String get mock_meal_1_lunch_instruction_1 =>
      'Combine everything in a bowl and drizzle with olive oil dressing.';

  @override
  String get mock_meal_1_snack2_ingredient_0 => '1 cup plain Greek yogurt';

  @override
  String get mock_meal_1_snack2_ingredient_1 => '1/4 cup mixed berries';

  @override
  String get mock_meal_1_snack2_instruction_0 =>
      'Spoon the yogurt into a bowl.';

  @override
  String get mock_meal_1_snack2_instruction_1 =>
      'Top with mixed berries just before serving.';

  @override
  String get mock_meal_1_dinner_ingredient_0 => '5 oz salmon fillet';

  @override
  String get mock_meal_1_dinner_ingredient_1 => '1 cup roasted broccoli';

  @override
  String get mock_meal_1_dinner_ingredient_2 => '1 medium sweet potato';

  @override
  String get mock_meal_1_dinner_ingredient_3 => '1 lemon wedge';

  @override
  String get mock_meal_1_dinner_instruction_0 =>
      'Bake the seasoned salmon and vegetables until tender.';

  @override
  String get mock_meal_1_dinner_instruction_1 =>
      'Serve with a squeeze of lemon over the top.';

  @override
  String get mock_meal_2_breakfast_name => 'Scrambled Eggs with Avocado Toast';

  @override
  String get mock_meal_2_breakfast_desc =>
      '2 eggs scrambled, 1 slice whole grain toast, 1/2 avocado, cherry tomatoes';

  @override
  String get mock_meal_2_snack1_name => 'Protein Smoothie';

  @override
  String get mock_meal_2_snack1_desc =>
      'Banana, protein powder, almond milk, spinach';

  @override
  String get mock_meal_2_lunch_name => 'Turkey Wrap with Hummus';

  @override
  String get mock_meal_2_lunch_desc =>
      'Whole wheat tortilla, 4oz turkey breast, hummus, lettuce, peppers';

  @override
  String get mock_meal_2_snack2_name => 'Carrot Sticks with Hummus';

  @override
  String get mock_meal_2_snack2_desc => '1 cup carrot sticks, 1/4 cup hummus';

  @override
  String get mock_meal_2_dinner_name => 'Chicken Stir-Fry';

  @override
  String get mock_meal_2_dinner_desc =>
      '5oz chicken breast, mixed vegetables, brown rice, teriyaki sauce';

  @override
  String get mock_meal_2_breakfast_ingredient_0 => '2 large eggs';

  @override
  String get mock_meal_2_breakfast_ingredient_1 => '1 slice whole grain bread';

  @override
  String get mock_meal_2_breakfast_ingredient_2 => '1/2 avocado';

  @override
  String get mock_meal_2_breakfast_ingredient_3 => '4 cherry tomatoes';

  @override
  String get mock_meal_2_breakfast_instruction_0 =>
      'Scramble the eggs in a non-stick pan until softly set.';

  @override
  String get mock_meal_2_breakfast_instruction_1 =>
      'Toast the bread, top with mashed avocado, and serve with tomatoes.';

  @override
  String get mock_meal_2_snack1_ingredient_0 => '1 banana';

  @override
  String get mock_meal_2_snack1_ingredient_1 => '1 scoop protein powder';

  @override
  String get mock_meal_2_snack1_ingredient_2 => '1 cup almond milk';

  @override
  String get mock_meal_2_snack1_ingredient_3 => '1 cup spinach';

  @override
  String get mock_meal_2_snack1_instruction_0 =>
      'Add all ingredients to a blender.';

  @override
  String get mock_meal_2_snack1_instruction_1 =>
      'Blend until smooth and creamy, then serve immediately.';

  @override
  String get mock_meal_2_lunch_ingredient_0 => '1 whole wheat tortilla';

  @override
  String get mock_meal_2_lunch_ingredient_1 => '4 oz sliced turkey breast';

  @override
  String get mock_meal_2_lunch_ingredient_2 => '2 tbsp hummus';

  @override
  String get mock_meal_2_lunch_ingredient_3 => '1 cup lettuce';

  @override
  String get mock_meal_2_lunch_ingredient_4 => '1/4 cup sliced bell peppers';

  @override
  String get mock_meal_2_lunch_instruction_0 =>
      'Spread hummus over the tortilla.';

  @override
  String get mock_meal_2_lunch_instruction_1 =>
      'Layer turkey, lettuce, and peppers, then roll tightly and slice.';

  @override
  String get mock_meal_2_snack2_ingredient_0 => '1 cup carrot sticks';

  @override
  String get mock_meal_2_snack2_ingredient_1 => '1/4 cup hummus';

  @override
  String get mock_meal_2_snack2_instruction_0 =>
      'Peel and slice the carrots into sticks if needed.';

  @override
  String get mock_meal_2_snack2_instruction_1 =>
      'Serve with hummus for dipping.';

  @override
  String get mock_meal_2_dinner_ingredient_0 => '5 oz chicken breast';

  @override
  String get mock_meal_2_dinner_ingredient_1 => '2 cups mixed vegetables';

  @override
  String get mock_meal_2_dinner_ingredient_2 => '1 cup brown rice';

  @override
  String get mock_meal_2_dinner_ingredient_3 => '2 tbsp teriyaki sauce';

  @override
  String get mock_meal_2_dinner_instruction_0 =>
      'Stir-fry the chicken until nearly cooked through.';

  @override
  String get mock_meal_2_dinner_instruction_1 =>
      'Add vegetables and sauce, cook until crisp-tender, and serve over rice.';

  @override
  String get mock_meal_3_breakfast_name => 'Greek Yogurt Parfait';

  @override
  String get mock_meal_3_breakfast_desc =>
      'Greek yogurt layered with granola, berries, and honey';

  @override
  String get mock_meal_3_snack1_name => 'Mixed Nuts';

  @override
  String get mock_meal_3_snack1_desc =>
      '1/4 cup mixed almonds, cashews, and walnuts';

  @override
  String get mock_meal_3_lunch_name => 'Quinoa Buddha Bowl';

  @override
  String get mock_meal_3_lunch_desc =>
      'Quinoa, roasted chickpeas, avocado, vegetables, tahini dressing';

  @override
  String get mock_meal_3_snack2_name => 'Cottage Cheese with Pineapple';

  @override
  String get mock_meal_3_snack2_desc =>
      '1 cup low-fat cottage cheese, 1/2 cup pineapple chunks';

  @override
  String get mock_meal_3_dinner_name => 'Lean Beef Tacos';

  @override
  String get mock_meal_3_dinner_desc =>
      'Lean ground beef, corn tortillas, lettuce, tomato, salsa';

  @override
  String get mock_meal_3_breakfast_ingredient_0 => '1 cup Greek yogurt';

  @override
  String get mock_meal_3_breakfast_ingredient_1 => '1/2 cup granola';

  @override
  String get mock_meal_3_breakfast_ingredient_2 => '1/2 cup mixed berries';

  @override
  String get mock_meal_3_breakfast_ingredient_3 => '1 tsp honey';

  @override
  String get mock_meal_3_breakfast_instruction_0 =>
      'Layer yogurt, granola, and berries in a glass or bowl.';

  @override
  String get mock_meal_3_breakfast_instruction_1 =>
      'Drizzle honey over the top before serving.';

  @override
  String get mock_meal_3_snack1_ingredient_0 => '1/4 cup mixed nuts';

  @override
  String get mock_meal_3_snack1_instruction_0 =>
      'Portion the mixed nuts into a small bowl or container.';

  @override
  String get mock_meal_3_snack1_instruction_1 =>
      'Enjoy immediately or pack to-go for later.';

  @override
  String get mock_meal_3_lunch_ingredient_0 => '1 cup cooked quinoa';

  @override
  String get mock_meal_3_lunch_ingredient_1 => '1/2 cup roasted chickpeas';

  @override
  String get mock_meal_3_lunch_ingredient_2 => '1/2 avocado';

  @override
  String get mock_meal_3_lunch_ingredient_3 => '1 cup mixed vegetables';

  @override
  String get mock_meal_3_lunch_ingredient_4 => '2 tbsp tahini dressing';

  @override
  String get mock_meal_3_lunch_instruction_0 =>
      'Warm the quinoa and arrange it in a bowl.';

  @override
  String get mock_meal_3_lunch_instruction_1 =>
      'Top with chickpeas, vegetables, avocado, and drizzle with tahini dressing.';

  @override
  String get mock_meal_3_snack2_ingredient_0 => '1 cup low-fat cottage cheese';

  @override
  String get mock_meal_3_snack2_ingredient_1 => '1/2 cup pineapple chunks';

  @override
  String get mock_meal_3_snack2_instruction_0 =>
      'Scoop cottage cheese into a serving bowl.';

  @override
  String get mock_meal_3_snack2_instruction_1 =>
      'Top with pineapple chunks and enjoy.';

  @override
  String get mock_meal_3_dinner_ingredient_0 => '5 oz lean ground beef';

  @override
  String get mock_meal_3_dinner_ingredient_1 => '2 corn tortillas';

  @override
  String get mock_meal_3_dinner_ingredient_2 => '1 cup shredded lettuce';

  @override
  String get mock_meal_3_dinner_ingredient_3 => '1 diced tomato';

  @override
  String get mock_meal_3_dinner_ingredient_4 => '2 tbsp salsa';

  @override
  String get mock_meal_3_dinner_instruction_0 =>
      'Cook the ground beef with seasonings until browned.';

  @override
  String get mock_meal_3_dinner_instruction_1 =>
      'Warm the tortillas, then assemble with lettuce, tomato, and salsa.';

  @override
  String get mock_meal_4_breakfast_name => 'Whole Grain Pancakes';

  @override
  String get mock_meal_4_breakfast_desc =>
      '2 whole grain pancakes, fresh berries, maple syrup';

  @override
  String get mock_meal_4_snack1_name => 'Pear with String Cheese';

  @override
  String get mock_meal_4_snack1_desc => '1 medium pear, 1 string cheese';

  @override
  String get mock_meal_4_lunch_name => 'Tuna Salad';

  @override
  String get mock_meal_4_lunch_desc =>
      'Tuna, mixed greens, hard-boiled egg, olives, olive oil';

  @override
  String get mock_meal_4_snack2_name => 'Protein Bar';

  @override
  String get mock_meal_4_snack2_desc => '1 protein bar (aim for 10g+ protein)';

  @override
  String get mock_meal_4_dinner_name => 'Baked Chicken with Quinoa';

  @override
  String get mock_meal_4_dinner_desc =>
      'Herb-crusted chicken breast, quinoa, roasted asparagus';

  @override
  String get mock_meal_4_breakfast_ingredient_0 => '2 whole grain pancakes';

  @override
  String get mock_meal_4_breakfast_ingredient_1 => '1/2 cup fresh berries';

  @override
  String get mock_meal_4_breakfast_ingredient_2 => '1 tbsp maple syrup';

  @override
  String get mock_meal_4_breakfast_instruction_0 =>
      'Warm the pancakes in a skillet or toaster if needed.';

  @override
  String get mock_meal_4_breakfast_instruction_1 =>
      'Serve with berries on top and drizzle with maple syrup.';

  @override
  String get mock_meal_4_snack1_ingredient_0 => '1 medium pear';

  @override
  String get mock_meal_4_snack1_ingredient_1 => '1 string cheese';

  @override
  String get mock_meal_4_snack1_instruction_0 =>
      'Wash the pear and slice if desired.';

  @override
  String get mock_meal_4_snack1_instruction_1 =>
      'Pair with string cheese for a quick snack.';

  @override
  String get mock_meal_4_lunch_ingredient_0 => '1 can tuna in water';

  @override
  String get mock_meal_4_lunch_ingredient_1 => '2 cups mixed greens';

  @override
  String get mock_meal_4_lunch_ingredient_2 => '1 hard-boiled egg';

  @override
  String get mock_meal_4_lunch_ingredient_3 => '5 olives';

  @override
  String get mock_meal_4_lunch_ingredient_4 => '2 tbsp olive oil';

  @override
  String get mock_meal_4_lunch_instruction_0 =>
      'Drain the tuna and slice the egg and olives.';

  @override
  String get mock_meal_4_lunch_instruction_1 =>
      'Combine ingredients with greens and drizzle with olive oil.';

  @override
  String get mock_meal_4_snack2_ingredient_0 => '1 protein bar';

  @override
  String get mock_meal_4_snack2_instruction_0 =>
      'Unwrap the protein bar and enjoy as a quick snack.';

  @override
  String get mock_meal_4_dinner_ingredient_0 => '5 oz chicken breast';

  @override
  String get mock_meal_4_dinner_ingredient_1 => '1 cup cooked quinoa';

  @override
  String get mock_meal_4_dinner_ingredient_2 => '1 cup roasted asparagus';

  @override
  String get mock_meal_4_dinner_ingredient_3 => 'to taste herbs and spices';

  @override
  String get mock_meal_4_dinner_instruction_0 =>
      'Bake the seasoned chicken until cooked through.';

  @override
  String get mock_meal_4_dinner_instruction_1 =>
      'Serve alongside quinoa and roasted asparagus.';

  @override
  String get mock_meal_5_breakfast_name => 'Veggie Omelet';

  @override
  String get mock_meal_5_breakfast_desc =>
      '3-egg omelet with spinach, mushrooms, and feta cheese';

  @override
  String get mock_meal_5_snack1_name => 'Banana with Peanut Butter';

  @override
  String get mock_meal_5_snack1_desc => '1 medium banana, 1 tbsp peanut butter';

  @override
  String get mock_meal_5_lunch_name => 'Mediterranean Chicken Bowl';

  @override
  String get mock_meal_5_lunch_desc =>
      'Grilled chicken, brown rice, hummus, cucumber, tomatoes, olives';

  @override
  String get mock_meal_5_snack2_name => 'Rice Cakes with Avocado';

  @override
  String get mock_meal_5_snack2_desc =>
      '2 rice cakes topped with mashed avocado';

  @override
  String get mock_meal_5_dinner_name => 'Shrimp Pasta Primavera';

  @override
  String get mock_meal_5_dinner_desc =>
      'Whole wheat pasta, shrimp, mixed vegetables, garlic olive oil';

  @override
  String get mock_meal_5_breakfast_ingredient_0 => '3 large eggs';

  @override
  String get mock_meal_5_breakfast_ingredient_1 => '1 cup spinach';

  @override
  String get mock_meal_5_breakfast_ingredient_2 => '1/2 cup mushrooms';

  @override
  String get mock_meal_5_breakfast_ingredient_3 => '2 tbsp feta cheese';

  @override
  String get mock_meal_5_breakfast_instruction_0 =>
      'Sauté mushrooms and spinach until tender.';

  @override
  String get mock_meal_5_breakfast_instruction_1 =>
      'Add beaten eggs, cook until set, and sprinkle with feta before folding.';

  @override
  String get mock_meal_5_snack1_ingredient_0 => '1 medium banana';

  @override
  String get mock_meal_5_snack1_ingredient_1 => '1 tbsp peanut butter';

  @override
  String get mock_meal_5_snack1_instruction_0 =>
      'Peel the banana and slice if desired.';

  @override
  String get mock_meal_5_snack1_instruction_1 =>
      'Serve with peanut butter for dipping or spreading.';

  @override
  String get mock_meal_5_lunch_ingredient_0 => '4 oz grilled chicken';

  @override
  String get mock_meal_5_lunch_ingredient_1 => '1 cup brown rice';

  @override
  String get mock_meal_5_lunch_ingredient_2 => '2 tbsp hummus';

  @override
  String get mock_meal_5_lunch_ingredient_3 => '1/2 cucumber';

  @override
  String get mock_meal_5_lunch_ingredient_4 => '1/2 cup tomatoes';

  @override
  String get mock_meal_5_lunch_ingredient_5 => '5 olives';

  @override
  String get mock_meal_5_lunch_instruction_0 =>
      'Layer rice in a bowl and top with sliced chicken.';

  @override
  String get mock_meal_5_lunch_instruction_1 =>
      'Add hummus, cucumber, tomatoes, and olives before serving.';

  @override
  String get mock_meal_5_snack2_ingredient_0 => '2 rice cakes';

  @override
  String get mock_meal_5_snack2_ingredient_1 => '1/2 avocado';

  @override
  String get mock_meal_5_snack2_instruction_0 =>
      'Mash the avocado with a fork and season if desired.';

  @override
  String get mock_meal_5_snack2_instruction_1 =>
      'Spread over rice cakes and serve immediately.';

  @override
  String get mock_meal_5_dinner_ingredient_0 => '2 oz whole wheat pasta';

  @override
  String get mock_meal_5_dinner_ingredient_1 => '5 oz shrimp';

  @override
  String get mock_meal_5_dinner_ingredient_2 => '2 cups mixed vegetables';

  @override
  String get mock_meal_5_dinner_ingredient_3 => '2 tbsp garlic olive oil';

  @override
  String get mock_meal_5_dinner_instruction_0 =>
      'Cook the pasta until al dente and reserve a little cooking water.';

  @override
  String get mock_meal_5_dinner_instruction_1 =>
      'Sauté shrimp and vegetables in garlic oil, then toss with pasta.';

  @override
  String get mock_meal_6_breakfast_name => 'Breakfast Burrito';

  @override
  String get mock_meal_6_breakfast_desc =>
      'Scrambled eggs, black beans, cheese, salsa in whole wheat tortilla';

  @override
  String get mock_meal_6_snack1_name => 'Trail Mix';

  @override
  String get mock_meal_6_snack1_desc =>
      'Mixed nuts, dried cranberries, dark chocolate chips';

  @override
  String get mock_meal_6_lunch_name => 'Grilled Veggie Sandwich';

  @override
  String get mock_meal_6_lunch_desc =>
      'Grilled zucchini, peppers, mozzarella on whole grain bread';

  @override
  String get mock_meal_6_snack2_name => 'Edamame';

  @override
  String get mock_meal_6_snack2_desc => '1 cup steamed edamame with sea salt';

  @override
  String get mock_meal_6_dinner_name => 'Grilled Steak with Vegetables';

  @override
  String get mock_meal_6_dinner_desc =>
      'Lean sirloin steak, roasted Brussels sprouts and carrots';

  @override
  String get mock_meal_6_breakfast_ingredient_0 => '2 scrambled eggs';

  @override
  String get mock_meal_6_breakfast_ingredient_1 => '1/4 cup black beans';

  @override
  String get mock_meal_6_breakfast_ingredient_2 => '2 tbsp shredded cheese';

  @override
  String get mock_meal_6_breakfast_ingredient_3 => '2 tbsp salsa';

  @override
  String get mock_meal_6_breakfast_ingredient_4 => '1 whole wheat tortilla';

  @override
  String get mock_meal_6_breakfast_instruction_0 =>
      'Warm the tortilla and scramble the eggs with beans.';

  @override
  String get mock_meal_6_breakfast_instruction_1 =>
      'Fill the tortilla, top with cheese and salsa, then roll tightly.';

  @override
  String get mock_meal_6_snack1_ingredient_0 => '1/4 cup mixed nuts';

  @override
  String get mock_meal_6_snack1_ingredient_1 => '2 tbsp dried cranberries';

  @override
  String get mock_meal_6_snack1_ingredient_2 => '1 tbsp dark chocolate chips';

  @override
  String get mock_meal_6_snack1_instruction_0 =>
      'Combine nuts, cranberries, and chocolate chips in a small bowl.';

  @override
  String get mock_meal_6_snack1_instruction_1 =>
      'Portion into a to-go container if needed.';

  @override
  String get mock_meal_6_lunch_ingredient_0 => '2 slices whole grain bread';

  @override
  String get mock_meal_6_lunch_ingredient_1 => '1/2 grilled zucchini';

  @override
  String get mock_meal_6_lunch_ingredient_2 => '1/4 cup grilled peppers';

  @override
  String get mock_meal_6_lunch_ingredient_3 => '2 slices fresh mozzarella';

  @override
  String get mock_meal_6_lunch_ingredient_4 => '1 tbsp balsamic glaze';

  @override
  String get mock_meal_6_lunch_instruction_0 =>
      'Layer grilled vegetables and mozzarella on the bread.';

  @override
  String get mock_meal_6_lunch_instruction_1 =>
      'Drizzle with balsamic glaze and toast until cheese melts if desired.';

  @override
  String get mock_meal_6_snack2_ingredient_0 => '1 cup edamame';

  @override
  String get mock_meal_6_snack2_ingredient_1 => 'to taste sea salt';

  @override
  String get mock_meal_6_snack2_instruction_0 =>
      'Steam or microwave the edamame until heated through.';

  @override
  String get mock_meal_6_snack2_instruction_1 =>
      'Sprinkle with sea salt before serving.';

  @override
  String get mock_meal_6_dinner_ingredient_0 => '5 oz lean sirloin steak';

  @override
  String get mock_meal_6_dinner_ingredient_1 =>
      '1 cup roasted Brussels sprouts';

  @override
  String get mock_meal_6_dinner_ingredient_2 => '1 cup roasted carrots';

  @override
  String get mock_meal_6_dinner_instruction_0 =>
      'Grill or sear the steak to your preferred doneness.';

  @override
  String get mock_meal_6_dinner_instruction_1 =>
      'Serve with roasted Brussels sprouts and carrots on the side.';

  @override
  String get mock_meal_7_breakfast_name => 'French Toast with Fruit';

  @override
  String get mock_meal_7_breakfast_desc =>
      'Whole grain French toast, fresh berries, yogurt drizzle';

  @override
  String get mock_meal_7_snack1_name => 'Celery with Peanut Butter';

  @override
  String get mock_meal_7_snack1_desc =>
      '4 celery sticks with 2 tbsp peanut butter';

  @override
  String get mock_meal_7_lunch_name => 'Chicken Caesar Salad';

  @override
  String get mock_meal_7_lunch_desc =>
      'Grilled chicken, romaine lettuce, parmesan, light Caesar dressing';

  @override
  String get mock_meal_7_snack2_name => 'Smoothie Bowl';

  @override
  String get mock_meal_7_snack2_desc =>
      'Blended berries, banana, topped with granola and chia seeds';

  @override
  String get mock_meal_7_dinner_name => 'Baked Cod with Sweet Potato';

  @override
  String get mock_meal_7_dinner_desc =>
      'Herb-baked cod, mashed sweet potato, steamed green beans';

  @override
  String get mock_meal_7_breakfast_ingredient_0 => '2 slices whole grain bread';

  @override
  String get mock_meal_7_breakfast_ingredient_1 => '1 egg';

  @override
  String get mock_meal_7_breakfast_ingredient_2 => '1/2 cup mixed berries';

  @override
  String get mock_meal_7_breakfast_ingredient_3 => '2 tbsp Greek yogurt';

  @override
  String get mock_meal_7_breakfast_ingredient_4 => '1 tsp cinnamon';

  @override
  String get mock_meal_7_breakfast_instruction_0 =>
      'Whisk the egg with cinnamon and soak the bread slices.';

  @override
  String get mock_meal_7_breakfast_instruction_1 =>
      'Cook on a griddle until golden, then top with berries and yogurt.';

  @override
  String get mock_meal_7_snack1_ingredient_0 => '4 celery sticks';

  @override
  String get mock_meal_7_snack1_ingredient_1 => '2 tbsp peanut butter';

  @override
  String get mock_meal_7_snack1_instruction_0 =>
      'Wash and trim the celery sticks.';

  @override
  String get mock_meal_7_snack1_instruction_1 =>
      'Fill the celery grooves with peanut butter.';

  @override
  String get mock_meal_7_lunch_ingredient_0 => '4 oz grilled chicken breast';

  @override
  String get mock_meal_7_lunch_ingredient_1 => '2 cups romaine lettuce';

  @override
  String get mock_meal_7_lunch_ingredient_2 => '2 tbsp parmesan cheese';

  @override
  String get mock_meal_7_lunch_ingredient_3 => '2 tbsp light Caesar dressing';

  @override
  String get mock_meal_7_lunch_ingredient_4 => '1/2 cup whole grain croutons';

  @override
  String get mock_meal_7_lunch_instruction_0 =>
      'Chop the lettuce and slice the grilled chicken.';

  @override
  String get mock_meal_7_lunch_instruction_1 =>
      'Toss with dressing, parmesan, and croutons before serving.';

  @override
  String get mock_meal_7_snack2_ingredient_0 => '1 cup mixed berries';

  @override
  String get mock_meal_7_snack2_ingredient_1 => '1/2 banana';

  @override
  String get mock_meal_7_snack2_ingredient_2 => '1/4 cup granola';

  @override
  String get mock_meal_7_snack2_ingredient_3 => '1 tbsp chia seeds';

  @override
  String get mock_meal_7_snack2_instruction_0 =>
      'Blend the berries and banana until smooth.';

  @override
  String get mock_meal_7_snack2_instruction_1 =>
      'Pour into a bowl and top with granola and chia seeds.';

  @override
  String get mock_meal_7_dinner_ingredient_0 => '5 oz cod fillet';

  @override
  String get mock_meal_7_dinner_ingredient_1 => '1 medium sweet potato';

  @override
  String get mock_meal_7_dinner_ingredient_2 => '1 cup green beans';

  @override
  String get mock_meal_7_dinner_ingredient_3 => 'to taste herbs and lemon';

  @override
  String get mock_meal_7_dinner_instruction_0 =>
      'Season the cod with herbs and lemon, then bake until flaky.';

  @override
  String get mock_meal_7_dinner_instruction_1 =>
      'Serve with mashed sweet potato and steamed green beans.';

  @override
  String get dashboard_today => 'Today';

  @override
  String get dashboard_greeting_unlogged_3 =>
      'Let’s log a few meals while the details are fresh.';

  @override
  String get dashboard_greeting_unlogged_2 =>
      'Two meals are waiting for a log — quick updates help a ton.';

  @override
  String get dashboard_greeting_unlogged_1 =>
      'One meal needs a quick log to stay on track.';

  @override
  String get dashboard_greeting_all_set =>
      'You’re all set until the next meal.';

  @override
  String get dashboard_greeting_good_job =>
      'Nice work staying current — keep the momentum going.';

  @override
  String dashboard_status_overdue(int count, String label) {
    return '$count $label overdue';
  }

  @override
  String dashboard_status_logged(int count, String label) {
    return '$count $label logged';
  }

  @override
  String get mealLabel => 'meal';

  @override
  String get mealsLabel => 'meals';

  @override
  String get mock_mealPlanName => 'Week 1 Meal Plan';

  @override
  String get mock_endurancePlanName => 'Endurance Support Plan';

  @override
  String get mock_consultation_1_focusArea_0 => 'Stabilise fasting glucose';

  @override
  String get mock_consultation_1_focusArea_1 =>
      'Reintroduce strength training fuel';

  @override
  String get mock_consultation_1_preparationNote_0 =>
      'Upload latest glucometer exports';

  @override
  String get mock_consultation_1_preparationNote_1 =>
      'Track hydration for 3 days prior';

  @override
  String get mock_consultation_2_focusArea_0 => 'Dial in pre-run fuelling';

  @override
  String get mock_consultation_2_focusArea_1 => 'Adjust fibre targets';

  @override
  String get mock_consultation_2_preparationNote_0 =>
      'Bring food journal for previous 14 days';

  @override
  String get mock_consultation_2_preparationNote_1 =>
      'Note any hypoglycaemia symptoms';

  @override
  String get dashboard_catchUp => 'Catch up';

  @override
  String get dashboard_logNow => 'Log now';

  @override
  String get dashboard_needsAttention => 'Needs attention';

  @override
  String get dashboard_pendingMealsSwipeHint =>
      'Swipe overdue and due meals to keep your log current.';

  @override
  String get dashboard_pendingMealsSeveritySeveral =>
      'Several meals are waiting — capturing them now keeps your data accurate.';

  @override
  String get dashboard_pendingMealsSeverityTwo =>
      'Two meals need attention — a couple quick logs will close the gap.';

  @override
  String get dashboard_pendingMealsSeverityOne =>
      'One meal is ready to log — take a moment to record it.';

  @override
  String get dashboard_comingUp => 'Coming up';

  @override
  String get dashboard_nextMeal => 'Next meal';

  @override
  String get dashboard_logged => 'Logged';

  @override
  String dashboard_scheduled(String time, String relativeTime) {
    return 'Scheduled $time • $relativeTime';
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
  String get dashboard_logSomethingElse => 'Log something else';

  @override
  String get dashboard_greatJob => 'Great job!';

  @override
  String get dashboard_noted => 'Noted';

  @override
  String get dashboard_logSuccess => 'Log was successfully saved';

  @override
  String get dashboard_followedRecipe => 'Followed recipe';

  @override
  String get dashboard_followedMeal => 'Followed meal';

  @override
  String get dashboard_skippedMeal => 'Skipped meal';

  @override
  String get dashboard_thanksTrack => 'Thanks for staying on track!';

  @override
  String get dashboard_notedAdjust => 'Noted, we\'ll adjust your plan.';

  @override
  String get dashboard_followingRecipe => 'Following recipe';

  @override
  String get dashboard_skippingMeal => 'Skipping meal';

  @override
  String get dashboard_loggingMeal => 'Logging your meal...';

  @override
  String get dashboard_markingSkipped => 'Marking as skipped...';

  @override
  String get dashboard_loggedExactly => 'Logged exactly as planned';

  @override
  String get dashboard_markedSkipped => 'Marked as skipped for today';

  @override
  String get time_underMinuteFuture => 'in under a minute';

  @override
  String get time_underMinutePast => 'less than a minute ago';

  @override
  String time_minutesFuture(int minutes) {
    return 'in $minutes min';
  }

  @override
  String time_minutesPast(int minutes) {
    return '$minutes min ago';
  }

  @override
  String time_hoursFuture(int hours) {
    return 'in $hours h';
  }

  @override
  String time_hoursPast(int hours) {
    return '$hours h ago';
  }

  @override
  String time_hoursMinutesFuture(int hours, int minutes) {
    return 'in ${hours}h ${minutes}m';
  }

  @override
  String time_hoursMinutesPast(int hours, int minutes) {
    return '${hours}h ${minutes}m ago';
  }

  @override
  String get dashboard_allMealsLogged => 'All meals logged!';

  @override
  String get dashboard_allMealsLoggedBody =>
      'Great job staying on track today. You can review your entries or jump into the schedule for upcoming days.';

  @override
  String get dashboard_mealsLogged => 'Meals logged';

  @override
  String dashboard_mealsLoggedCount(int current, int total) {
    return '$current of $total logged';
  }

  @override
  String get dashboard_nothingLogged =>
      'Nothing logged yet. Your updates will appear here.';

  @override
  String get dashboard_containsSugar => 'Contains sugar';

  @override
  String get dashboard_highGI => 'High GI';

  @override
  String get status_followed => 'Followed Plan';

  @override
  String get status_alternative => 'Alternative Meal';

  @override
  String get status_skipped => 'Skipped Meal';
}
