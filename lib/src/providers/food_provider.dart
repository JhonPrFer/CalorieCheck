import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/food.dart';

final foodProvider = StateNotifierProvider<FoodNotifier, List<Food>>((ref) => FoodNotifier());

class FoodNotifier extends StateNotifier<List<Food>> {
  FoodNotifier() : super([]) {
    _loadFoods();
  }

  void _loadFoods() async {
    final prefs = await SharedPreferences.getInstance();
    final foodString = prefs.getString('foods');

    if (foodString != null) {
      final List<dynamic> foodList = jsonDecode(foodString);
      state = foodList.map((item) => Food.fromMap(item)).toList()..sort((a, b) => b.consumedAt.compareTo(a.consumedAt));
    }
  }

  void addFood(Food food) async {
    state = [
      food,
      ...state,
    ]..sort((a, b) => b.consumedAt.compareTo(a.consumedAt));
    await _saveFoods();
  }

  Future<void> editFood(Food editedFood) async {
    state = state.map((food) => food.id == editedFood.id ? editedFood : food).toList()
      ..sort((a, b) => b.consumedAt.compareTo(a.consumedAt));
    await _saveFoods();
  }

  void removeFood(int id) async {
    state = state.where((food) => food.id != id).toList();
    await _saveFoods();
  }

  Future<void> _saveFoods() async {
    final prefs = await SharedPreferences.getInstance();
    final foodString = jsonEncode(state.map((food) => food.toMap()).toList());
    await prefs.setString('foods', foodString);
  }

  int getTodayCalories() {
    final today = DateTime.now();
    return state
        .where((food) =>
            food.consumedAt.year == today.year &&
            food.consumedAt.month == today.month &&
            food.consumedAt.day == today.day)
        .fold(0, (sum, food) => sum + food.calories);
  }
}
