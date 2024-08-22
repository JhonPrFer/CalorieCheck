import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../providers/exercice_provider.dart';
import '../../../models/exercice.dart';

void showExerciceDialog(BuildContext context, WidgetRef ref, {Exercice? exercice}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ExerciceDialog(exercice: exercice);
    },
  );
}

class ExerciceDialog extends ConsumerStatefulWidget {
  final Exercice? exercice;

  const ExerciceDialog({Key? key, this.exercice}) : super(key: key);

  @override
  _ExerciceDialogState createState() => _ExerciceDialogState();
}

class _ExerciceDialogState extends ConsumerState<ExerciceDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _calories;
  DateTime? _executedAt;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.exercice != null;
    if (_isEditing) {
      _name = widget.exercice!.name;
      _calories = widget.exercice!.calories;
      _executedAt = widget.exercice!.executedAt;
    } else {
      _name = '';
      _calories = 0;
      _executedAt = DateTime.now();
    }
  }

  void _saveExercice() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final exercice = Exercice(
        id: _isEditing ? widget.exercice!.id : DateTime.now().millisecondsSinceEpoch,
        name: _name,
        calories: _calories,
        executedAt: _executedAt ?? DateTime.now(),
      );
      if (_isEditing) {
        ref.read(exerciceProvider.notifier).editExercice(exercice);
      } else {
        ref.read(exerciceProvider.notifier).addExercice(exercice);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Editar Exercício' : 'Novo Exercício'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome/Descrição'),
              initialValue: _name,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um nome ou descrição.';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Quantidade de Calorias'),
              initialValue: _calories.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma quantidade de calorias.';
                }
                return null;
              },
              onSaved: (value) {
                _calories = int.parse(value!);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(
                  _executedAt != null ? DateFormat('dd/MM/yyyy').format(_executedAt!) : 'Selecione uma data',
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit_calendar, color: Colors.blue),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _executedAt!,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _executedAt = pickedDate; // Atualiza o estado e reconstrói o widget
                      });
                    }
                  },
                ),
              ],
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
          onPressed: _saveExercice,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
