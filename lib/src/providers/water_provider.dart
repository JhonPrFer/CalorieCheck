import 'dart:convert';

import 'package:CalorieCheck/src/models/water.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final waterProvider =
    StateNotifierProvider<WaterNotifier, List<Water>>((ref) => WaterNotifier());

class WaterNotifier extends StateNotifier<List<Water>> {
  WaterNotifier() : super([]) {
    _loadWater();
  }

  void _loadWater() async {
    final prefs = await SharedPreferences.getInstance();
    final waterString = prefs.getString('water');

    if (waterString != null) {
      final List<dynamic> waterList = jsonDecode(waterString);
      state = waterList.map((item) => Water.fromMap(item)).toList()
        ..sort((a, b) => b.consumedAt.compareTo(a.consumedAt));
    }
  }

  void addWater(Water water) async {
    state = [
      water,
      ...state,
    ]..sort((a, b) => b.consumedAt.compareTo(a.consumedAt));
    await _saveWater();
  }

  Future<void> editWater(Water editedWater) async {
    state = state
        .map((water) => water.id == editedWater.id ? editedWater : water)
        .toList()
      ..sort((a, b) => b.consumedAt.compareTo(a.consumedAt));
    await _saveWater();
  }

  void removeWater(int id) async {
    state = state.where((water) => water.id != id).toList();
    await _saveWater();
  }

  Future<void> _saveWater() async {
    final prefs = await SharedPreferences.getInstance();
    final waterString = jsonEncode(state.map((water) => water.toMap()).toList());
    await prefs.setString('water', waterString);
  }

  int getTodayLiter() {
    final today = DateTime.now();
    return state
        .where((water) =>
            water.consumedAt.year == today.year &&
            water.consumedAt.month == today.month &&
            water.consumedAt.day == today.day)
        .fold(0, (sum, water) => sum + water.quantity);
  }
}
