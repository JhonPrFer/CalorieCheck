import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/bottom_nav_provider.dart'; // Importação do StateNotifier
import 'food_screen.dart';
import 'exercice_screen.dart';
import 'goal_screen.dart';
import 'report_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider); // Observa o índice selecionado
    final navNotifier = ref.read(bottomNavProvider.notifier); // Referência para o StateNotifier

    Widget content;
    switch (selectedIndex) {
      case 0:
        content = const FoodScreen();
        break;
      case 1:
        content = const ExerciceScreen();
        break;
      case 2:
        content = const GoalScreen();
        break;
      case 3:
        content = const ReportScreen();
        break;
      default:
        content = const Center(child: Text('Tela não encontrada'));
    }

    return Scaffold(
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => navNotifier.updateIndex(index), // Atualiza o índice selecionado
        currentIndex: selectedIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF4CAF50),
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Alimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercícios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Metas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Relatórios',
          ),
        ],
      ),
    );
  }
}
