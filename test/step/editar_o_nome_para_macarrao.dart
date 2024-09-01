import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: editar o nome para macarrao
Future<void> editarONomeParaMacarrao(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, 'macarrão');
  await tester.tap(find.text('Salvar'));
}
