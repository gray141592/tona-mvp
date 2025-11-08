class QuantityMeasurement {
  final String raw;
  final double? amount;
  final String unit;

  const QuantityMeasurement({
    required this.raw,
    required this.amount,
    required this.unit,
  });

  bool get hasAmount => amount != null;

  String get normalizedUnit => QuantityParser.normalizeUnit(unit);
}

class ConversionResult {
  final double grams;
  final bool isEstimate;

  const ConversionResult({
    required this.grams,
    this.isEstimate = false,
  });
}

class QuantityParser {
  static final RegExp _amountMatcher = RegExp(r'^([\d\s\/\.,]+)(.*)$');

  const QuantityParser._();

  static QuantityMeasurement parse(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const QuantityMeasurement(
        raw: '',
        amount: null,
        unit: '',
      );
    }

    final match = _amountMatcher.firstMatch(trimmed);
    if (match == null) {
      return QuantityMeasurement(
        raw: trimmed,
        amount: null,
        unit: trimmed.toLowerCase(),
      );
    }

    final amountPart = match.group(1)?.trim() ?? '';
    final unitPart = match.group(2)?.trim() ?? '';
    final parsedAmount = _parseAmount(amountPart);

    if (parsedAmount == null) {
      return QuantityMeasurement(
        raw: trimmed,
        amount: null,
        unit: trimmed.toLowerCase(),
      );
    }

    final unit = unitPart.isEmpty ? 'count' : unitPart.toLowerCase();
    return QuantityMeasurement(
      raw: trimmed,
      amount: parsedAmount,
      unit: unit,
    );
  }

  static double? _parseAmount(String input) {
    if (input.isEmpty) return null;

    final sanitized = input.replaceAll(',', '.');
    final parts = sanitized.split(RegExp(r'\s+'));
    var total = 0.0;
    var parsed = false;

    for (final part in parts) {
      if (part.isEmpty) continue;

      final fractionParts = part.split('/');
      if (fractionParts.length == 2) {
        final numerator = double.tryParse(fractionParts[0]);
        final denominator = double.tryParse(fractionParts[1]);
        if (numerator != null && denominator != null && denominator != 0) {
          total += numerator / denominator;
          parsed = true;
          continue;
        }
      }

      final value = double.tryParse(part);
      if (value != null) {
        total += value;
        parsed = true;
      }
    }

    return parsed ? total : null;
  }

  static String normalizeUnit(String unit) {
    final normalized = unit.trim().toLowerCase();

    if (normalized.isEmpty) return '';

    const aliases = {
      'cups': 'cup',
      'cup': 'cup',
      'c': 'cup',
      'tablespoon': 'tbsp',
      'tablespoons': 'tbsp',
      'tbsp': 'tbsp',
      'teaspoon': 'tsp',
      'teaspoons': 'tsp',
      'tsp': 'tsp',
      'ounce': 'oz',
      'ounces': 'oz',
      'oz': 'oz',
      'pound': 'lb',
      'pounds': 'lb',
      'lb': 'lb',
      'lbs': 'lb',
      'gram': 'g',
      'grams': 'g',
      'g': 'g',
      'kilogram': 'kg',
      'kilograms': 'kg',
      'kg': 'kg',
      'milligram': 'mg',
      'milligrams': 'mg',
      'mg': 'mg',
      'slices': 'slice',
      'slice': 'slice',
      'scoop': 'scoop',
      'scoops': 'scoop',
      'can': 'can',
      'cans': 'can',
      'count': 'count',
      'taste': 'to taste',
      'to taste': 'to taste',
    };

    return aliases[normalized] ?? normalized;
  }
}

class IngredientQuantityConverter {
  const IngredientQuantityConverter._();

  static ConversionResult? toGrams({
    required String ingredientName,
    required QuantityMeasurement measurement,
  }) {
    final normalizedName = ingredientName.trim().toLowerCase();
    final unit = measurement.normalizedUnit;
    final amount = measurement.amount;

    final overrides = _ingredientUnitOverrides[normalizedName];
    if (overrides != null && amount != null) {
      final overrideFactor = overrides[unit];
      if (overrideFactor != null) {
        return ConversionResult(
          grams: amount * overrideFactor,
          isEstimate: unit != 'g' && unit != 'mg' && unit != 'kg',
        );
      }
    }

    if (unit == 'count' && amount != null) {
      final perCount = _ingredientCountEstimates[normalizedName];
      if (perCount != null) {
        return ConversionResult(
          grams: amount * perCount,
          isEstimate: true,
        );
      }
    }

    if (amount != null) {
      final factor = _genericUnitToGramFactor[unit];
      if (factor != null) {
        return ConversionResult(
          grams: amount * factor,
          isEstimate: unit != 'g' && unit != 'kg' && unit != 'mg',
        );
      }
    }

    final fallback = _ingredientFallbackEstimates[normalizedName];
    if (fallback != null) {
      final multiplier = amount ?? 1;
      return ConversionResult(
        grams: multiplier * fallback,
        isEstimate: true,
      );
    }

    return null;
  }

