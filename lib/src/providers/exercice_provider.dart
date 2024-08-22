import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/exercice.dart';

final exerciceProvider = StateNotifierProvider<ExerciceNotifier, List<Exercice>>((ref) => ExerciceNotifier());

class ExerciceNotifier extends StateNotifier<List<Exercice>> {
  ExerciceNotifier() : super([]) {
    _loadExercices();
  }

  void _loadExercices() async {
    final prefs = await SharedPreferences.getInstance();
    final exerciceString = prefs.getString('exercices');

    if (exerciceString != null) {
      final List<dynamic> exerciceList = jsonDecode(exerciceString);
      state = exerciceList.map((item) => Exercice.fromMap(item)).toList()
        ..sort((a, b) => b.executedAt.compareTo(a.executedAt));
    }
  }

  void addExercice(Exercice exercice) async {
    state = [
      exercice,
      ...state,
    ]..sort((a, b) => b.executedAt.compareTo(a.executedAt));
    await _saveExercices();
  }

  Future<void> editExercice(Exercice editedExercice) async {
    state = state.map((exercice) => exercice.id == editedExercice.id ? editedExercice : exercice).toList()
      ..sort((a, b) => b.executedAt.compareTo(a.executedAt));
    await _saveExercices();
  }

  void removeExercice(int id) async {
    state = state.where((exercice) => exercice.id != id).toList();
    await _saveExercices();
  }

  Future<void> _saveExercices() async {
    final prefs = await SharedPreferences.getInstance();
    final exerciceString = jsonEncode(state.map((exercice) => exercice.toMap()).toList());
    await prefs.setString('exercices', exerciceString);
  }

  int getTodayCalories() {
    final today = DateTime.now();
    return state
        .where((exercice) =>
            exercice.executedAt.year == today.year &&
            exercice.executedAt.month == today.month &&
            exercice.executedAt.day == today.day)
        .fold(0, (sum, exercice) => sum + exercice.calories);
  }
}
