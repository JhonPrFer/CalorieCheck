enum GoalTypeEnum { daily, weekly, monthly, yearly }

String getGoalTypeText(GoalTypeEnum type) {
  switch (type) {
    case GoalTypeEnum.daily:
      return 'Diária';
    case GoalTypeEnum.weekly:
      return 'Semanal';
    case GoalTypeEnum.monthly:
      return 'Mensal';
    case GoalTypeEnum.yearly:
      return 'Anual';
    default:
      return '';
  }
}
