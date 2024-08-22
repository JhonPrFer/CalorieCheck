import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../enums/result_type_enum.dart';
import '../../providers/exercice_provider.dart';
import '../widgets/lists/exercice_list_item.dart';
import '../widgets/displayers/calories_displayer.dart';
import '../widgets/forms/exercice_form_item.dart';

class ExerciceScreen extends ConsumerWidget {
  const ExerciceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercices = ref.watch(exerciceProvider);
    final totalCalories = ref.read(exerciceProvider.notifier).getTodayCalories();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercícios',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () => showExerciceDialog(context, ref),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CaloriesDisplay(totalCalories: totalCalories, type: ResultTypeEnum.loss),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: exercices.isEmpty
                  ? const Center(child: Text('Nenhum exercício adicionado.'))
                  : ListView.builder(
                      itemCount: exercices.length,
                      itemBuilder: (context, index) {
                        return ExerciceListItem(exercice: exercices[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
