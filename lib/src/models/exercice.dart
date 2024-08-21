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
      'executedAt': executedAt.toIso8601String(),
    };
  }

  factory Exercice.fromMap(Map<String, dynamic> map) {
    if (map['id'] == null || map['name'] == null || map['calories'] == null || map['executedAt'] == null) {
      throw ArgumentError('Missing required fields in the map');
    }

    return Exercice(
      id: map['id'],
      name: map['name'],
      calories: map['calories'],
      executedAt: DateTime.parse(map['executedAt']),
    );
  }
}
