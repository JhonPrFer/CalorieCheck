import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/goal.dart';
import '../models/food.dart';
import 'food_provider.dart'; // Certifique-se de importar o foodProvider

final goalProvider = StateNotifierProvider<GoalNotifier, List<Goal>>((ref) => GoalNotifier(ref));

class GoalNotifier extends StateNotifier<List<Goal>> {
  final Ref ref;

  GoalNotifier(this.ref) : super([]) {
    _loadGoalsAndUpdateStatus();
  }

  Future<void> _loadGoalsAndUpdateStatus() async {
    await _loadGoals(); // Carregar as metas
    _updateGoalsStatus(); // Atualizar o status das metas com base nos alimentos
  }

  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final goalsString = prefs.getString('goals');

    if (goalsString != null) {
      final loadedGoals = (json.decode(goalsString) as List).map((goalJson) => Goal.fromMap(goalJson)).toList()
        ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
      state = loadedGoals;
    }
  }

  void _updateGoalsStatus() {
    final foods = ref.read(foodProvider);

    // Para cada meta, verificar se foi atingida
    state = state.map((goal) {
      final totalCalories = _calculateCaloriesForGoal(goal, foods);
      if (totalCalories >= goal.target) {
        return goal.copyWith(achieved: true);
      } else {
        return goal.copyWith(achieved: false);
      }
    }).toList();

    _saveToPreferences(); // Salva o estado atualizado
  }

  int _calculateCaloriesForGoal(Goal goal, List<Food> foods) {
    return foods
        .where((food) =>
            food.consumedAt.isAfter(goal.startsAt) && food.consumedAt.isBefore(goal.endsAt.add(Duration(days: 1))))
        .fold(0, (sum, food) => sum + food.calories);
  }

  Future<void> addGoal(Goal goal) async {
    state = [...state, goal]..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    _updateGoalsStatus();
    await _saveToPreferences();
  }

  Future<void> editGoal(Goal editedGoal) async {
    state = state.map((goal) => goal.id == editedGoal.id ? editedGoal : goal).toList()
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    _updateGoalsStatus();
    await _saveToPreferences();
  }

  Future<void> removeGoal(int id) async {
    state = state.where((goal) => goal.id != id).toList();
    await _saveToPreferences();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String goalsString = json.encode(state.map((goal) => goal.toMap()).toList());
    await prefs.setString('goals', goalsString);
  }
}
