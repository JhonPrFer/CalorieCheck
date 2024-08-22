import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/goal_provider.dart';
import '../widgets/goal_list_item.dart';
import '../widgets/forms/goal_form_item.dart';

class GoalScreen extends ConsumerWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () => showGoalDialog(context, ref),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: goals.isEmpty
                  ? const Center(child: Text('Nenhuma meta adicionada.'))
                  : ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        return GoalListItem(goal: goals[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
