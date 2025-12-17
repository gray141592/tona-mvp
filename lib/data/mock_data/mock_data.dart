import '../models/client.dart';
import '../models/meal.dart';
import '../models/consultation_appointment.dart';
import '../models/meal_ingredient.dart';
import '../models/meal_plan.dart';
import '../models/meal_type.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/time_provider.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

class MockData {
  static Client getMockClient() {
    return Client(
      id: AppConstants.mockClientId,
      name: 'Sarah Johnson',
      email: 'sarah@example.com',
      nutritionistId: 'nutr_001',
      mealPlanId: AppConstants.mockMealPlanId,
      createdAt: DateTime(2024, 1, 8),
      lastActiveAt: TimeProvider.now(),
    );
  }

  static MealPlan getMockMealPlan({
    DateTime? startDateOverride,
    AppLocalizations? localizations,
  }) {
    final anchor = startDateOverride ?? TimeProvider.now();
    final startDate = anchor.subtract(const Duration(days: 7));
    final endDate = startDate.add(const Duration(days: 6));

    final meals = <Meal>[];

    for (var day = 1; day <= 7; day++) {
      meals.addAll(_getDayMeals(day, localizations));
    }

    return MealPlan(
      id: AppConstants.mockMealPlanId,
      clientId: AppConstants.mockClientId,
      name: localizations?.mock_mealPlanName ?? 'Week 1 Meal Plan',
      startDate: startDate,
      endDate: endDate,
      meals: meals,
    );
  }

  static MealPlan getMockEnduranceMealPlan({
    DateTime? startDateOverride,
    AppLocalizations? localizations,
  }) {
    final anchor = startDateOverride ?? TimeProvider.now();
    final basePlan = getMockMealPlan(
      startDateOverride: anchor,
      localizations: localizations,
    );
    final startDate = anchor.add(const Duration(days: 7));
    final endDate = startDate.add(const Duration(days: 6));

    final meals = basePlan.meals
        .map(
          (meal) => Meal(
            id: 'plan_002_${meal.id}',
            mealPlanId: 'plan_002',
            dayOfWeek: meal.dayOfWeek,
            mealType: meal.mealType,
            name: meal.name,
            description: meal.description,
            ingredients: meal.ingredients,
            preparationInstructions: meal.preparationInstructions,
            timeScheduled: meal.timeScheduled,
          ),
        )
        .toList();

    return MealPlan(
      id: 'plan_002',
      clientId: AppConstants.mockClientId,
      name: localizations?.mock_endurancePlanName ?? 'Endurance Support Plan',
      startDate: startDate,
      endDate: endDate,
      meals: meals,
    );
  }

  static List<ConsultationAppointment> getMockConsultations(
      {AppLocalizations? localizations}) {
    final anchor = TimeProvider.now();
    final onboardingPlan = getMockMealPlan(
      startDateOverride: anchor,
      localizations: localizations,
    );
    final endurancePlan = getMockEnduranceMealPlan(
      startDateOverride: anchor,
      localizations: localizations,
    );

    DateTime buildDate({required int daysFromNow, required int hour}) {
      final base = anchor.add(Duration(days: daysFromNow));
      return DateTime(
        base.year,
        base.month,
        base.day,
        hour,
        0,
      );
    }

    final lastQuarterConsultation = ConsultationAppointment(
      id: 'consult_001',
      scheduledAt: buildDate(daysFromNow: -45, hour: 9),
      nutritionistName: 'Dr. Emily Carter',
      meetingFormat: 'Video call',
      meetingLink: 'https://meet.example.com/tona-consult-001',
      focusAreas: localizations != null
          ? [
              localizations.mock_consultation_1_focusArea_0,
              localizations.mock_consultation_1_focusArea_1,
            ]
          : const [
              'Stabilise fasting glucose',
              'Reintroduce strength training fuel',
            ],
      preparationNotes: localizations != null
          ? [
              localizations.mock_consultation_1_preparationNote_0,
              localizations.mock_consultation_1_preparationNote_1,
            ]
          : const [
              'Upload latest glucometer exports',
              'Track hydration for 3 days prior',
            ],
      linkedMealPlan: onboardingPlan,
      notes:
          'Discussed baseline adjustments, focus on consistent breakfast and training recovery.',
      hasUploadedFollowUpPlan: true,
      outcome: ConsultationOutcome(
        summary:
            'Reviewed first month of adherence, introduced additional protein at lunch and refined evening snack timing.',
        mealPlan: ConsultationMealPlanSummary(
          planId: onboardingPlan.id,
          title: onboardingPlan.name,
          effectiveFrom: onboardingPlan.startDate,
          effectiveUntil: onboardingPlan.endDate,
          highlights: const [
            'Higher satiety breakfast options',
            'Post-workout recovery snacks',
            'Reduced late-evening carbohydrate load',
          ],
          plan: onboardingPlan,
        ),
        report: ConsultationReportSummary(
          id: 'consult_001_report',
          title: 'Onboarding Progress Report',
          generatedAt: buildDate(daysFromNow: -44, hour: 12),
          description:
              'Summarises baseline metrics, adherence trends, and first adjustments.',
          downloadUrl: 'https://files.example.com/reports/consult_001.pdf',
        ),
        actionItems: const [
          'Maintain hydration tracking until next visit.',
          'Send three evening glucose logs after workout days.',
        ],
      ),
    );

    final midCycleConsultation = ConsultationAppointment(
      id: 'consult_002',
      scheduledAt: buildDate(daysFromNow: -12, hour: 11),
      nutritionistName: 'Dr. Emily Carter',
      meetingFormat: 'In-person',
      location: 'Wellness Clinic, Downtown',
      focusAreas: localizations != null
          ? [
              localizations.mock_consultation_2_focusArea_0,
              localizations.mock_consultation_2_focusArea_1,
            ]
          : const [
              'Dial in pre-run fuelling',
              'Adjust fibre targets',
            ],
      preparationNotes: localizations != null
          ? [
              localizations.mock_consultation_2_preparationNote_0,
              localizations.mock_consultation_2_preparationNote_1,
            ]
          : const [
              'Bring food journal for previous 14 days',
              'Note any hypoglycaemia symptoms',
            ],
      linkedMealPlan: endurancePlan,
      notes:
          'Agreed to trial new long-run fueling strategy and adjust dinner fibres.',
      hasUploadedFollowUpPlan: true,
      outcome: ConsultationOutcome(
        summary:
            'Optimised carbohydrate timing around training sessions and introduced higher fibre dinner rotation.',
        mealPlan: ConsultationMealPlanSummary(
          planId: endurancePlan.id,
          title: 'Endurance Support Plan',
          effectiveFrom: endurancePlan.startDate,
          effectiveUntil: endurancePlan.endDate,
          highlights: const [
            'Targeted carb ramp pre long run',
            'Electrolyte-focused hydration strategy',
            'Higher fibre dinner rotation',
          ],
          plan: endurancePlan,
        ),
        report: ConsultationReportSummary(
          id: 'consult_002_report',
          title: 'Training Season Check-in',
          generatedAt: buildDate(daysFromNow: -11, hour: 15),
          description:
              'Includes adherence summary, training day comparisons, and glycaemic response notes.',
          downloadUrl: 'https://files.example.com/reports/consult_002.pdf',
        ),
        actionItems: const [
          'Share training schedule updates weekly.',
          'Log perceived effort alongside post-run meals.',
        ],
      ),
    );

    return [
      lastQuarterConsultation,
      midCycleConsultation,
    ];
  }

