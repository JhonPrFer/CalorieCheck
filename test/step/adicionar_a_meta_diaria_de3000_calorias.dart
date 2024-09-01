import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: adicionar a meta diaria de 3000 calorias
Future<void> adicionarAMetaDiariaDe3000Calorias(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, '3000');
  await tester.tap(find.text('Salvar'));
}
