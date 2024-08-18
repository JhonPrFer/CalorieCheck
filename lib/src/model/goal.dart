class Goal {
  int id;
  String type;
  int target;
  bool? achieved = false;
  DateTime? startsAt;
  DateTime? endsAt;

  Goal(this.id, this.type, this.target);
  Goal.withoutDates(this.id, this.type, this.target, this.achieved);
  Goal.withDates(this.id, this.type, this.target, this.achieved, this.startsAt, this.endsAt);
}