  static MealIngredient _parseIngredient(String ingredientStr) {
    // Try to parse "quantity name" format
    // Look for patterns like "1 cup", "1/2 cup", "5 oz", "to taste", etc.
    final quantityPattern = RegExp(r'^((\d+|\d+/\d+|\d+\.\d+)\s*(cup|cups|oz|tbsp|tsp|slice|slices|can|cans|scoop|scoops|medium|large|small|strips?|chunks?|wedges?)|to taste)\s+', caseSensitive: false);
    final match = quantityPattern.firstMatch(ingredientStr);
    
    if (match != null) {
      final quantity = match.group(0)!.trim();
      final name = ingredientStr.substring(match.end).trim();
      return MealIngredient(quantity: quantity, name: name);
    } else {
      // No quantity found, store whole string as name
      return MealIngredient(name: ingredientStr);
    }
  }


  static List<Meal> _getDayMeals(int dayOfWeek, AppLocalizations? localizations) {
    final planId = AppConstants.mockMealPlanId;

    switch (dayOfWeek) {
      case 1: // Monday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: localizations?.mock_meal_1_breakfast_name ?? 'Oatmeal with Berries',
            description: localizations?.mock_meal_1_breakfast_desc ??
                '1 cup cooked oatmeal, 1/2 cup mixed berries, 1 tbsp almond butter, honey drizzle',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_1_breakfast_ingredient_0),
                    _parseIngredient(localizations.mock_meal_1_breakfast_ingredient_1),
                    _parseIngredient(localizations.mock_meal_1_breakfast_ingredient_2),
                    _parseIngredient(localizations.mock_meal_1_breakfast_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'cooked oatmeal'),
                    MealIngredient(quantity: '1/2 cup', name: 'mixed berries'),
                    MealIngredient(quantity: '1 tbsp', name: 'almond butter'),
                    MealIngredient(quantity: '1 tsp', name: 'honey'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_1_breakfast_instruction_0,
                    localizations.mock_meal_1_breakfast_instruction_1,
                  ]
                : const [
                    'Cook the oatmeal with water or milk until creamy.',
                    'Top with mixed berries, almond butter, and a drizzle of honey.',
                  ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: localizations?.mock_meal_1_snack1_name ?? 'Apple with Almond Butter',
            description: localizations?.mock_meal_1_snack1_desc ?? '1 medium apple, 1 tbsp almond butter',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_1_snack1_ingredient_0),
                    _parseIngredient(localizations.mock_meal_1_snack1_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '1', name: 'medium apple'),
                    MealIngredient(quantity: '1 tbsp', name: 'almond butter'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_1_snack1_instruction_0,
                    localizations.mock_meal_1_snack1_instruction_1,
                  ]
                : const [
                    'Slice the apple into wedges or rounds.',
                    'Serve with almond butter for dipping or spreading.',
                  ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: localizations?.mock_meal_1_lunch_name ?? 'Grilled Chicken Salad',
            description: localizations?.mock_meal_1_lunch_desc ??
                '4oz grilled chicken breast, mixed greens, cherry tomatoes, cucumber, olive oil dressing',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_1_lunch_ingredient_0),
                    _parseIngredient(localizations.mock_meal_1_lunch_ingredient_1),
                    _parseIngredient(localizations.mock_meal_1_lunch_ingredient_2),
                    _parseIngredient(localizations.mock_meal_1_lunch_ingredient_3),
                    _parseIngredient(localizations.mock_meal_1_lunch_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '4 oz', name: 'grilled chicken breast'),
                    MealIngredient(quantity: '2 cups', name: 'mixed greens'),
                    MealIngredient(quantity: '1/2 cup', name: 'cherry tomatoes'),
                    MealIngredient(quantity: '1/2', name: 'cucumber'),
                    MealIngredient(quantity: '2 tbsp', name: 'olive oil dressing'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_1_lunch_instruction_0,
                    localizations.mock_meal_1_lunch_instruction_1,
                  ]
                : const [
                    'Slice the grilled chicken and vegetables.',
                    'Combine everything in a bowl and drizzle with olive oil dressing.',
                  ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: localizations?.mock_meal_1_snack2_name ?? 'Greek Yogurt with Berries',
            description: localizations?.mock_meal_1_snack2_desc ?? '1 cup plain Greek yogurt, 1/4 cup mixed berries',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_1_snack2_ingredient_0),
                    _parseIngredient(localizations.mock_meal_1_snack2_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'plain Greek yogurt'),
                    MealIngredient(quantity: '1/4 cup', name: 'mixed berries'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_1_snack2_instruction_0,
                    localizations.mock_meal_1_snack2_instruction_1,
                  ]
                : const [
                    'Spoon the yogurt into a bowl.',
                    'Top with mixed berries just before serving.',
                  ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: localizations?.mock_meal_1_dinner_name ?? 'Baked Salmon with Vegetables',
            description: localizations?.mock_meal_1_dinner_desc ?? '5oz salmon fillet, roasted broccoli and sweet potato',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_1_dinner_ingredient_0),
                    _parseIngredient(localizations.mock_meal_1_dinner_ingredient_1),
                    _parseIngredient(localizations.mock_meal_1_dinner_ingredient_2),
                    _parseIngredient(localizations.mock_meal_1_dinner_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '5 oz', name: 'salmon fillet'),
                    MealIngredient(quantity: '1 cup', name: 'roasted broccoli'),
                    MealIngredient(quantity: '1', name: 'medium sweet potato'),
                    MealIngredient(quantity: '1', name: 'lemon wedge'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_1_dinner_instruction_0,
                    localizations.mock_meal_1_dinner_instruction_1,
                  ]
                : const [
                    'Bake the seasoned salmon and vegetables until tender.',
                    'Serve with a squeeze of lemon over the top.',
                  ],
            timeScheduled: '19:00',
          ),
        ];

      case 2: // Tuesday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: localizations?.mock_meal_2_breakfast_name ?? 'Scrambled Eggs with Avocado Toast',
            description: localizations?.mock_meal_2_breakfast_desc ??
                '2 eggs scrambled, 1 slice whole grain toast, 1/2 avocado, cherry tomatoes',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_2_breakfast_ingredient_0),
                    _parseIngredient(localizations.mock_meal_2_breakfast_ingredient_1),
                    _parseIngredient(localizations.mock_meal_2_breakfast_ingredient_2),
                    _parseIngredient(localizations.mock_meal_2_breakfast_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '2', name: 'large eggs'),
                    MealIngredient(quantity: '1 slice', name: 'whole grain bread'),
                    MealIngredient(quantity: '1/2', name: 'avocado'),
                    MealIngredient(quantity: '4', name: 'cherry tomatoes'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_2_breakfast_instruction_0,
                    localizations.mock_meal_2_breakfast_instruction_1,
                  ]
                : const [
                    'Scramble the eggs in a non-stick pan until softly set.',
                    'Toast the bread, top with mashed avocado, and serve with tomatoes.',
                  ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: localizations?.mock_meal_2_snack1_name ?? 'Protein Smoothie',
            description: localizations?.mock_meal_2_snack1_desc ?? 'Banana, protein powder, almond milk, spinach',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_2_snack1_ingredient_0),
                    _parseIngredient(localizations.mock_meal_2_snack1_ingredient_1),
                    _parseIngredient(localizations.mock_meal_2_snack1_ingredient_2),
                    _parseIngredient(localizations.mock_meal_2_snack1_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '1', name: 'banana'),
                    MealIngredient(quantity: '1 scoop', name: 'protein powder'),
                    MealIngredient(quantity: '1 cup', name: 'almond milk'),
                    MealIngredient(quantity: '1 cup', name: 'spinach'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_2_snack1_instruction_0,
                    localizations.mock_meal_2_snack1_instruction_1,
                  ]
                : const [
                    'Add all ingredients to a blender.',
                    'Blend until smooth and creamy, then serve immediately.',
                  ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: localizations?.mock_meal_2_lunch_name ?? 'Turkey Wrap with Hummus',
            description: localizations?.mock_meal_2_lunch_desc ??
                'Whole wheat tortilla, 4oz turkey breast, hummus, lettuce, peppers',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_2_lunch_ingredient_0),
                    _parseIngredient(localizations.mock_meal_2_lunch_ingredient_1),
                    _parseIngredient(localizations.mock_meal_2_lunch_ingredient_2),
                    _parseIngredient(localizations.mock_meal_2_lunch_ingredient_3),
                    _parseIngredient(localizations.mock_meal_2_lunch_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '1', name: 'whole wheat tortilla'),
                    MealIngredient(quantity: '4 oz', name: 'sliced turkey breast'),
                    MealIngredient(quantity: '2 tbsp', name: 'hummus'),
                    MealIngredient(quantity: '1 cup', name: 'lettuce'),
                    MealIngredient(quantity: '1/4 cup', name: 'sliced bell peppers'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_2_lunch_instruction_0,
                    localizations.mock_meal_2_lunch_instruction_1,
                  ]
                : const [
                    'Spread hummus over the tortilla.',
                    'Layer turkey, lettuce, and peppers, then roll tightly and slice.',
                  ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: localizations?.mock_meal_2_snack2_name ?? 'Carrot Sticks with Hummus',
            description: localizations?.mock_meal_2_snack2_desc ?? '1 cup carrot sticks, 1/4 cup hummus',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_2_snack2_ingredient_0),
                    _parseIngredient(localizations.mock_meal_2_snack2_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'carrot sticks'),
                    MealIngredient(quantity: '1/4 cup', name: 'hummus'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_2_snack2_instruction_0,
                    localizations.mock_meal_2_snack2_instruction_1,
                  ]
                : const [
                    'Peel and slice the carrots into sticks if needed.',
                    'Serve with hummus for dipping.',
                  ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: localizations?.mock_meal_2_dinner_name ?? 'Chicken Stir-Fry',
            description: localizations?.mock_meal_2_dinner_desc ??
                '5oz chicken breast, mixed vegetables, brown rice, teriyaki sauce',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_2_dinner_ingredient_0),
                    _parseIngredient(localizations.mock_meal_2_dinner_ingredient_1),
                    _parseIngredient(localizations.mock_meal_2_dinner_ingredient_2),
                    _parseIngredient(localizations.mock_meal_2_dinner_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '5 oz', name: 'chicken breast'),
                    MealIngredient(quantity: '2 cups', name: 'mixed vegetables'),
                    MealIngredient(quantity: '1 cup', name: 'brown rice'),
                    MealIngredient(quantity: '2 tbsp', name: 'teriyaki sauce'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_2_dinner_instruction_0,
                    localizations.mock_meal_2_dinner_instruction_1,
                  ]
                : const [
                    'Stir-fry the chicken until nearly cooked through.',
                    'Add vegetables and sauce, cook until crisp-tender, and serve over rice.',
                  ],
            timeScheduled: '19:00',
          ),
        ];

      case 3: // Wednesday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: localizations?.mock_meal_3_breakfast_name ?? 'Greek Yogurt Parfait',
            description: localizations?.mock_meal_3_breakfast_desc ??
                'Greek yogurt layered with granola, berries, and honey',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_3_breakfast_ingredient_0),
                    _parseIngredient(localizations.mock_meal_3_breakfast_ingredient_1),
                    _parseIngredient(localizations.mock_meal_3_breakfast_ingredient_2),
                    _parseIngredient(localizations.mock_meal_3_breakfast_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'Greek yogurt'),
                    MealIngredient(quantity: '1/2 cup', name: 'granola'),
                    MealIngredient(quantity: '1/2 cup', name: 'mixed berries'),
                    MealIngredient(quantity: '1 tsp', name: 'honey'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_3_breakfast_instruction_0,
                    localizations.mock_meal_3_breakfast_instruction_1,
                  ]
                : const [
                    'Layer yogurt, granola, and berries in a glass or bowl.',
                    'Drizzle honey over the top before serving.',
                  ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: localizations?.mock_meal_3_snack1_name ?? 'Mixed Nuts',
            description: localizations?.mock_meal_3_snack1_desc ?? '1/4 cup mixed almonds, cashews, and walnuts',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_3_snack1_ingredient_0),
                  ]
                : const [
                    MealIngredient(quantity: '1/4 cup', name: 'mixed nuts'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_3_snack1_instruction_0,
                    localizations.mock_meal_3_snack1_instruction_1,
                  ]
                : const [
                    'Portion the mixed nuts into a small bowl or container.',
                    'Enjoy immediately or pack to-go for later.',
                  ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: localizations?.mock_meal_3_lunch_name ?? 'Quinoa Buddha Bowl',
            description: localizations?.mock_meal_3_lunch_desc ??
                'Quinoa, roasted chickpeas, avocado, vegetables, tahini dressing',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_3_lunch_ingredient_0),
                    _parseIngredient(localizations.mock_meal_3_lunch_ingredient_1),
                    _parseIngredient(localizations.mock_meal_3_lunch_ingredient_2),
                    _parseIngredient(localizations.mock_meal_3_lunch_ingredient_3),
                    _parseIngredient(localizations.mock_meal_3_lunch_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'cooked quinoa'),
                    MealIngredient(quantity: '1/2 cup', name: 'roasted chickpeas'),
                    MealIngredient(quantity: '1/2', name: 'avocado'),
                    MealIngredient(quantity: '1 cup', name: 'mixed vegetables'),
                    MealIngredient(quantity: '2 tbsp', name: 'tahini dressing'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_3_lunch_instruction_0,
                    localizations.mock_meal_3_lunch_instruction_1,
                  ]
                : const [
                    'Warm the quinoa and arrange it in a bowl.',
                    'Top with chickpeas, vegetables, avocado, and drizzle with tahini dressing.',
                  ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: localizations?.mock_meal_3_snack2_name ?? 'Cottage Cheese with Pineapple',
            description: localizations?.mock_meal_3_snack2_desc ??
                '1 cup low-fat cottage cheese, 1/2 cup pineapple chunks',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_3_snack2_ingredient_0),
                    _parseIngredient(localizations.mock_meal_3_snack2_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'low-fat cottage cheese'),
                    MealIngredient(quantity: '1/2 cup', name: 'pineapple chunks'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_3_snack2_instruction_0,
                    localizations.mock_meal_3_snack2_instruction_1,
                  ]
                : const [
                    'Scoop cottage cheese into a serving bowl.',
                    'Top with pineapple chunks and enjoy.',
                  ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: localizations?.mock_meal_3_dinner_name ?? 'Lean Beef Tacos',
            description: localizations?.mock_meal_3_dinner_desc ??
                'Lean ground beef, corn tortillas, lettuce, tomato, salsa',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_3_dinner_ingredient_0),
                    _parseIngredient(localizations.mock_meal_3_dinner_ingredient_1),
                    _parseIngredient(localizations.mock_meal_3_dinner_ingredient_2),
                    _parseIngredient(localizations.mock_meal_3_dinner_ingredient_3),
                    _parseIngredient(localizations.mock_meal_3_dinner_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '5 oz', name: 'lean ground beef'),
                    MealIngredient(quantity: '2', name: 'corn tortillas'),
                    MealIngredient(quantity: '1 cup', name: 'shredded lettuce'),
                    MealIngredient(quantity: '1', name: 'diced tomato'),
                    MealIngredient(quantity: '2 tbsp', name: 'salsa'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_3_dinner_instruction_0,
                    localizations.mock_meal_3_dinner_instruction_1,
                  ]
                : const [
                    'Cook the ground beef with seasonings until browned.',
                    'Warm the tortillas, then assemble with lettuce, tomato, and salsa.',
                  ],
            timeScheduled: '19:00',
          ),
        ];

      case 4: // Thursday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: localizations?.mock_meal_4_breakfast_name ?? 'Whole Grain Pancakes',
            description: localizations?.mock_meal_4_breakfast_desc ?? '2 whole grain pancakes, fresh berries, maple syrup',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_4_breakfast_ingredient_0),
                    _parseIngredient(localizations.mock_meal_4_breakfast_ingredient_1),
                    _parseIngredient(localizations.mock_meal_4_breakfast_ingredient_2),
                  ]
                : const [
                    MealIngredient(quantity: '2', name: 'whole grain pancakes'),
                    MealIngredient(quantity: '1/2 cup', name: 'fresh berries'),
                    MealIngredient(quantity: '1 tbsp', name: 'maple syrup'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_4_breakfast_instruction_0,
                    localizations.mock_meal_4_breakfast_instruction_1,
                  ]
                : const [
                    'Warm the pancakes in a skillet or toaster if needed.',
                    'Serve with berries on top and drizzle with maple syrup.',
                  ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: localizations?.mock_meal_4_snack1_name ?? 'Pear with String Cheese',
            description: localizations?.mock_meal_4_snack1_desc ?? '1 medium pear, 1 string cheese',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_4_snack1_ingredient_0),
                    _parseIngredient(localizations.mock_meal_4_snack1_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '1', name: 'medium pear'),
                    MealIngredient(quantity: '1', name: 'string cheese'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_4_snack1_instruction_0,
                    localizations.mock_meal_4_snack1_instruction_1,
                  ]
                : const [
                    'Wash the pear and slice if desired.',
                    'Pair with string cheese for a quick snack.',
                  ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: localizations?.mock_meal_4_lunch_name ?? 'Tuna Salad',
            description: localizations?.mock_meal_4_lunch_desc ??
                'Tuna, mixed greens, hard-boiled egg, olives, olive oil',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_4_lunch_ingredient_0),
                    _parseIngredient(localizations.mock_meal_4_lunch_ingredient_1),
                    _parseIngredient(localizations.mock_meal_4_lunch_ingredient_2),
                    _parseIngredient(localizations.mock_meal_4_lunch_ingredient_3),
                    _parseIngredient(localizations.mock_meal_4_lunch_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '1 can', name: 'tuna in water'),
                    MealIngredient(quantity: '2 cups', name: 'mixed greens'),
                    MealIngredient(quantity: '1', name: 'hard-boiled egg'),
                    MealIngredient(quantity: '5', name: 'olives'),
                    MealIngredient(quantity: '2 tbsp', name: 'olive oil'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_4_lunch_instruction_0,
                    localizations.mock_meal_4_lunch_instruction_1,
                  ]
                : const [
                    'Drain the tuna and slice the egg and olives.',
                    'Combine ingredients with greens and drizzle with olive oil.',
                  ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: localizations?.mock_meal_4_snack2_name ?? 'Protein Bar',
            description: localizations?.mock_meal_4_snack2_desc ?? '1 protein bar (aim for 10g+ protein)',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_4_snack2_ingredient_0),
                  ]
                : const [
                    MealIngredient(quantity: '1', name: 'protein bar'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_4_snack2_instruction_0,
                  ]
                : const [
                    'Unwrap the protein bar and enjoy as a quick snack.',
                  ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: localizations?.mock_meal_4_dinner_name ?? 'Baked Chicken with Quinoa',
            description: localizations?.mock_meal_4_dinner_desc ??
                'Herb-crusted chicken breast, quinoa, roasted asparagus',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_4_dinner_ingredient_0),
                    _parseIngredient(localizations.mock_meal_4_dinner_ingredient_1),
                    _parseIngredient(localizations.mock_meal_4_dinner_ingredient_2),
                    _parseIngredient(localizations.mock_meal_4_dinner_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '5 oz', name: 'chicken breast'),
                    MealIngredient(quantity: '1 cup', name: 'cooked quinoa'),
                    MealIngredient(quantity: '1 cup', name: 'roasted asparagus'),
                    MealIngredient(quantity: 'to taste', name: 'herbs and spices'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_4_dinner_instruction_0,
                    localizations.mock_meal_4_dinner_instruction_1,
                  ]
                : const [
                    'Bake the seasoned chicken until cooked through.',
                    'Serve alongside quinoa and roasted asparagus.',
                  ],
            timeScheduled: '19:00',
          ),
        ];

      case 5: // Friday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: localizations?.mock_meal_5_breakfast_name ?? 'Veggie Omelet',
            description: localizations?.mock_meal_5_breakfast_desc ??
                '3-egg omelet with spinach, mushrooms, and feta cheese',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_5_breakfast_ingredient_0),
                    _parseIngredient(localizations.mock_meal_5_breakfast_ingredient_1),
                    _parseIngredient(localizations.mock_meal_5_breakfast_ingredient_2),
                    _parseIngredient(localizations.mock_meal_5_breakfast_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '3', name: 'large eggs'),
                    MealIngredient(quantity: '1 cup', name: 'spinach'),
                    MealIngredient(quantity: '1/2 cup', name: 'mushrooms'),
                    MealIngredient(quantity: '2 tbsp', name: 'feta cheese'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_5_breakfast_instruction_0,
                    localizations.mock_meal_5_breakfast_instruction_1,
                  ]
                : const [
                    'Sauté mushrooms and spinach until tender.',
                    'Add beaten eggs, cook until set, and sprinkle with feta before folding.',
                  ],
            timeScheduled: '08:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: localizations?.mock_meal_5_snack1_name ?? 'Banana with Peanut Butter',
            description: localizations?.mock_meal_5_snack1_desc ?? '1 medium banana, 1 tbsp peanut butter',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_5_snack1_ingredient_0),
                    _parseIngredient(localizations.mock_meal_5_snack1_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '1', name: 'medium banana'),
                    MealIngredient(quantity: '1 tbsp', name: 'peanut butter'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_5_snack1_instruction_0,
                    localizations.mock_meal_5_snack1_instruction_1,
                  ]
                : const [
                    'Peel the banana and slice if desired.',
                    'Serve with peanut butter for dipping or spreading.',
                  ],
            timeScheduled: '10:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: localizations?.mock_meal_5_lunch_name ?? 'Mediterranean Chicken Bowl',
            description: localizations?.mock_meal_5_lunch_desc ??
                'Grilled chicken, brown rice, hummus, cucumber, tomatoes, olives',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_5_lunch_ingredient_0),
                    _parseIngredient(localizations.mock_meal_5_lunch_ingredient_1),
                    _parseIngredient(localizations.mock_meal_5_lunch_ingredient_2),
                    _parseIngredient(localizations.mock_meal_5_lunch_ingredient_3),
                    _parseIngredient(localizations.mock_meal_5_lunch_ingredient_4),
                    _parseIngredient(localizations.mock_meal_5_lunch_ingredient_5),
                  ]
                : const [
                    MealIngredient(quantity: '4 oz', name: 'grilled chicken'),
                    MealIngredient(quantity: '1 cup', name: 'brown rice'),
                    MealIngredient(quantity: '2 tbsp', name: 'hummus'),
                    MealIngredient(quantity: '1/2', name: 'cucumber'),
                    MealIngredient(quantity: '1/2 cup', name: 'tomatoes'),
                    MealIngredient(quantity: '5', name: 'olives'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_5_lunch_instruction_0,
                    localizations.mock_meal_5_lunch_instruction_1,
                  ]
                : const [
                    'Layer rice in a bowl and top with sliced chicken.',
                    'Add hummus, cucumber, tomatoes, and olives before serving.',
                  ],
            timeScheduled: '13:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: localizations?.mock_meal_5_snack2_name ?? 'Rice Cakes with Avocado',
            description: localizations?.mock_meal_5_snack2_desc ?? '2 rice cakes topped with mashed avocado',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_5_snack2_ingredient_0),
                    _parseIngredient(localizations.mock_meal_5_snack2_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '2', name: 'rice cakes'),
                    MealIngredient(quantity: '1/2', name: 'avocado'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_5_snack2_instruction_0,
                    localizations.mock_meal_5_snack2_instruction_1,
                  ]
                : const [
                    'Mash the avocado with a fork and season if desired.',
                    'Spread over rice cakes and serve immediately.',
                  ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: localizations?.mock_meal_5_dinner_name ?? 'Shrimp Pasta Primavera',
            description: localizations?.mock_meal_5_dinner_desc ??
                'Whole wheat pasta, shrimp, mixed vegetables, garlic olive oil',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_5_dinner_ingredient_0),
                    _parseIngredient(localizations.mock_meal_5_dinner_ingredient_1),
                    _parseIngredient(localizations.mock_meal_5_dinner_ingredient_2),
                    _parseIngredient(localizations.mock_meal_5_dinner_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '2 oz', name: 'whole wheat pasta'),
                    MealIngredient(quantity: '5 oz', name: 'shrimp'),
                    MealIngredient(quantity: '2 cups', name: 'mixed vegetables'),
                    MealIngredient(quantity: '2 tbsp', name: 'garlic olive oil'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_5_dinner_instruction_0,
                    localizations.mock_meal_5_dinner_instruction_1,
                  ]
                : const [
                    'Cook the pasta until al dente and reserve a little cooking water.',
                    'Sauté shrimp and vegetables in garlic oil, then toss with pasta.',
                  ],
            timeScheduled: '19:00',
          ),
        ];

      case 6: // Saturday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: localizations?.mock_meal_6_breakfast_name ?? 'Breakfast Burrito',
            description: localizations?.mock_meal_6_breakfast_desc ??
                'Scrambled eggs, black beans, cheese, salsa in whole wheat tortilla',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_6_breakfast_ingredient_0),
                    _parseIngredient(localizations.mock_meal_6_breakfast_ingredient_1),
                    _parseIngredient(localizations.mock_meal_6_breakfast_ingredient_2),
                    _parseIngredient(localizations.mock_meal_6_breakfast_ingredient_3),
                    _parseIngredient(localizations.mock_meal_6_breakfast_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '2', name: 'scrambled eggs'),
                    MealIngredient(quantity: '1/4 cup', name: 'black beans'),
                    MealIngredient(quantity: '2 tbsp', name: 'shredded cheese'),
                    MealIngredient(quantity: '2 tbsp', name: 'salsa'),
                    MealIngredient(quantity: '1', name: 'whole wheat tortilla'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_6_breakfast_instruction_0,
                    localizations.mock_meal_6_breakfast_instruction_1,
                  ]
                : const [
                    'Warm the tortilla and scramble the eggs with beans.',
                    'Fill the tortilla, top with cheese and salsa, then roll tightly.',
                  ],
            timeScheduled: '09:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: localizations?.mock_meal_6_snack1_name ?? 'Trail Mix',
            description: localizations?.mock_meal_6_snack1_desc ?? 'Mixed nuts, dried cranberries, dark chocolate chips',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_6_snack1_ingredient_0),
                    _parseIngredient(localizations.mock_meal_6_snack1_ingredient_1),
                    _parseIngredient(localizations.mock_meal_6_snack1_ingredient_2),
                  ]
                : const [
                    MealIngredient(quantity: '1/4 cup', name: 'mixed nuts'),
                    MealIngredient(quantity: '2 tbsp', name: 'dried cranberries'),
                    MealIngredient(quantity: '1 tbsp', name: 'dark chocolate chips'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_6_snack1_instruction_0,
                    localizations.mock_meal_6_snack1_instruction_1,
                  ]
                : const [
                    'Combine nuts, cranberries, and chocolate chips in a small bowl.',
                    'Portion into a to-go container if needed.',
                  ],
            timeScheduled: '11:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: localizations?.mock_meal_6_lunch_name ?? 'Grilled Veggie Sandwich',
            description: localizations?.mock_meal_6_lunch_desc ??
                'Grilled zucchini, peppers, mozzarella on whole grain bread',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_6_lunch_ingredient_0),
                    _parseIngredient(localizations.mock_meal_6_lunch_ingredient_1),
                    _parseIngredient(localizations.mock_meal_6_lunch_ingredient_2),
                    _parseIngredient(localizations.mock_meal_6_lunch_ingredient_3),
                    _parseIngredient(localizations.mock_meal_6_lunch_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '2 slices', name: 'whole grain bread'),
                    MealIngredient(quantity: '1/2', name: 'grilled zucchini'),
                    MealIngredient(quantity: '1/4 cup', name: 'grilled peppers'),
                    MealIngredient(quantity: '2 slices', name: 'fresh mozzarella'),
                    MealIngredient(quantity: '1 tbsp', name: 'balsamic glaze'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_6_lunch_instruction_0,
                    localizations.mock_meal_6_lunch_instruction_1,
                  ]
                : const [
                    'Layer grilled vegetables and mozzarella on the bread.',
                    'Drizzle with balsamic glaze and toast until cheese melts if desired.',
                  ],
            timeScheduled: '13:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: localizations?.mock_meal_6_snack2_name ?? 'Edamame',
            description: localizations?.mock_meal_6_snack2_desc ?? '1 cup steamed edamame with sea salt',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_6_snack2_ingredient_0),
                    _parseIngredient(localizations.mock_meal_6_snack2_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'edamame'),
                    MealIngredient(quantity: 'to taste', name: 'sea salt'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_6_snack2_instruction_0,
                    localizations.mock_meal_6_snack2_instruction_1,
                  ]
                : const [
                    'Steam or microwave the edamame until heated through.',
                    'Sprinkle with sea salt before serving.',
                  ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: localizations?.mock_meal_6_dinner_name ?? 'Grilled Steak with Vegetables',
            description: localizations?.mock_meal_6_dinner_desc ??
                'Lean sirloin steak, roasted Brussels sprouts and carrots',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_6_dinner_ingredient_0),
                    _parseIngredient(localizations.mock_meal_6_dinner_ingredient_1),
                    _parseIngredient(localizations.mock_meal_6_dinner_ingredient_2),
                  ]
                : const [
                    MealIngredient(quantity: '5 oz', name: 'lean sirloin steak'),
                    MealIngredient(
                      quantity: '1 cup',
                      name: 'roasted Brussels sprouts',
                    ),
                    MealIngredient(quantity: '1 cup', name: 'roasted carrots'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_6_dinner_instruction_0,
                    localizations.mock_meal_6_dinner_instruction_1,
                  ]
                : const [
                    'Grill or sear the steak to your preferred doneness.',
                    'Serve with roasted Brussels sprouts and carrots on the side.',
                  ],
            timeScheduled: '19:30',
          ),
        ];

      case 7: // Sunday
        return [
          Meal(
            id: 'meal_${dayOfWeek}_breakfast',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.breakfast,
            name: localizations?.mock_meal_7_breakfast_name ?? 'French Toast with Fruit',
            description: localizations?.mock_meal_7_breakfast_desc ??
                'Whole grain French toast, fresh berries, yogurt drizzle',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_7_breakfast_ingredient_0),
                    _parseIngredient(localizations.mock_meal_7_breakfast_ingredient_1),
                    _parseIngredient(localizations.mock_meal_7_breakfast_ingredient_2),
                    _parseIngredient(localizations.mock_meal_7_breakfast_ingredient_3),
                    _parseIngredient(localizations.mock_meal_7_breakfast_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '2 slices', name: 'whole grain bread'),
                    MealIngredient(quantity: '1', name: 'egg'),
                    MealIngredient(quantity: '1/2 cup', name: 'mixed berries'),
                    MealIngredient(quantity: '2 tbsp', name: 'Greek yogurt'),
                    MealIngredient(quantity: '1 tsp', name: 'cinnamon'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_7_breakfast_instruction_0,
                    localizations.mock_meal_7_breakfast_instruction_1,
                  ]
                : const [
                    'Whisk the egg with cinnamon and soak the bread slices.',
                    'Cook on a griddle until golden, then top with berries and yogurt.',
                  ],
            timeScheduled: '09:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack1',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack1,
            name: localizations?.mock_meal_7_snack1_name ?? 'Celery with Peanut Butter',
            description: localizations?.mock_meal_7_snack1_desc ?? '4 celery sticks with 2 tbsp peanut butter',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_7_snack1_ingredient_0),
                    _parseIngredient(localizations.mock_meal_7_snack1_ingredient_1),
                  ]
                : const [
                    MealIngredient(quantity: '4', name: 'celery sticks'),
                    MealIngredient(quantity: '2 tbsp', name: 'peanut butter'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_7_snack1_instruction_0,
                    localizations.mock_meal_7_snack1_instruction_1,
                  ]
                : const [
                    'Wash and trim the celery sticks.',
                    'Fill the celery grooves with peanut butter.',
                  ],
            timeScheduled: '11:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_lunch',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.lunch,
            name: localizations?.mock_meal_7_lunch_name ?? 'Chicken Caesar Salad',
            description: localizations?.mock_meal_7_lunch_desc ??
                'Grilled chicken, romaine lettuce, parmesan, light Caesar dressing',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_7_lunch_ingredient_0),
                    _parseIngredient(localizations.mock_meal_7_lunch_ingredient_1),
                    _parseIngredient(localizations.mock_meal_7_lunch_ingredient_2),
                    _parseIngredient(localizations.mock_meal_7_lunch_ingredient_3),
                    _parseIngredient(localizations.mock_meal_7_lunch_ingredient_4),
                  ]
                : const [
                    MealIngredient(quantity: '4 oz', name: 'grilled chicken breast'),
                    MealIngredient(quantity: '2 cups', name: 'romaine lettuce'),
                    MealIngredient(quantity: '2 tbsp', name: 'parmesan cheese'),
                    MealIngredient(quantity: '2 tbsp', name: 'light Caesar dressing'),
                    MealIngredient(quantity: '1/2 cup', name: 'whole grain croutons'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_7_lunch_instruction_0,
                    localizations.mock_meal_7_lunch_instruction_1,
                  ]
                : const [
                    'Chop the lettuce and slice the grilled chicken.',
                    'Toss with dressing, parmesan, and croutons before serving.',
                  ],
            timeScheduled: '13:30',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_snack2',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.snack2,
            name: localizations?.mock_meal_7_snack2_name ?? 'Smoothie Bowl',
            description: localizations?.mock_meal_7_snack2_desc ??
                'Blended berries, banana, topped with granola and chia seeds',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_7_snack2_ingredient_0),
                    _parseIngredient(localizations.mock_meal_7_snack2_ingredient_1),
                    _parseIngredient(localizations.mock_meal_7_snack2_ingredient_2),
                    _parseIngredient(localizations.mock_meal_7_snack2_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '1 cup', name: 'mixed berries'),
                    MealIngredient(quantity: '1/2', name: 'banana'),
                    MealIngredient(quantity: '1/4 cup', name: 'granola'),
                    MealIngredient(quantity: '1 tbsp', name: 'chia seeds'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_7_snack2_instruction_0,
                    localizations.mock_meal_7_snack2_instruction_1,
                  ]
                : const [
                    'Blend the berries and banana until smooth.',
                    'Pour into a bowl and top with granola and chia seeds.',
                  ],
            timeScheduled: '16:00',
          ),
          Meal(
            id: 'meal_${dayOfWeek}_dinner',
            mealPlanId: planId,
            dayOfWeek: dayOfWeek,
            mealType: MealType.dinner,
            name: localizations?.mock_meal_7_dinner_name ?? 'Baked Cod with Sweet Potato',
            description: localizations?.mock_meal_7_dinner_desc ??
                'Herb-baked cod, mashed sweet potato, steamed green beans',
            ingredients: localizations != null
                ? [
                    _parseIngredient(localizations.mock_meal_7_dinner_ingredient_0),
                    _parseIngredient(localizations.mock_meal_7_dinner_ingredient_1),
                    _parseIngredient(localizations.mock_meal_7_dinner_ingredient_2),
                    _parseIngredient(localizations.mock_meal_7_dinner_ingredient_3),
                  ]
                : const [
                    MealIngredient(quantity: '5 oz', name: 'cod fillet'),
                    MealIngredient(quantity: '1', name: 'medium sweet potato'),
                    MealIngredient(quantity: '1 cup', name: 'green beans'),
                    MealIngredient(quantity: 'to taste', name: 'herbs and lemon'),
                  ],
            preparationInstructions: localizations != null
                ? [
                    localizations.mock_meal_7_dinner_instruction_0,
                    localizations.mock_meal_7_dinner_instruction_1,
                  ]
                : const [
                    'Season the cod with herbs and lemon, then bake until flaky.',
                    'Serve with mashed sweet potato and steamed green beans.',
                  ],
            timeScheduled: '19:30',
          ),
        ];

      default:
        return [];
    }
  }
}
