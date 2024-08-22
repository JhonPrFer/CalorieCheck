import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../providers/goal_provider.dart';
import '../../../enums/goal_type_enum.dart';
import '../../../models/goal.dart';

void showGoalDialog(BuildContext context, WidgetRef ref, {Goal? goal}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GoalDialog(goal: goal);
    },
  );
}

class GoalDialog extends ConsumerStatefulWidget {
  final Goal? goal;

  const GoalDialog({Key? key, this.goal}) : super(key: key);

  @override
  _GoalDialogState createState() => _GoalDialogState();
}

class _GoalDialogState extends ConsumerState<GoalDialog> {
  final _formKey = GlobalKey<FormState>();
  late GoalTypeEnum _selectedType;
  DateTime? _startsAt;
  late int _target;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.goal != null;
    if (_isEditing) {
      _selectedType = widget.goal!.type;
      _target = widget.goal!.target;
      _startsAt = widget.goal!.startsAt;
    } else {
      _selectedType = GoalTypeEnum.daily;
      _target = 0;
      _startsAt = DateTime.now();
    }
  }

  void _saveGoal() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final endsAt = _calculateEndsAt(_startsAt!, _selectedType);
      final goal = Goal(
        id: _isEditing ? widget.goal!.id : DateTime.now().millisecondsSinceEpoch,
        type: _selectedType,
        target: _target,
        startsAt: _startsAt ?? DateTime.now(),
        endsAt: endsAt,
      );
      if (_isEditing) {
        ref.read(goalProvider.notifier).editGoal(goal);
      } else {
        ref.read(goalProvider.notifier).addGoal(goal);
      }
      Navigator.pop(context);
    }
  }

  DateTime _calculateEndsAt(DateTime startsAt, GoalTypeEnum type) {
    switch (type) {
      case GoalTypeEnum.daily:
        return startsAt.add(Duration(days: 1));
      case GoalTypeEnum.weekly:
        return startsAt.add(Duration(days: 7));
      case GoalTypeEnum.monthly:
        return DateTime(startsAt.year, startsAt.month + 1, startsAt.day);
      case GoalTypeEnum.yearly:
        return DateTime(startsAt.year + 1, startsAt.month, startsAt.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Editar Meta' : 'Nova Meta'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<GoalTypeEnum>(
              value: _selectedType,
              onChanged: (GoalTypeEnum? newValue) {
                setState(() {
                  _selectedType = newValue!;
                  _startsAt = DateTime.now();
                });
              },
              items: GoalTypeEnum.values.map((GoalTypeEnum type) {
                return DropdownMenuItem<GoalTypeEnum>(
                  value: type,
                  child: Text(getGoalTypeText(type)),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Tipo de Meta'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Quantidade de Calorias'),
              initialValue: _target.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma meta';
                }
                return null;
              },
              onSaved: (value) {
                _target = int.parse(value!);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Inicia em ${DateFormat('dd/MM/yyyy').format(_startsAt!)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Termina em ${DateFormat('dd/MM/yyyy').format(_calculateEndsAt(_startsAt!, _selectedType))}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _saveGoal,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
