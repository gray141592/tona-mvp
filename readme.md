# Gamified Digital Health App - Flutter MVP Development Guide

## Project Overview

A gamified digital health app focused on helping people reverse insulin resistance and prediabetes. The MVP (Minimum Viable Product) is a **nutritionist demo version** that showcases meal tracking, adherence monitoring, and progress report generation for client-nutritionist partnerships.

### MVP Goals
1. **Demonstrate Value to Nutritionists**: Show how the app helps their clients stay on track and generate reports
2. **Showcase Client Experience**: Demonstrate easy meal tracking and logging
3. **Enable Progress Sharing**: Clients can generate and share progress reports with their nutritionists
4. **Validate Core Workflow**: Test the essential nutrition tracking flow before full development

### Target Users
- **Primary**: Clients who need simple meal tracking and want to share progress with nutritionists
- **Secondary**: Nutritionists (viewing demo) who will see how clients can track and share progress

---

## MVP Feature Set

### ✅ Included Features

1. **Meal Plan Display**
   - View weekly meal plan (mock data for MVP)
   - See meals organized by day
   - Display breakfast, lunch, dinner, snacks
   - Show meal details (ingredients, portions)

2. **Meal Logging**
   - One-tap "Followed Plan" button
   - Log alternative meal if didn't follow plan
   - Add notes to meals
   - Log meal timing (automatic timestamp)

3. **Daily View**
   - Today's meals at a glance
   - Quick log buttons for each meal
   - Progress indicator (meals logged today)
   - Visual feedback on adherence

4. **Weekly Progress**
   - View adherence percentage for the week
   - See which meals were followed/skipped
   - Simple chart or visual indicator
   - Day-by-day breakdown

5. **Basic Profile**
   - Name, email
   - Assigned nutritionist (read-only for MVP)
   - Start date of current plan

6. **Progress Report Generation**
   - Generate PDF (like) report for selected date range (page showing report not actual pdf file)
   - Include meal logs, adherence stats, notes
   - Download or share report (email, messaging, etc.)
   - Professional format suitable for nutritionist consultations
---

## Data Models

### Client
```dart
class Client {
  final String id;
  final String name;
  final String email;
  final String? nutritionistId;
  final String mealPlanId;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
}
```

### Meal Plan (Mock for MVP)
```dart
class MealPlan {
  final String id;
  final String clientId;
  final String name; // e.g., "Week 1 Plan"
  final DateTime startDate;
  final DateTime endDate;
  final List<Meal> meals;
}
```

### Meal
```dart
class Meal {
  final String id;
  final String mealPlanId;
  final int dayOfWeek; // 1-7 (Monday-Sunday)
  final MealType mealType; // breakfast, lunch, dinner, snack1, snack2
  final String name;
  final String description;
  final List<String> ingredients;
  final String timeScheduled; // "08:00"
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack1,
  snack2,
}
```

### Meal Log
```dart
class MealLog {
  final String id;
  final String clientId;
  final String mealId;
  final DateTime loggedDate;
  final DateTime loggedTime;
  final MealLogStatus status; // followed, alternative
  final String? alternativeMeal; // if status = alternative
  final String? notes;
  final DateTime createdAt;
}

enum MealLogStatus {
  followed,
  alternative,
}
```

### Weekly Progress
```dart
class WeeklyProgress {
  final DateTime weekStartDate;
  final DateTime weekEndDate;
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final double adherencePercentage; // 0-100
  final Map<int, DailyProgress> dailyProgress; // dayOfWeek -> DailyProgress
}

class DailyProgress {
  final int dayOfWeek;
  final DateTime date;
  final int totalMeals;
  final int mealsFollowed;
  final int mealsWithAlternatives;
  final double adherencePercentage;
  final List<MealLog> mealLogs;
}
```

---

## Mock Data Structure

