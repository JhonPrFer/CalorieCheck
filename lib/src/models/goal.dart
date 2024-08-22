import '../enums/goal_type_enum.dart';

class Goal {
  int id;
  GoalTypeEnum type;
  int target;
  bool? achieved;
  DateTime startsAt;
  DateTime endsAt;

  Goal(
      {required this.id,
      required this.type,
      required this.target,
      this.achieved = false,
      required this.startsAt,
      required this.endsAt});

  Goal copyWith({
    int? id,
    GoalTypeEnum? type,
    int? target,
    bool? achieved,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return Goal(
      id: id ?? this.id,
      type: type ?? this.type,
      target: target ?? this.target,
      achieved: achieved ?? this.achieved,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type.toString().split('.').last,
        'target': target,
        'achieved': achieved,
        'startsAt': startsAt.toIso8601String(),
        'endsAt': endsAt.toIso8601String(),
      };

  static Goal fromMap(Map<String, dynamic> map) {
    if (map['id'] == null ||
        map['type'] == null ||
        map['target'] == null ||
        map['achieved'] == null ||
        map['startsAt'] == null ||
        map['endsAt'] == null) {
      throw ArgumentError('Missing required fields in the map');
    }

    return Goal(
      id: map['id'],
      type: GoalTypeEnum.values.firstWhere((e) => e.toString().split('.').last == map['type']),
      target: map['target'],
      achieved: map['achieved'],
      startsAt: DateTime.parse(map['startsAt']),
      endsAt: DateTime.parse(map['endsAt']),
    );
  }
}
