import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/goal.dart';
import '../../enums/goal_type_enum.dart';
import '../../providers/goal_provider.dart';
import '../widgets/forms/goal_form_item.dart'; // Certifique-se de importar o GoalDialog

class GoalListItem extends ConsumerWidget {
  final Goal goal;

  const GoalListItem({super.key, required this.goal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Espaçamento entre os cards
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Bordas arredondadas
        child: Dismissible(
          key: Key(goal.id.toString()),
          background: _buildDismissBackground(
            context,
            color: Colors.blue,
            icon: Icons.edit,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20.0),
          ),
          secondaryBackground: _buildDismissBackground(
            context,
            color: Colors.red,
            icon: Icons.delete,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final shouldDelete = await _confirmDeletion(context);
              return shouldDelete ?? false;
            } else if (direction == DismissDirection.startToEnd) {
              showGoalDialog(context, ref, goal: goal);
            }
            return false;
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              ref.read(goalProvider.notifier).removeGoal(goal.id);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: goal.achieved == true ? Color.fromARGB(255, 76, 175, 80) : Color.fromARGB(255, 233, 30, 23),
                  width: 5.0, // Largura da borda lateral
                ),
              ),
            ),
            child: Card(
              margin: EdgeInsets.zero, // Mantém o card sem margens internas
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        getGoalTypeText(goal.type),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${goal.target} kcal',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  '${DateFormat('dd/MM/yyyy').format(goal.startsAt)} - ${DateFormat('dd/MM/yyyy').format(goal.endsAt)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context,
      {required Color color, required IconData icon, required Alignment alignment, required EdgeInsets padding}) {
    return Container(
      color: color,
      alignment: alignment,
      padding: padding,
      child: Icon(icon, color: Colors.white),
    );
  }

  Future<bool?> _confirmDeletion(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Deseja realmente excluir esta meta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Excluir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
