class MealIngredient {
  final String name;
  final String quantity;

  const MealIngredient({
    required this.name,
    this.quantity = '',
  });

  String get displayLabel => quantity.isEmpty ? name : '$quantity $name'.trim();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }

  factory MealIngredient.fromJson(Map<String, dynamic> json) {
    return MealIngredient(
      name: json['name'] as String,
      quantity: json['quantity'] as String? ?? '',
    );
  }
}
