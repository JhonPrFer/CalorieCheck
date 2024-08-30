import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: adicionar o exercicio musculação com 200 calorias
Future<void> adicionarOExercicioMusculacaoCom200Calorias(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, 'musculação');
  await tester.enterText(find.byType(TextField).last, '200');
  await tester.tap(find.text('Salvar'));
}
