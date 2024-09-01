import 'package:CalorieCheck/src/models/water.dart';
import 'package:CalorieCheck/src/providers/water_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/food.dart';
import '../../../providers/food_provider.dart';

void showWaterDialog(BuildContext context, WidgetRef ref, {Water? water}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WaterDialog(water: water);
    },
  );
}

class WaterDialog extends ConsumerStatefulWidget {
  final Water? water;

  const WaterDialog({Key? key, this.water}) : super(key: key);

  @override
  _WaterDialogState createState() => _WaterDialogState();
}

class _WaterDialogState extends ConsumerState<WaterDialog> {
  final _formKey = GlobalKey<FormState>();
  late int _quantity;
  DateTime? _consumedAt;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.water != null;
    if (_isEditing) {
      _quantity = widget.water!.quantity;
      _consumedAt = widget.water!.consumedAt;
    } else {
      _quantity = 0;
      _consumedAt = DateTime.now();
    }
  }

  void _saveWater() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final water = Water(
        id: _isEditing
            ? widget.water!.id
            : DateTime.now().millisecondsSinceEpoch,
        quantity: _quantity,
        consumedAt: _consumedAt ?? DateTime.now(),
      );
      if (_isEditing) {
        ref.read(waterProvider.notifier).editWater(water);
      } else {
        ref.read(waterProvider.notifier).editWater(water);
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
              decoration:
                  const InputDecoration(labelText: 'Quantidade de Calorias'),
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
                  _consumedAt != null
                      ? DateFormat('dd/MM/yyyy').format(_consumedAt!)
                      : 'Selecione uma data',
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
                        _consumedAt =
                            pickedDate; // Atualiza o estado e reconstrói o widget
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
