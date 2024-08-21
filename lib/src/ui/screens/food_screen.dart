import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/food.dart';
import '../../providers/food_provider.dart';
import '../widgets/food_list_item.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foods = ref.watch(foodProvider);
    final totalCalories = ref.read(foodProvider.notifier).getTodayCalories();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alimentos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () async {
              final newFood = await _showAddFoodDialog(context);
              if (newFood != null) {
                ref.read(foodProvider.notifier).addFood(newFood);
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
              child: Column(
                children: [
                  const Text(
                    'Hoje',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          offset: Offset(1.4, 1.4),
                          blurRadius: 3.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+$totalCalories kcal',
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                      shadows: [
                        Shadow(
                          offset: Offset(1.4, 1.4),
                          blurRadius: 3.0,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: foods.isEmpty
                  ? const Center(child: Text('Nenhum alimento adicionado hoje.'))
                  : ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return FoodListItem(food: foods[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Food?> _showAddFoodDialog(BuildContext context) async {
    final _nameController = TextEditingController();
    final _caloriesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return showDialog<Food>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Alimento'),
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
                final id = DateTime.now().millisecondsSinceEpoch;
                final name = _nameController.text;
                final calories = int.tryParse(_caloriesController.text) ?? 0;
                final food = Food(
                  id: id,
                  name: name,
                  calories: calories,
                  consumedAt: selectedDate,
                );
                Navigator.of(context).pop(food);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
