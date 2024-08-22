import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/food_provider.dart';
import '../widgets/lists/food_list_item.dart';
import '../widgets/displayers/calories_displayer.dart';
import '../../enums/result_type_enum.dart';
import '../widgets/forms/food_form_item.dart';

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
            onPressed: () => showFoodDialog(context, ref),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CaloriesDisplay(totalCalories: totalCalories, type: ResultTypeEnum.gain),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: foods.isEmpty
                  ? const Center(child: Text('Nenhum alimento adicionado.'))
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
}
