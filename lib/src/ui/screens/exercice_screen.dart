import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/exercice.dart';
import '../../providers/exercice_provider.dart';
import '../widgets/exercice_list_item.dart';
import '../widgets/calories_displayer.dart';
import '../../enums/result_type_enum.dart';

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
            onPressed: () async {
              final newExercice = await _showAddExerciceDialog(context);
              if (newExercice != null) {
                ref.read(exerciceProvider.notifier).addExercice(newExercice);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exibe as calorias consumidas no centro da tela
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

  Future<Exercice?> _showAddExerciceDialog(BuildContext context) async {
    final _nameController = TextEditingController();
    final _caloriesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return showDialog<Exercice>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Exercício'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  TextField(
                    controller: _caloriesController,
                    decoration: const InputDecoration(labelText: 'Calorias Perdidas'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('dd/MM/yyyy').format(selectedDate),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit_calendar, color: Colors.blue),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: const Color(0xFFFFFFFF),
              ),
              onPressed: () {
                final id = DateTime.now().millisecondsSinceEpoch;
                final name = _nameController.text;
                final calories = int.tryParse(_caloriesController.text) ?? 0;
                final exercice = Exercice(
                  id: id,
                  name: name,
                  calories: calories,
                  executedAt: selectedDate,
                );
                Navigator.of(context).pop(exercice);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
