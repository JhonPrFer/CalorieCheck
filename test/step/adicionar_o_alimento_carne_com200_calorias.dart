import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: adicionar o alimento carne com 200 calorias
Future<void> adicionarOAlimentoCarneCom200Calorias(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, 'carne');
  await tester.enterText(find.byType(TextField).last, '200');
  await tester.tap(find.text('Salvar'));
}
