import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: editar o nome para corrida
Future<void> editarONomeParaCorrida(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, 'corrida');
  await tester.tap(find.text('Salvar'));
}
