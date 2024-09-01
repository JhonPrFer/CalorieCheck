class Water {
  int id;
  int quantity;
  DateTime consumedAt;

  Water({
    required this.id,
    required this.quantity,
    required this.consumedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'consumedAt': consumedAt.toIso8601String(),
    };
  }

  factory Water.fromMap(Map<String, dynamic> map) {
    if (map['id'] == null ||
        map['quantity'] == null ||
        map['consumedAt'] == null) {
      throw ArgumentError('Missing required fields in the map');
    }

    return Water(
      id: map['id'],
      quantity: map['quantity'],
      consumedAt: DateTime.parse(map['consumedAt']),
    );
  }
}
