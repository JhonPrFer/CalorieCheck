import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../providers/food_provider.dart';
import '../../../models/food.dart';

void showFoodDialog(BuildContext context, WidgetRef ref, {Food? food}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FoodDialog(food: food);
    },
  );
}

class FoodDialog extends ConsumerStatefulWidget {
  final Food? food;

  const FoodDialog({Key? key, this.food}) : super(key: key);

  @override
  _FoodDialogState createState() => _FoodDialogState();
}

class _FoodDialogState extends ConsumerState<FoodDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _calories;
  DateTime? _consumedAt;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.food != null;
    if (_isEditing) {
      _name = widget.food!.name;
      _calories = widget.food!.calories;
      _consumedAt = widget.food!.consumedAt;
    } else {
      _name = '';
      _calories = 0;
      _consumedAt = DateTime.now();
    }
  }

  void _saveFood() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final food = Food(
        id: _isEditing ? widget.food!.id : DateTime.now().millisecondsSinceEpoch,
        name: _name,
        calories: _calories,
        consumedAt: _consumedAt ?? DateTime.now(),
      );
      if (_isEditing) {
        ref.read(foodProvider.notifier).editFood(food);
      } else {
        ref.read(foodProvider.notifier).addFood(food);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Editar Alimento' : 'Novo Alimento'),
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
                  _consumedAt != null ? DateFormat('dd/MM/yyyy').format(_consumedAt!) : 'Selecione uma data',
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit_calendar, color: Colors.blue),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _consumedAt!,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _consumedAt = pickedDate; // Atualiza o estado e reconstrói o widget
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
          onPressed: _saveFood,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
