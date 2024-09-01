import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: editar a quantidade de calorias para 4000
Future<void> editarAQuantidadeDeCaloriasPara4000(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, '4000');
  await tester.tap(find.text('Salvar'));
}
