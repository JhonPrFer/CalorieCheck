class Food {
  int id;
  String name;
  int calories;
  DateTime consumedAt;

  Food({
    required this.id,
    required this.name,
    required this.calories,
    required this.consumedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'consumedAt': consumedAt.toIso8601String(),
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      name: map['name'],
      calories: map['calories'],
      consumedAt: DateTime.parse(map['consumedAt']),
    );
  }
}