### Sample Meal Plan (JSON)
```json
{
  "id": "plan_001",
  "name": "Week 1 Meal Plan",
  "start_date": "2024-01-08",
  "end_date": "2024-01-14",
  "meals": [
    {
      "day": 1,
      "meal_type": "breakfast",
      "name": "Oatmeal with Berries",
      "description": "1 cup cooked oatmeal, 1/2 cup mixed berries, 1 tbsp almond butter",
      "scheduled_time": "08:00",
      "ingredients": [
        "1 cup cooked oatmeal",
        "1/2 cup mixed berries",
        "1 tbsp almond butter"
      ]
    },
    {
      "day": 1,
      "meal_type": "lunch",
      "name": "Grilled Chicken Salad",
      "description": "4oz grilled chicken, mixed greens, vegetables, olive oil dressing",
      "scheduled_time": "13:00",
      "ingredients": [
        "4oz grilled chicken",
        "mixed greens",
        "vegetables",
        "olive oil dressing"
      ]
    },
    {
      "day": 1,
      "meal_type": "dinner",
      "name": "Baked Salmon with Vegetables",
      "description": "5oz salmon, roasted broccoli and sweet potato",
      "scheduled_time": "19:00",
      "ingredients": [
        "5oz salmon",
        "roasted broccoli",
        "sweet potato"
      ]
    },
    {
      "day": 1,
      "meal_type": "snack1",
      "name": "Apple with Almond Butter",
      "description": "1 medium apple, 1 tbsp almond butter",
      "scheduled_time": "10:00",
      "ingredients": [
        "1 medium apple",
        "1 tbsp almond butter"
      ]
    },
    {
      "day": 1,
      "meal_type": "snack2",
      "name": "Greek Yogurt",
      "description": "1 cup plain Greek yogurt, 1/4 cup berries",
      "scheduled_time": "16:00",
      "ingredients": [
        "1 cup plain Greek yogurt",
        "1/4 cup berries"
      ]
    }
    // ... repeat for all 7 days (35 meals total per week)
  ]
}
```

### Sample Client Data
```json
{
  "id": "client_001",
  "name": "Sarah Johnson",
  "email": "sarah@example.com",
  "nutritionist_id": "nutr_001",
  "meal_plan_id": "plan_001",
  "created_at": "2024-01-08T00:00:00Z",
  "last_active_at": "2024-01-15T14:30:00Z"
}
```

### Sample Meal Logs
```json
{
  "client_id": "client_001",
  "logs": [
    {
      "id": "log_001",
      "meal_id": "meal_001",
      "logged_date": "2024-01-15",
      "logged_time": "08:15",
      "status": "followed",
      "alternative_meal": null,
      "notes": null
    },
    {
      "id": "log_002",
      "meal_id": "meal_002",
      "logged_date": "2024-01-15",
      "logged_time": "13:45",
      "status": "alternative",
      "alternative_meal": "Caesar salad with grilled chicken",
      "notes": "Had business lunch, restaurant didn't have mixed greens"
    }
  ]
}
```

---

## User Stories & Flows

### US-C1: View Today's Meal Plan
**As a** client using the app  
**I want to** see my meals for today  
**So that** I know what to eat and when

**Acceptance Criteria:**
- Client can see all meals scheduled for today
- Meals are displayed in chronological order
- Each meal shows name, description, and scheduled time
- Clear visual distinction between meal types (breakfast, lunch, dinner, snacks)
- Shows log status for each meal (logged/not logged)

### US-C2: Log Meal - Followed Plan
**As a** client  
**I want to** quickly log that I followed my meal plan  
**So that** I can track my adherence with minimal effort

**Acceptance Criteria:**
- One-tap button to log "Followed Plan"
- Timestamp automatically recorded
- Visual confirmation shown
- Progress indicator updates immediately

**Flow:**
1. Client views meal
2. Sees "Followed Plan" button
3. Taps button
4. Confirmation shown
5. Timestamp recorded
6. Meal log status updated
7. Daily progress updated
8. Weekly stats updated
9. Success message shown
10. UI refreshed

### US-C3: Log Meal - Alternative
**As a** client  
**I want to** log what I actually ate if I didn't follow the plan  
**So that** my nutritionist can see what I ate instead

**Acceptance Criteria:**
- Button to log alternative meal
- Text input to describe what was eaten
- Optional notes field
- Save and record timestamp

