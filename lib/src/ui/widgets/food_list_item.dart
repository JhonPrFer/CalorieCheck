import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/food.dart';
import '../../providers/food_provider.dart';

class FoodListItem extends ConsumerWidget {
  final Food food;

  const FoodListItem({super.key, required this.food});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          food.name,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${food.calories} kcal',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Cor do primeiro texto (calorias)
                ),
              ),
              const TextSpan(
                  text: ' ', // Espaço entre as informações
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                text: DateFormat('dd/MM/yyyy').format(food.consumedAt),
                style: const TextStyle(
                  fontSize: 12, // Tamanho menor para a data
                  color: Color(0xFF4CAF50), // Cor verde para a data
                ),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final updatedFood = await _showEditFoodDialog(context, food);
                if (updatedFood != null) {
                  ref.read(foodProvider.notifier).removeFood(food.id);
                  ref.read(foodProvider.notifier).addFood(updatedFood);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                ref.read(foodProvider.notifier).removeFood(food.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Food?> _showEditFoodDialog(BuildContext context, Food food) async {
    final _nameController = TextEditingController(text: food.name);
    final _caloriesController = TextEditingController(text: food.calories.toString());
    DateTime? selectedDate = food.consumedAt;

    return showDialog<Food>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Alimento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _caloriesController,
                decoration: const InputDecoration(labelText: 'Calorias Ganhas'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(
                    selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : 'Selecione uma data',
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit_calendar, color: Colors.blue),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate!,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        selectedDate = pickedDate;
                      }
                    },
                  ),
                ],
              ),
            ],
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
                final updatedFood = Food(
                  id: food.id,
                  name: _nameController.text,
                  calories: int.tryParse(_caloriesController.text) ?? 0,
                  consumedAt: selectedDate ?? DateTime.now(),
                );
                Navigator.of(context).pop(updatedFood);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
