import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/goal_type_enum.dart';
import '../models/goal.dart';
import '../models/food.dart';
import '../utils/date_utils.dart';
import 'food_provider.dart';

final goalProvider = StateNotifierProvider<GoalNotifier, List<Goal>>((ref) => GoalNotifier(ref));

class GoalNotifier extends StateNotifier<List<Goal>> {
  final Ref ref;

  GoalNotifier(this.ref) : super([]) {
    _loadGoalsAndUpdateStatus();

    ref.listen<List<Food>>(foodProvider, (previous, next) {
      _updateGoalsStatus();
    });
  }

  Future<void> _loadGoalsAndUpdateStatus() async {
    await _loadGoals();
    _updateGoalsStatus();
  }

  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final goalsString = prefs.getString('goals');

    if (goalsString != null) {
      final loadedGoals = (json.decode(goalsString) as List).map((goalJson) => Goal.fromMap(goalJson)).toList();

      // Ordena as metas conforme especificado
      loadedGoals.sort((a, b) {
        // Primeiro, prioriza metas não atingidas sobre as atingidas
        if (a.achieved != b.achieved) {
          return a.achieved! ? 1 : -1;
        }

        // Dentro dos grupos, ordena pelo tipo de meta
        int typeComparison = _compareGoalTypes(a.type, b.type);
        if (typeComparison != 0) {
          return typeComparison;
        }

        // No mesmo grupo, ordena pela data de início
        return a.startsAt.compareTo(b.startsAt);
      });

      state = loadedGoals;
    }
  }

  int _compareGoalTypes(GoalTypeEnum a, GoalTypeEnum b) {
    const typeOrder = {
      GoalTypeEnum.daily: 0,
      GoalTypeEnum.weekly: 1,
      GoalTypeEnum.monthly: 2,
      GoalTypeEnum.yearly: 3,
    };
    return typeOrder[a]!.compareTo(typeOrder[b]!);
  }

  void _updateGoalsStatus() {
    final foods = ref.read(foodProvider);

    state = state.map((goal) {
      final totalCalories = _calculateCaloriesForGoal(goal, foods);
      return goal.copyWith(
        reached: totalCalories >= goal.target ? goal.target : totalCalories,
        achieved: totalCalories >= goal.target,
      );
    }).toList();

    _sortGoals(); // Ordena novamente após update das metas
    _saveGoals();
  }

  int _calculateCaloriesForGoal(Goal goal, List<Food> foods) {
    DateTime startDate = DateTime(goal.startsAt.year, goal.startsAt.month, goal.startsAt.day);
    DateTime endDate = DateTime(goal.endsAt.year, goal.endsAt.month, goal.endsAt.day).add(Duration(days: 1));

    return foods.where((food) {
      DateTime foodDate = DateTime(food.consumedAt.year, food.consumedAt.month, food.consumedAt.day);

      return (foodDate.isAfter(startDate) || isSameDay(foodDate, startDate)) && foodDate.isBefore(endDate);
    }).fold(0, (sum, food) => sum + food.calories);
  }

  Future<void> addGoal(Goal goal) async {
    state = [...state, goal];
    _updateGoalsStatus();
    _sortGoals(); // Ordena novamente após atualizar o status das metas
    await _saveGoals();
  }

  Future<void> editGoal(Goal editedGoal) async {
    state = state.map((goal) => goal.id == editedGoal.id ? editedGoal : goal).toList();
    _updateGoalsStatus();
    _sortGoals(); // Ordena novamente após atualizar o status das metas
    await _saveGoals();
  }

  Future<void> removeGoal(int id) async {
    state = state.where((goal) => goal.id != id).toList();
    _sortGoals(); // Ordena novamente após remover a meta
    await _saveGoals();
  }

  void _sortGoals() {
    state.sort((a, b) {
      // Primeiro, prioriza metas não atingidas sobre as atingidas
      if (a.achieved != b.achieved) {
        return a.achieved! ? 1 : -1;
      }

      // Dentro dos grupos, ordena pelo tipo de meta
      int typeComparison = _compareGoalTypes(a.type, b.type);
      if (typeComparison != 0) {
        return typeComparison;
      }

      // No mesmo grupo, ordena pela data de início
      return a.startsAt.compareTo(b.startsAt);
    });
  }

  Future<void> _saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final String goalsString = json.encode(state.map((goal) => goal.toMap()).toList());
    await prefs.setString('goals', goalsString);
  }
}
