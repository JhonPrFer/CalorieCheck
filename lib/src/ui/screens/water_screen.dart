import 'package:CalorieCheck/src/providers/water_provider.dart';
import 'package:CalorieCheck/src/ui/widgets/displayers/water_displayer.dart';
import 'package:CalorieCheck/src/ui/widgets/forms/water_form_item.dart';
import 'package:CalorieCheck/src/ui/widgets/lists/water_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../enums/result_type_enum.dart';

class WaterScreen extends ConsumerWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waters = ref.watch(waterProvider);
    final totalWater = ref.read(waterProvider.notifier).getTodayLiter();

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
            onPressed: () => showWaterDialog(context, ref),
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
              child: waters.isEmpty
                  ? const Center(
                      child: Text('Nenhuma quantidade de água adicionada.'))
                  : ListView.builder(
                      itemCount: waters.length,
                      itemBuilder: (context, index) {
                        return WaterListItem(water: waters[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
