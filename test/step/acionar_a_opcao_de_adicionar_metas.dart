import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: acionar a opção de adicionar metas
Future<void> acionarAOpcaoDeAdicionarMetas(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.add));
}