  static const Map<String, double> _genericUnitToGramFactor = {
    'g': 1,
    'kg': 1000,
    'mg': 0.001,
    'oz': 28.3495,
    'lb': 453.592,
    'cup': 240,
    'tbsp': 15,
    'tsp': 5,
    'scoop': 30,
    'slice': 30,
    'can': 400,
  };

  static const Map<String, Map<String, double>> _ingredientUnitOverrides = {
    'almond butter': {'tbsp': 16},
    'almond milk': {'cup': 240},
    'balsamic glaze': {'tbsp': 20},
    'black beans': {'cup': 170},
    'brown rice': {'cup': 195},
    'carrot sticks': {'cup': 128},
    'cherry tomatoes': {'cup': 150},
    'chia seeds': {'tbsp': 12},
    'cooked oatmeal': {'cup': 234},
    'cooked quinoa': {'cup': 185},
    'dried cranberries': {'tbsp': 10},
    'dark chocolate chips': {'tbsp': 14},
    'edamame': {'cup': 155},
    'feta cheese': {'tbsp': 14},
    'fresh berries': {'cup': 150},
    'fresh mozzarella': {'slice': 28},
    'garlic olive oil': {'tbsp': 14},
    'granola': {'cup': 100},
    'green beans': {'cup': 125},
    'greek yogurt': {
      'cup': 245,
      'tbsp': 15,
    },
    'grilled peppers': {'cup': 92},
    'honey': {'tsp': 7},
    'hummus': {
      'tbsp': 15,
      'cup': 240,
    },
    'light caesar dressing': {'tbsp': 15},
    'low-fat cottage cheese': {'cup': 226},
    'maple syrup': {'tbsp': 20},
    'mixed berries': {'cup': 150},
    'mixed greens': {'cup': 30},
    'mixed nuts': {'cup': 132},
    'mixed vegetables': {'cup': 128},
    'mushrooms': {'cup': 70},
    'olive oil': {'tbsp': 14},
    'olive oil dressing': {'tbsp': 14},
    'parmesan cheese': {'tbsp': 5},
    'peanut butter': {'tbsp': 16},
    'pineapple chunks': {'cup': 165},
    'plain greek yogurt': {'cup': 245},
    'protein powder': {'scoop': 30},
    'roasted asparagus': {'cup': 134},
    'roasted broccoli': {'cup': 156},
    'roasted carrots': {'cup': 140},
    'roasted chickpeas': {'cup': 164},
    'romaine lettuce': {'cup': 47},
    'salsa': {'tbsp': 16},
    'shredded cheese': {'tbsp': 7},
    'shredded lettuce': {'cup': 35},
    'spinach': {'cup': 30},
    'tahini dressing': {'tbsp': 15},
    'teriyaki sauce': {'tbsp': 18},
    'tomatoes': {'cup': 180},
    'tuna in water': {'can': 165},
    'whole grain bread': {'slice': 32},
    'whole grain croutons': {'cup': 60},
  };

  static const Map<String, double> _ingredientCountEstimates = {
    'avocado': 200,
    'banana': 118,
    'celery sticks': 12,
    'cherry tomatoes': 17,
    'corn tortillas': 30,
    'cucumber': 200,
    'diced tomato': 120,
    'egg': 50,
    'grilled zucchini': 200,
    'hard-boiled egg': 50,
    'large eggs': 50,
    'lemon wedge': 15,
    'medium apple': 182,
    'medium banana': 118,
    'medium pear': 178,
    'medium sweet potato': 200,
    'olives': 4,
    'protein bar': 60,
    'rice cakes': 9,
    'scrambled eggs': 50,
    'string cheese': 28,
    'whole grain pancakes': 65,
    'whole wheat tortilla': 50,
  };

  static const Map<String, double> _ingredientFallbackEstimates = {
    'herbs and lemon': 5,
    'herbs and spices': 4,
    'sea salt': 3,
  };
}
