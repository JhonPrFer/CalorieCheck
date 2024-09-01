import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: acionar a opção de adicionar alimento
Future<void> acionarAOpcaoDeAdicionarAlimento(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.add));
}
