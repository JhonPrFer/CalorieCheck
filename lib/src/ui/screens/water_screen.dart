import 'package:CalorieCheck/src/ui/widgets/displayers/water_displayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../enums/result_type_enum.dart';
import '../../providers/food_provider.dart';
import '../widgets/forms/food_form_item.dart';
import '../widgets/lists/food_list_item.dart';

class WaterScreen extends ConsumerWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foods = ref.watch(foodProvider);
    final totalWater = ref.read(foodProvider.notifier).getTodayCalories();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Água',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
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
              child: WaterDisplay(
                  totalWater: totalWater, type: ResultTypeEnum.gain),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: foods.isEmpty
                  ? const Center(child: Text('Nenhuma água adicionado.'))
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