**Flow:**
1. Client views meal
2. Taps "Log Alternative"
3. Input form shown
4. Client enters what was eaten
5. Client adds notes (optional)
6. Taps "Save"
7. Input validated
8. Alternative meal saved
9. Timestamp recorded
10. Status marked as "alternative"
11. Progress updated
12. Success shown
13. Return to daily view

### US-C4: View Weekly Progress
**As a** client  
**I want to** see my adherence for the week  
**So that** I can see how well I'm following my plan

**Acceptance Criteria:**
- Weekly calendar view showing all 7 days
- Visual indicator for each day's adherence
- Overall weekly adherence percentage
- Can click day to see details

**Flow:**
1. Client opens weekly view
2. Week's data loaded
3. Daily adherence calculated
4. Weekly calendar displayed
5. Each day's status shown
6. Weekly percentage displayed
7. Meal count stats shown
8. User can click day to see details
9. Day details show all meals for that day
10. Show logged status and notes

### US-C5: Generate Progress Report
**As a** client  
**I want to** generate a progress report for my nutritionist  
**So that** I can share my meal tracking data before consultations

**Acceptance Criteria:**
- Select date range (last week, last month, custom)
- Preview report before generating
- Generate PDF with all meal logs
- Include adherence statistics
- Include all notes
- Downloadable PDF file
- Share options (email, messaging, etc.)

**Flow:**
1. Client opens report section
2. Date range options shown
3. Client selects range (last week/last month/custom)
4. If custom, date pickers shown
5. Meal logs collected for range
6. Adherence statistics calculated
7. All notes collected
8. Report preview generated
9. Preview displayed
10. Client can review, download, or share
11. If download/share, PDF generated
12. PDF saved to device or shared

---

## UI/UX Specifications

### Daily View Screen
```
┌─────────────────────────────────┐
│  ← Back    Today - Monday, Jan 15│
│  Progress: 2/5 meals logged     │
├─────────────────────────────────┤
│                                 │
│  🌅 Breakfast                   │
│  Oatmeal with berries           │
│  1 cup cooked oatmeal, 1/2 cup  │
│  mixed berries, 1 tbsp almond   │
│  Scheduled: 8:00 AM             │
│  [✓ Followed] [Log Alternative] │
│                                 │
│  🍽️ Lunch                       │
│  Grilled chicken salad          │
│  4oz grilled chicken, mixed     │
│  greens, vegetables             │
│  Scheduled: 1:00 PM             │
│  [✓ Followed] [Log Alternative] │
│                                 │
│  🍽️ Dinner                      │
│  Baked salmon & vegetables      │
│  5oz salmon, roasted broccoli   │
│  and sweet potato               │
│  Scheduled: 7:00 PM             │
│  [Log Meal]                     │
│                                 │
│  🍎 Snack 1                     │
│  Apple with almond butter       │
│  1 medium apple, 1 tbsp almond  │
│  Scheduled: 10:00 AM            │
│  [✓ Followed]                   │
│                                 │
│  🍎 Snack 2                     │
│  Greek yogurt                   │
│  1 cup plain Greek yogurt, 1/4  │
│  cup berries                    │
│  Scheduled: 4:00 PM             │
│  [Log Meal]                     │
│                                 │
└─────────────────────────────────┘
```

### Weekly Progress Screen
```
┌─────────────────────────────────┐
│  ← Back    Weekly Progress      │
│  Adherence: 75%                 │
├─────────────────────────────────┤
│                                 │
│  Mon  [✓✓✓✓✓]  100%            │
│  Tue  [✓✓✓✗✓]   80%             │
│  Wed  [✓✗✓✓✓]   80%             │
│  Thu  [✓✓✓✓✓]  100%             │
│  Fri  [✓✓✗✓✓]   80%             │
│  Sat  [✗✗✗✗✗]    0%             │
│  Sun  [✓✓✓✓✓]  100%             │
│                                 │
│  Meals Followed: 26/35          │
│  Meals with Alternatives: 4     │
│                                 │
│  [Tap day for details]          │
│                                 │
└─────────────────────────────────┘
```

