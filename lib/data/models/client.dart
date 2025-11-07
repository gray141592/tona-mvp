class Client {
  final String id;
  final String name;
  final String email;
  final String? nutritionistId;
  final String mealPlanId;
  final DateTime createdAt;
  final DateTime? lastActiveAt;

  const Client({
    required this.id,
    required this.name,
    required this.email,
    this.nutritionistId,
    required this.mealPlanId,
    required this.createdAt,
    this.lastActiveAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'nutritionist_id': nutritionistId,
      'meal_plan_id': mealPlanId,
      'created_at': createdAt.toIso8601String(),
      'last_active_at': lastActiveAt?.toIso8601String(),
    };
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      nutritionistId: json['nutritionist_id'] as String?,
      mealPlanId: json['meal_plan_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastActiveAt: json['last_active_at'] != null
          ? DateTime.parse(json['last_active_at'] as String)
          : null,
    );
  }
}
