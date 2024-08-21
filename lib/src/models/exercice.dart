class Exercice {
  int id;
  String name;
  int calories;
  DateTime executedAt;

  Exercice({
    required this.id,
    required this.name,
    required this.calories,
    required this.executedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'consumedAt': executedAt.toIso8601String(),
    };
  }

  factory Exercice.fromMap(Map<String, dynamic> map) {
    return Exercice(
      id: map['id'],
      name: map['name'],
      calories: map['calories'],
      executedAt: DateTime.parse(map['executedAt']),
    );
  }
}