### Report Generation Screen
```
┌─────────────────────────────────────────────┐
│  ← Back to Progress    [Generate Report]    │
│                                             │
│  Generate Progress Report                   │
│                                             │
│  Select Date Range:                         │
│  ○ Last Week                                │
│  ○ Last Month                               │
│  ● Custom Range                             │
│                                             │
│  From: [Jan 8, 2024] ▼                      │
│  To:   [Jan 14, 2024] ▼                     │
│                                             │
│  Report Includes:                           │
│  ✓ Meal logs (all meals)                    │
│  ✓ Adherence statistics                     │
│  ✓ Client notes                             │
│  ✓ Weekly summary                           │
│                                             │
│  [Preview Report] [Generate & Download]     │
│                                             │
└─────────────────────────────────────────────┘
```

### Report Preview Screen
```
┌─────────────────────────────────────────────┐
│  Progress Report Preview                    │
│                                             │
│  Client: Sarah Johnson                      │
│  Period: Jan 8 - Jan 14, 2024               │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │ Summary                               │  │
│  │ • Total Meals: 35                     │  │
│  │ • Meals Followed: 30 (86%)            │  │
│  │ • Alternative Meals: 5                │  │
│  │ • Average Daily Adherence: 85%        │  │
│  └───────────────────────────────────────┘  │
│                                             │
│  [Scroll to see daily breakdown...]         │
│                                             │
│  [← Back] [Download PDF] [Share Report]     │
│                                             │
└─────────────────────────────────────────────┘
```

### Log Alternative Meal Screen
```
┌─────────────────────────────────────────────┐
│  ← Back    Log Alternative Meal             │
│                                             │
│  Original Meal:                             │
│  Grilled Chicken Salad                      │
│                                             │
│  What did you eat instead?                  │
│  ┌─────────────────────────────────────┐   │
│  │ Caesar salad with grilled chicken   │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  Notes (optional):                          │
│  ┌─────────────────────────────────────┐   │
│  │ Had business lunch, restaurant       │   │
│  │ didn't have mixed greens            │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  [Cancel]              [Save Alternative]   │
│                                             │
└─────────────────────────────────────────────┘
```

---

## Technical Requirements for Flutter

### Required Packages
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1  # or riverpod, bloc, etc.
  
  # Local Storage
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0  # For local database
  path_provider: ^2.1.1
  
  # PDF Generation
  pdf: ^3.10.7
  printing: ^5.12.0
  
  # Date/Time
  intl: ^0.19.0
  
  # JSON Serialization
  json_annotation: ^4.8.1
  
  # UI Components
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  
  # Share Functionality
  share_plus: ^7.2.1
  
  # File Operations
  path_provider: ^2.1.1
  file_picker: ^6.1.1

dev_dependencies:
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
```

### Project Structure
```
lib/
├── main.dart
├── models/
│   ├── client.dart
│   ├── meal_plan.dart
│   ├── meal.dart
│   ├── meal_log.dart
│   └── weekly_progress.dart
├── services/
│   ├── meal_plan_service.dart
│   ├── meal_log_service.dart
│   ├── progress_service.dart
│   └── report_service.dart
├── repositories/
│   ├── meal_plan_repository.dart
│   └── meal_log_repository.dart
├── screens/
│   ├── daily_view_screen.dart
│   ├── weekly_progress_screen.dart
│   ├── report_generation_screen.dart
│   ├── report_preview_screen.dart
│   └── log_alternative_screen.dart
├── widgets/
│   ├── meal_card.dart
│   ├── progress_indicator.dart
│   ├── weekly_calendar.dart
│   └── adherence_chart.dart
├── utils/
│   ├── date_utils.dart
│   ├── constants.dart
│   └── mock_data.dart
└── providers/
    ├── meal_plan_provider.dart
    ├── meal_log_provider.dart
    └── progress_provider.dart
