import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavProvider = StateNotifierProvider<BottomNavNotifier, int>((ref) {
  return BottomNavNotifier();
});

class BottomNavNotifier extends StateNotifier<int> {
  BottomNavNotifier() : super(0); // Começa com o índice 0 (primeira aba)

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}