```

### State Management Approach
- Use Provider or Riverpod for state management
- Separate providers for:
  - Meal Plan (loading, current plan)
  - Meal Logs (logging, retrieving)
  - Weekly Progress (calculations, aggregations)

### Local Storage Strategy
- Use SQLite (sqflite) for persistent storage
- Store:
  - Meal plans (mock data)
  - Meal logs
  - Client profile
- Use SharedPreferences for:
  - User preferences
  - App settings

### PDF Generation
- Use `pdf` package for creating PDF documents
- Use `printing` package for preview and sharing
- Include:
  - Report header with client info and date range
  - Summary statistics
  - Daily breakdown with meal logs
  - Notes section
  - Adherence charts (simple bar charts)

---

## Key Features Implementation Guide

### 1. Meal Logging Flow

```dart
// When user taps "Followed Plan"
void logMealAsFollowed(String mealId) {
  final mealLog = MealLog(
    id: generateId(),
    clientId: currentClientId,
    mealId: mealId,
    loggedDate: DateTime.now(),
    loggedTime: DateTime.now(),
    status: MealLogStatus.followed,
    alternativeMeal: null,
    notes: null,
    createdAt: DateTime.now(),
  );
  
  // Save to database
  mealLogRepository.saveMealLog(mealLog);
  
  // Update UI
  notifyListeners();
  
  // Calculate adherence
  progressProvider.updateDailyProgress();
}
```

### 2. Weekly Progress Calculation

```dart
WeeklyProgress calculateWeeklyProgress(DateTime weekStart) {
  final weekEnd = weekStart.add(Duration(days: 6));
  final meals = mealPlanRepository.getMealsForWeek(weekStart, weekEnd);
  final logs = mealLogRepository.getLogsForWeek(weekStart, weekEnd);
  
  int totalMeals = meals.length;
  int mealsFollowed = logs.where((log) => log.status == MealLogStatus.followed).length;
  int mealsWithAlternatives = logs.where((log) => log.status == MealLogStatus.alternative).length;
  
  double adherencePercentage = (mealsFollowed / totalMeals) * 100;
  
  // Calculate daily progress
  Map<int, DailyProgress> dailyProgress = {};
  for (int day = 1; day <= 7; day++) {
    dailyProgress[day] = calculateDailyProgress(weekStart.add(Duration(days: day - 1)));
  }
  
  return WeeklyProgress(
    weekStartDate: weekStart,
    weekEndDate: weekEnd,
    totalMeals: totalMeals,
    mealsFollowed: mealsFollowed,
    mealsWithAlternatives: mealsWithAlternatives,
    adherencePercentage: adherencePercentage,
    dailyProgress: dailyProgress,
  );
}
```

### 3. PDF Report Generation

```dart
Future<Uint8List> generateProgressReport({
  required DateTime startDate,
  required DateTime endDate,
  required Client client,
}) async {
  final pdf = pw.Document();
  
  // Header
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Progress Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text('Client: ${client.name}'),
            pw.Text('Period: ${formatDate(startDate)} - ${formatDate(endDate)}'),
            pw.Divider(),
            // Summary section
            pw.Text('Summary', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            // ... add statistics
            // Daily breakdown
            pw.Text('Daily Breakdown', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            // ... add daily meal logs
          ],
        );
      },
    ),
  );
  
  return pdf.save();
}
```

---

## Success Indicators

### Client Experience
- ✅ Can log meal in < 5 seconds
- ✅ Clear visual feedback on progress
- ✅ Understands weekly adherence at a glance
- ✅ Can generate report in < 2 minutes
- ✅ Can share report easily with nutritionist

### Report Generation
- ✅ Report preview loads quickly
- ✅ PDF generation takes < 30 seconds
- ✅ Report includes all necessary data
- ✅ Professional formatting suitable for consultations

### Demo Success
- ✅ Nutritionists understand the value proposition
- ✅ Demo flows smoothly without errors
- ✅ Questions focus on features, not bugs
- ✅ Nutritionists see how clients can share progress easily

---

## Edge Cases to Handle

1. **No Meals Logged**: Show empty state with encouragement message
2. **Partial Week**: Handle weeks where plan hasn't been active full 7 days
3. **Multiple Alternative Meals**: Show all alternatives clearly in reports
4. **No Notes**: Don't show notes section if none exist
5. **Export Empty Range**: Show message if no data for selected range
6. **Past Date Logging**: Allow logging meals for previous days (within reason)
7. **Future Date Logging**: Prevent logging meals for future dates
8. **Duplicate Logging**: Handle case where user tries to log same meal twice

---

## Development Checklist

### Phase 1: Core Setup
- [ ] Set up Flutter project
- [ ] Configure dependencies
- [ ] Set up project structure
- [ ] Create data models
- [ ] Set up local database (SQLite)
- [ ] Create mock data loader

### Phase 2: Daily View
- [ ] Implement daily meal list screen
- [ ] Create meal card widget
- [ ] Implement "Followed Plan" button
- [ ] Implement "Log Alternative" flow
- [ ] Add progress indicator
- [ ] Implement date navigation

### Phase 3: Meal Logging
- [ ] Create meal log repository
- [ ] Implement log saving functionality
- [ ] Add timestamp recording
- [ ] Implement log status updates
- [ ] Add validation

### Phase 4: Weekly Progress
- [ ] Create weekly progress screen
- [ ] Implement weekly calendar widget
- [ ] Calculate adherence percentages
- [ ] Display daily progress
- [ ] Add day detail view

### Phase 5: Report Generation
- [ ] Create report generation screen
- [ ] Implement date range selection
- [ ] Create report preview
- [ ] Implement PDF generation
- [ ] Add share functionality
- [ ] Add download functionality

### Phase 6: Polish & Testing
- [ ] Add loading states
- [ ] Add error handling
- [ ] Add empty states
- [ ] Test all flows
- [ ] Fix bugs
- [ ] Optimize performance

---

## Demo Script

### Phase 1: Client Meal Tracking (5 minutes)
1. Show client login (or demo account)
2. Display today's meal plan
3. Explain meal structure
4. Demonstrate logging breakfast (followed plan)
5. Show progress update
6. Switch to lunch
7. Show log alternative flow
8. Enter alternative meal
9. Add note
10. Save and show update
11. Switch to weekly view
12. Show weekly progress
13. Show adherence stats
14. Click on day to show details

### Phase 2: Report Generation (5 minutes)
1. Navigate to report generation section
2. Show report generation options
3. Explain date range selection
4. Select "Last Week"
5. Show report preview
6. Scroll through preview
7. Show summary statistics
8. Show daily breakdown
9. Show meal logs
10. Show notes section
11. Click "Generate PDF"
12. Generate PDF
13. Show PDF download
14. Show share options
15. Demonstrate email share

### Phase 3: Value Demonstration (5 minutes)
1. Highlight key benefits:
   - Easy meal tracking for clients
   - Automatic progress calculation
   - Professional reports for nutritionist consultations
   - Clients can share progress easily before appointments
   - Data-driven insights help nutritionists provide better guidance
2. Discuss future features (PDF parsing, full app, etc.)
3. Collect feedback

---

## Next Steps After MVP

1. **Collect Feedback**
   - Survey nutritionists
   - Gather feature requests
   - Identify pain points

2. **Plan Full MVP**
   - Add PDF upload/parsing
   - Implement authentication
   - Add other modules (Movement, Sleep, Habits)
   - Implement full gamification system

3. **Technical Improvements**
   - Backend API development
   - Cloud storage for meal plans
   - Sync across devices
   - Push notifications

---

## Design Principles

1. **Simplicity**: Keep the UI clean and focused on meal logging
2. **Speed**: Optimize for quick meal logging (one-tap when possible)
3. **Clarity**: Make progress and adherence easy to understand
4. **Professional**: Reports should look professional for sharing with nutritionists
5. **User-Centric**: Focus on making it easy for clients to track and share progress

---

## Questions & Notes

- Mock data should be realistic and comprehensive (7 days, 5 meals per day = 35 meals)
- Consider adding onboarding flow for first-time users
- Add haptic feedback for button taps (optional but nice UX)
- Consider dark mode support (optional)
- Ensure accessibility (screen readers, proper contrast)

---

**Good luck building the MVP! 🚀**

